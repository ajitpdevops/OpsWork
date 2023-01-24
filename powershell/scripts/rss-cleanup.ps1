$xmlFile = "C:\Users\idnajp\Downloads\file-new.xml"
$inputFile = "C:\Users\idnajp\Downloads\input.txt"

$xml = [xml](Get-Content $xmlFile)

$inputStrings = Get-Content $inputFile

foreach ($inputString in $inputStrings) {
    $propertyIdNodes = $xml.SelectNodes("//PropertyID[text()='$inputString']")
    $propertyNodes = $xml.SelectNodes("//Property[@propertyID='$inputString']")
    $uploadBufferDir = $propertyNodes.uploadBufferDir
    $incomingDir = $propertyNodes.incomingExtractDir
    

    write-host "uploadBufferDir:- $uploadBufferDir"
    write-host "incomingDir:- $incomingDir"


    foreach ($node in $propertyIdNodes) {
        $node.ParentNode.RemoveChild($node)
        Write-Host "PropertyID Node with value '$inputString' removed."
    }

    foreach ($node in $propertyNodes) {
        $node.ParentNode.RemoveChild($node)
        Write-Host "Property Node with propertyID '$inputString' removed."
    }
    # check if the folder is empty or contains only sph files
    $files = Get-ChildItem -Path $uploadBufferDir -recurse -Include *.sph
    if(((Test-Path $uploadBufferDir) -and (Get-ChildItem -Path $uploadBufferDir -File).Count -eq $files.Count) -or (-not (Test-Path $uploadBufferDir)))
    {
        Remove-Item $uploadBufferDir -Force -Recurse
        Write-Host "Upload buffer directory for $inputString removed."
    }
    else {
        Write-Host "Upload buffer directory for $inputString not removed as it contains other files."
    }
    $files = Get-ChildItem -Path $incomingDir -recurse -Include *.sph
    if(((Test-Path $incomingDir) -and (Get-ChildItem -Path $incomingDir -File).Count -eq $files.Count) -or (-not (Test-Path $incomingDir)))
    {
        Remove-Item $incomingDir -Force -Recurse
        Write-Host "Incoming directory for $inputString removed."
    }
    else {
        Write-Host "Incoming directory for $inputString not removed as it contains other files."
    }
}

if ($xml.ChildNodes.Count -ne 0) {
    $xml.Save($xmlFile)
}
else {
    Write-Host "The xml file has no child elements after removing the matching elements, the file is not saved."
 
}