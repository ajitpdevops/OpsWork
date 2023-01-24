# Change the JAMS Failover from Secondary to Primary 

Import-Module JAMS
### List current status of the secondary
Get-JAMSFailoverStatus -Server mn5pifsejsw102
### Set the primary to running mode
Set-JAMSFailoverStatus -Server mn5pifsejsw101 -Active
### Double check the secondary status - should read: "passive"
Get-JAMSFailoverStatus -Server mn5pifsejsw102 