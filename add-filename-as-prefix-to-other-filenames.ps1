function Add-Filename-As-Prefix-To-Other-Filenames {
    <#
    .DESCRIPTION
    A script that scans for a given file. Retrieves its name (without extension),
    and adds it as a prefix, followed by an underscore, to all the file names in
    its directory, that have a certain given file extension.

    .PARAMETER PathOfFileToTakeItsNameAsPrefix
    Specify the path to the target file to retrieve its name, that will serve as
    a prefix to all the files with the given
    `FileExtensionToAddThePrefixToTheirName` extension in its directory.

    .PARAMETER FileExtensionToAddThePrefixToTheirName
    Specify the target file extension, so all of the files with this file
    extension that are located in the directory of the given
    `PathOfFileToTakeItsNameAsPrefix` will be renamed to have a prefix, that
    will include the file `PathOfFileToTakeItsNameAsPrefix`, followed by an
    underscore.

    .INPUTS
    None. You cannot pipe objects to this script.

    .OUTPUTS
    None. This script does not generate any output.

    .NOTES
    MIT License
    Author: Tal Jacob

    .EXAMPLE
    Add-Filename-As-Prefix-To-Other-Filenames -Path "C:\Program Files\demo.txt" -Ext "jpg"

    .LINK
    Online version: https://github.com/taljacob2/add-filename-as-prefix-to-other-filenames
    #>

    param (
        [parameter(mandatory)][Alias("Path")][string]$PathOfFileToTakeItsNameAsPrefix,
        [parameter(mandatory)][Alias("Ext", "Extension")][string]$FileExtensionToAddThePrefixToTheirName
    )

    $file = Get-Item $PathOfFileToTakeItsNameAsPrefix

    Get-ChildItem $file.Directory | ForEach { 
        $fileNameWithoutExtention = [System.IO.Path]::GetFileNameWithoutExtension($file)
        if ($_.Name.EndsWith(".$FileExtensionToAddThePrefixToTheirName")){
            $_ | Rename-Item -NewName "$fileNameWithoutExtention`_$_"
        }
    }
}

Add-Filename-As-Prefix-To-Other-Filenames -Path "ProjectName.psd" -Ext "jpg"