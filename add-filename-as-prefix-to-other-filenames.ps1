param (
    [parameter(mandatory)][Alias("File")][string]$PathOfFileToTakeItsNameAsPrefix,
    [parameter(mandatory)][Alias("Ext", "Extension")][string]$FileExtensionToAddThePrefixToTheirName
)

$file = Get-Item $PathOfFileToTakeItsNameAsPrefix

Get-ChildItem $file.Directory | ForEach { 
    $fileNameWithoutExtention = [System.IO.Path]::GetFileNameWithoutExtension($file)
    if ($_.Name.EndsWith(".$FileExtensionToAddThePrefixToTheirName")){
        $_ | Rename-Item -NewName "$fileNameWithoutExtention`_$_"
    }
}