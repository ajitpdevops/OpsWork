#Functions to run SQL remotely

function New-ConnectionString() {
    param
    (
        [string] $DBServer,
        [string] $DBInstance,
        [string] $DBName,
        [string] $DBUser,
        [string] $DBPassword
    )
    $builder=New-Object system.data.sqlclient.sqlconnectionstringbuilder
    #Enum Keys --> $builder.Keys

    if ($DBInstance) {
        $builder['Data Source'] = ($DBServer + "\" + $DBInstance)
    } else {
        $builder['Data Source'] = $DBServer
    }
    
    $builder['Initial Catalog'] = $DBName
    
    if ($DBUser -and $DBPassword) {
        $builder['User ID'] = $DBUser
        $builder['Password'] = $DBPassword
    } else {
        $builder['Integrated Security']=$true
    }
    
    return $builder.ConnectionString.ToString()
}

function Invoke-SQL {
    param(
        [string] $SQLConnection,
        [string] $SQLCommand = $(throw "Please specify a query.")
      )

    $Connection = new-object system.data.SqlClient.SQLConnection($SQLConnection)
    $Command = new-object system.data.sqlclient.sqlcommand($SQLCommand,$Connection)
    $Connection.Open()
    $Adapter = New-Object System.Data.sqlclient.sqlDataAdapter $Command
    $Dataset = New-Object System.Data.DataSet
    $Adapter.Fill($DataSet) | Out-Null
    $Connection.Close()
    $DataSet.Tables[0]
} 

function Repair-SuspectDatabase {
    param(
        [string] $SQLConnection,
        [string] $Database = $(throw "Please specify a database that you want to repair.")
      )

    $Connection = new-object system.data.SqlClient.SQLConnection($SQLConnection)
    $Connection.Open()

    # Check if the database is in a suspect state
    $command = New-Object System.Data.SqlClient.SqlCommand($"SELECT state_desc FROM sys.databases WHERE name = '{$Database}'", $Connection)
    $state = $command.ExecuteScalar()
    if ($state -ne "SUSPECT")
    {
        Write-Error "The database is not in a suspect state"
        return
    }

    # Set the database to Single User mode
    $command = New-Object System.Data.SqlClient.SqlCommand($"ALTER DATABASE [{$Database}] SET SINGLE_USER WITH ROLLBACK IMMEDIATE", $Connection)
    $command.ExecuteNonQuery()

    # Run the repair process
    $command = New-Object System.Data.SqlClient.SqlCommand($"DBCC CHECKDB([{$Database}], REPAIR_ALLOW_DATA_LOSS)", $Connection)
    $command.ExecuteNonQuery()

    # Set the database back to Multi User mode
    $command = New-Object System.Data.SqlClient.SqlCommand($"ALTER DATABASE [{$Database}] SET MULTI_USER", $Connection)
    $command.ExecuteNonQuery()

    $command = New-Object System.Data.SqlClient.SqlCommand($"SELECT user_access_desc FROM sys.databases WHERE name = '{$Database}'", $Connection)
    $reader = $command.ExecuteReader()
    $reader.Read()
    $mode = $reader.GetString(0)
    $reader.Close()

    if ($mode -eq "MULTI_USER")
    {
        Write-Output "The database is in Multi User mode."
    }
    else
    {
        Write-Output "The database is not in Multi User mode."
    }

    # Close the connection
    $connection.Close()
} 
