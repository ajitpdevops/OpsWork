start-transcript 

get-history 

Get-Command

get-command -Noun s*

get-command -Noun service

Get-Service

Get-Help Get-Service

Get-Help Get-Service -Examples

Get-Help Get-Service -online

get-alias 

get-process -Name msedge

Get-Process -Name msedge | Get-Member

Get-Process -Name msedge | Get-Member
Get-Process -Name msedge | Select-Object *

$zebra = Get-Process firefox
$zebra
$Zebra.Kill()

Get-PSDrive
Get-Help Get-PSDrive | Select-Object Root, Used, Free
Get-PSDrive | Where-Object {$_.Free -gt 1} | Select-Object Root, used, Free  
Get-PSDrive | Where-Object {$_.Free -gt 1} | Select-Object *

Get-PSDrive | Where-Object {$_.Free -gt 1} | ForEach-Object {"Zebra"}
Get-PSDrive | Where-Object {$_.Free -gt 1} | ForEach-Object {Write-Host "Free space for" $_.root "is" $_.Free -ForegroundColor red}

"{0:N0}" -f 10000000
"{0:C2}" -f 10000000000
"{0:P2}" -f 10000000000

Get-PSDrive | Where-Object {$_.Free -gt 1} | ForEach-Object {Write-Host "Free space for" $_.root "is" ("{0:N2}" -f ($_.Free/1gb)) -ForegroundColor red}

Get-PSDrive | Where-Object {$_.Free -gt 1} | ForEach-Object {$c=0; Write-Host "This step runs only once"}{$c=$c+1; Write-Host "this steps runs for each time for the item in pipe" $c}{Write-Host "Thsi item runs only once at the end. The value is " $c}

Get-PSDrive | Where-Object {$_.free -gt 1} | ForEach-Object {Write-Host " "; $count=0} {Write-Host $_.Name ": Used :" ("{0:N2}" -f ($_.Used/1gb)) "Free :" ("{0:N2}" -f ($_.Free/1gb)) "Total :" ("{0:N2}" -f (($_.used/1gb)+($_.free/1gb)));$count = $count + $_.free} {Write-Host ""; Write-Host "Total Free Space " ("{0:N2}" -f ($count/1gb)) -BackgroundColor magenta}


====================================================


$limit = (Get-Date).AddDays(-10)
$path = "D:\v5i\logs\gmt3231alog"
#$path1 = "D:\v5i\logs\stage1061alog\webapps"

# Delete files older than the $limit.
Get-ChildItem -Path $path -Recurse -Force | Where-Object { !$_.PSIsContainer -and $_.CreationTime -lt $limit } | Remove-Item -Force -ErrorAction Continue

=====================================================================================================
$dir = Get-ChildItem | ?{ $_.PSIsContainer } 
$datadir = Join-Path -path $dir -ChildPath data
$mydir = gci $datadir -Directory | Where-Object {$_.Name -like "*db"} | Select-Object Name, FullName

$mydir | ForEach-Object { $_.Name } | out-file H:\idnajp\auto\db_name.csv
$mydir | ForEach-Object { (Get-ChildItem -path $_.FullName propertybardecisionsandoverridespace.*  | Measure-Object Length -s).SUM /1mb } | out-file H:\idnajp\auto\table.csv

# H:\idnajp\auto\tablesize.ps1

======================================================================================================
Get-Service tomcat_* | Where-Object { $_.status -eq "stopped" } | Select-Object -First 3 | Start-Service

======================================================================================================
