# PowerShell script that you can use to replace the dash character "-" with an underscore character "_" in the names of all files in a specific directory
$files = Get-ChildItem -Path "C:\Path\To\Directory"
foreach ($file in $files)
{
  $newName = $file.Name -replace "-", "_"
  Rename-Item -Path $file.FullName -NewName $newName
}

############-----------------------------------------------#################################

# Set the path to the folder containing the files
$folderPath = "D:\temp\SLIM_restores\20221215"


# Get a list of all files in the folder
$files = Get-ChildItem -Path $folderPath -Recurse

# Split the path I provided and get the current folders name
$splitPath = Split-Path -Path $folderPath -Leaf
$date = $splitPath

# Incase you want to get the date [Set the date to be appended to the filenames]
# $date = Get-Date -Format "yyyy-MM-dd"


# Loop through each file
foreach ($file in $files) {
    # Get the current file name and extension
    $name = $file.Name
    $onlyname = $name.Split(".")
    $filename = $onlyname[0]
    $extension = $file.Extension
    

    # Build the new file name by appending the date to the current name
    $newName = "${filename}_${date}${extension}"

    # Rename the file using the new name
    Rename-Item -Path $file.FullName -NewName $newName
}

############-----------------------------------------------#################################