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
