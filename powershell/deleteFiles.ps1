# Recursively Delete all files older than 7 days.. (Log Purging) 
Get-ChildItem -Path "D:\Inf\Logs" -Recurse -force -ErrorAction SilentlyContinue | where {$_.LastwriteTime -lt  (Get-Date).AddDays(-7) } | Remove-Item -Verbose -Force -Recurse -ErrorAction SilentlyContinue


# Delete files older than the $limit.
$limit = (Get-Date).AddDays(-7)
$path = "D:\v5i\apps\webapps\...."
Get-ChildItem -Path $path -Recurse -Force | Where-Object { !$_.PSIsContainer -and $_.CreationTime -lt $limit } | Remove-Item -Force

# Or
Get-ChildItem –Path "C:\path\to\folder" -Recurse | Where-Object {($_.LastWriteTime -lt (Get-Date).AddDays(-7))} | Remove-Item