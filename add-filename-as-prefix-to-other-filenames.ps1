param (
    [parameter(mandatory)][Alias("File")][string]$PathOfFileToTakeItsNameAsPrefix,
    [parameter(mandatory)][Alias("Ext", "Extension")][string]$FileExtensionToAddThePrefixToTheirName
)

$file = Get-Item $PathOfFileToTakeItsNameAsPrefix

Get-ChildItem $file.Directory | ForEach { 
    if ($_.Name.EndsWith(".$FileExtensionToAddThePrefixToTheirName")){
        $_ | Rename-Item -NewName "hello_$_"
    }
}