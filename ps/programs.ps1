## Pulls the list of programs 
Get-WmiObject -Class Win32_Product | where vendor -like CISCO* | select Name, Version    

## Pulls the list of 64 bit programs 
$InstalledSoftware = Get-ChildItem "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall" 
foreach($obj in $InstalledSoftware){	
	write-host $obj.GetValue('DisplayName') -NoNewline; 
	write-host " - " -NoNewline; 
	write-host $obj.GetValue('DisplayVersion')
	}
