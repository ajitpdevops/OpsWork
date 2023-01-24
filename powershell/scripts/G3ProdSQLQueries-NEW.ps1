Import-Module $env:workspace\G3\G3 -DisableNameChecking -Force

Function Invoke-SQLQueryParallel {
Param(
    [String]$Platform,
    [String[]]$ClientCodeList,
    [String[]]$PropertyIDList,
    [String]$QueryToRun,
    [String]$Path,
    [String]$QueryName,
    [string]$PSKey
)

    Try {

        # Derive the Domain for G3Properties for credentials 
        $Platform = Get-OpsHostEntry $env:Platform
        $ClientCodeList = $env:ClientCodeList
        $PropertyIDList = $env:PropertyIDList 

        #Auto determine platform host
        switch -wildcard ($Platform) {
            "mn5pg3xdbsw101*" { $G3Environment = "ProdCluster01" }
            "mn5pg3xdbsw201*" { $G3Environment = "ProdCluster02" }
            "mn5pg3xdbsw301*" { $G3Environment = "ProdCluster03" }
        }

        $PSKey = $env:G3OpsCreds
        $PSKeySS = ConvertTo-SecureString -String $PSKey -AsPlainText -Force
        $G3Properties = Get-G3Properties -Environment $G3Environment -PSKey $PSKeySS

        # Check if the output folder currently exists, if not create it
        $CheckPath = Test-Path -Path $Path
        If ($CheckPath -eq $true) {
            Write-Output "Folder already exists, continuing"
        }
        Else {
            New-Item -ItemType Directory -Path "$Path" -Force
            Write-Output "Created Folder $Path"
        }

        ## Create runspace pool with min 1 and max 10 runspaces
        $MaxThreads = 10
        $RunspacePool = [runspacefactory]::CreateRunspacePool(1, $MaxThreads)
        $RunspacePool.Open()
        
        # # Create object for runspace output
        $cmds = New-Object -TypeName System.Collections.ArrayList

        #Grab Tenant Database Nodes based on the Input Received from the User from the DBLOC table and stores them in a variable
        
        if ($ClientCodeList) {
            $array = $ClientCodeList -split ","
            foreach ($i in 0..($array.Count-1)) {
                $array[$i] = "'" + $array[$i] + "'"
            }
            $ClientCodes = $array -join ","
            $TenantDatabaseNodes = Invoke-G3SQLCommand `
                -ServerInstance "$($Platform)\G3SQL01" `
                -Database "Global" `
                -Query "SELECT DISTINCT d.Server_Name from Property p join DBLoc d on p.DBLoc_ID = d.DBLoc_ID join Client c ON p.Client_ID = c.Client_ID where p.Status_ID = 1 AND DBType_ID = 4 AND c.Client_Code in ($($ClientCodes)) ORDER BY d.Server_Name" `
                -Credential $($G3Properties.OPSCredentials.SQL)
        } elseif ($PropertyIDList) {        
            $array = $PropertyIDList -split ","
            foreach ($i in 0..($array.Count-1)) {
                $array[$i] = "'" + $array[$i] + "'"
            }
            $PropertyIDs = $array -join ","
            $TenantDatabaseNodes = Invoke-G3SQLCommand `
                -ServerInstance "$($Platform)\G3SQL01" `
                -Database "Global" `
                -Query "select DISTINCT d.Server_Name from Property p join DBLoc d on p.DBLoc_ID = d.DBLoc_ID where p.Status_ID = 1 AND DBType_ID = 4 AND p.Property_ID in ($($PropertyIDs)) ORDER BY d.Server_Name" `
                -Credential $($G3Properties.OPSCredentials.SQL)
        } else {
            $TenantDatabaseNodes = Invoke-G3SQLCommand `
                                    -ServerInstance "$($Platform)\G3SQL01" `
                                    -Database "Global" `
                                    -Query "SELECT DISTINCT d.server_name FROM property p JOIN dbloc d ON p.dbloc_id = d.dbloc_id WHERE p.status_id = 1 AND d.DBType_ID = 4 ORDER BY d.Server_Name" `
                                    -Credential $($G3Properties.OPSCredentials.SQL)
        
        }

        Write-Output "`n#--------------------------------------------------------------------------------#"
        Write-Output "  Platform : $Platform"
        Write-Output "  TenantDBs: $($TenantDatabaseNodes.Server_Name)"
        Write-Output "#--------------------------------------------------------------------------------#"
        
        Foreach ($TenantDatabase in $($TenantDatabaseNodes.Server_Name)) {
            if ($ClientCodeList) {
                $PropertyList_SQLCommand = "SELECT p.Property_ID FROM Property p JOIN DBLoc d ON p.DBLoc_ID = d.DBLoc_ID JOIN Client c ON p.Client_ID = c.Client_ID WHERE p.Status_ID = 1 AND DBType_ID = 4 AND c.Client_Code IN ($($ClientCodes)) AND d.Server_Name = '$($TenantDatabase)'"
                $PropertyList = Invoke-G3SQLCommand `
                                    -ServerInstance "$($Platform)\G3SQL01" `
                                    -Database "Global" `
                                    -Query $PropertyList_SQLCommand `
                                    -Credential $($G3Properties.OPSCredentials.SQL)

            } elseif ($PropertyIDList) {
                $PropertyList_SQLCommand = "SELECT p.Property_ID FROM Property p JOIN DBLoc d ON p.DBLoc_ID = d.DBLoc_ID WHERE p.Status_ID = 1 AND DBType_ID = 4 AND p.Property_ID in ($($PropertyIDs)) AND d.Server_Name = '$($TenantDatabase)'"
                $PropertyList = Invoke-G3SQLCommand `
                                    -ServerInstance "$($Platform)\G3SQL01" `
                                    -Database "Global" `
                                    -Query $PropertyList_SQLCommand `
                                    -Credential $($G3Properties.OPSCredentials.SQL)
            } else {
                $PropertyList_SQLCommand = "SELECT name as Property_ID FROM sys.databases WHERE database_id > 4 AND name NOT IN ('VALIDATION', 'Global', 'BookKeeping', 'DBAUtils', 'IDG', 'Jasper', 'Job', 'Profile', 'Quartz', 'Ratchet', 'ServerAgentJobs')"
                $PropertyList = Invoke-G3SQLCommand `
                                    -ServerInstance "$($TenantDatabase)\G3SQL01" `
                                    -Database "master" `
                                    -Query $PropertyList_SQLCommand `
                                    -Credential $($G3Properties.OPSCredentials.SQL)
            }

            #Create parameters object to pass variables
            $Query = $QueryToRun
            $Path = $Path
            $QueryName = $QueryName
            $ServerInstance = "$($TenantDatabase)\G3SQL01"
            $Server = $TenantDatabase
            $Properties = $PropertyList.Property_ID
            $Credential = $($G3Properties.OPSCredentials.SQL)
            
            Write-Output "`n#--------------------------------------------------------------------------------#"
            Write-Output "  Executing Query against Tenant Database Node: $($TenantDatabase)"
            Write-Output "  Here is the Query: $Query"
            Write-Output "  Here is the Path: $Path"
            Write-Output "  Here is the QueryName: $QueryName"
            Write-Output "  Here is the ServerInstance: $ServerInstance"
            Write-Output "  Here is the List of Properties: $Properties"
            Write-Output "#--------------------------------------------------------------------------------#"

            ## Create Powershell instance for each server
            Write-Output "Creating Powershell runspace instance on $Server"
            $PowerShell = [powershell]::Create()
            $PowerShell.RunSpacePool = $RunspacePool
            $Results = @()
            ## Script to be run
            [void]$PowerShell.AddScript( {
                param ($Query, $ServerInstance, $Server, $Properties, $Path, $QueryName, $Credential)
                Import-Module $env:workspace\G3\G3 -DisableNameChecking -Force
                foreach ($Database in $Properties) {
                    $FileName = "$Path\${QueryName}_${Server}.csv"
                    $Results += Invoke-G3SQLCommand -ServerInstance $ServerInstance -Database $Database -Query $Query -Credential $Credential
                    $Results | Export-Csv -Path $FileName -NoTypeInformation
                    #$Results | Export-CSV "$Path\${QueryName}_${Server}.csv" -NoTypeInformation -Append
                } 
            } )

            ## Additional parameters plus execution of script
            [void]$PowerShell.AddParameter('ServerInstance', $ServerInstance)
            [void]$PowerShell.AddParameter('Server', $Server)
            [void]$PowerShell.AddParameter('Properties', $Properties)
            [void]$PowerShell.AddParameter('Query', $Query)
            [void]$PowerShell.AddParameter('Path', $Path)
            [void]$PowerShell.AddParameter('QueryName', $QueryName)
            [void]$PowerShell.AddParameter('Credential', $Credential)
            $Handle = $PowerShell.BeginInvoke()                
            
            # Storing results
            $temp = '' | Select-Object PowerShell, Handle
            $temp.PowerShell = $PowerShell
            $temp.Handle = $handle
            [void]$cmds.Add($temp)
                
        } 

        # Retrieve command results and dispose session and pool
        $cmds | ForEach-Object {$_.PowerShell.EndInvoke($_.Handle)}
        $cmds | ForEach-Object {$_.PowerShell.Dispose()}
        $RunspacePool.Close()
        $RunspacePool.Dispose()

    } catch { 
        Throw $_.Exception 
    }
}
Invoke-SQLQueryParallel -Platform ${env:Platform} -PSKey ${env:G3OpsCreds} -ClientCodeList ${env:ClientCodeList} -PropertyIDList ${env:PropertyIDList} -QueryToRun ${env:QueryToRun} -Path ${env:Path} -QueryName ${env:QueryName}
