Import-Module $env:workspace\modules\G3 -DisableNameChecking -Force

Try {

    $ComputerName = Get-OpsHostEntry $env:Computer
    $Domain = $ComputerName.Split('.')[1]
    Switch ($Domain) {
        "ideasdev"  { $PSEnvironment = "Development" }
        "ideasstg"  { $PSEnvironment = "Stage" }
        "ideasprod" { $PSEnvironment = "Production" }
        Default     { Write-OpsLog "Domain not found based on ComputerName $ComputerName." -Type Error; Throw }
    } # End Switch

    $PSKey = ConvertTo-SecureString $env:OpsMasterPassword -AsPlainText -Force
    $OpsProperties = Get-OpsProperties -Environment $PSEnvironment -PSKey $env:OpsMasterPassword
    $G3Properties = Get-G3Properties -Environment $PSEnvironment -PSKey $env:OpsMasterPassword

    # Check if the database is in suspect state
    $State = Invoke-G3SQLCommand `
        -ServerInstance "$ComputerName\G3SQL01" `
        -Database "master" `
        -Query "SELECT state_desc FROM sys.databases WHERE name = '{$env:SuspectDatabase}'" `
        -Credential $G3Properties.OPSCredentials.SQL `
        -as SingleValue
    
    if ($State -eq "SUSPECT") {
        # Set the database to Single User mode
        Invoke-G3SQLCommand `
            -ServerInstance "$ComputerName\G3SQL01" `
            -Database "master" `
            -Query "ALTER DATABASE [{$env:SuspectDatabase}] SET SINGLE_USER WITH ROLLBACK IMMEDIATE" `
            -Credential $G3Properties.OPSCredentials.SQL

        # Run the repair process
        Invoke-G3SQLCommand `
            -ServerInstance "$ComputerName\G3SQL01" `
            -Database "master" `
            -Query "DBCC CHECKDB([{$env:SuspectDatabase}], REPAIR_ALLOW_DATA_LOSS)" `
            -Credential $G3Properties.OPSCredentials.SQL
        
        # Set the dabase back to multi-user mode
        Invoke-G3SQLCommand `
            -ServerInstance "$ComputerName\G3SQL01" `
            -Database "master" `
            -Query "ALTER DATABASE [{$env:SuspectDatabase}] SET MULTI_USER" `
            -Credential $G3Properties.OPSCredentials.SQL
        
        # Verify if the database is really in MULTI_USER Mode
        $Attempts = 0
        $mode = 'UNKNOWN'
        while (-Not(($mode -eq 'MULTI_USER') -and ($Attempts -lt 10 )))
            { $mode = Invoke-G3SQLCommand `
                    -ServerInstance "$ComputerName\G3SQL01" `
                    -Database "master" `
                    -Query "SELECT user_access_desc FROM sys.databases WHERE name = '{$env:SuspectDatabase}'" `
                    -Credential $G3Properties.OPSCredentials.SQL `
                    -as SingleValue

            $Attempts += 1
            Start-Sleep 15
            Write-Opslog "Attempt: $Attempts out of 10... Waiting for the Database to be in MULTI_USER mode."
            }

        Write-Opslog "The Database is in MULTI_USER mode now."
        
    } else {
        Write-OpsLog "The database is not in a suspect state, please check again.."
    }
    
}
Catch {
    Throw
}