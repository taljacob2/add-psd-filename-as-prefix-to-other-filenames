#!/bin/sh

: '
    <#
    .DESCRIPTION
    A script that scans for a given file. Retrieves its name (without extension),
    and adds it as a prefix, followed by an underscore, to all the file names in
    its directory, that have a certain given file extension.

    .PARAMETER PathOfFileToTakeItsNameAsPrefix
    Specify the path to the target file to retrieve its name, that will serve as
    a prefix to all the files with the given
    `FileExtensionToAddThePrefixToTheirName` extension in its directory.

    .PARAMETER Item
    Another way to send the `PathOfFileToTakeItsNameAsPrefix` as a parameter.

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
    #>
'
addFilenameAsPrefixToOtherFilenames() {
    pathOfFileToTakeItsNameAsPrefix="$1"
    fileExtensionToAddThePrefixToTheirName="$2"

    FILE_PATH="$pathOfFileToTakeItsNameAsPrefix"
    
    : '
        More info about string extraction:
        - [here](https://stackoverflow.com/a/965069/14427765).
        - [here](https://stackoverflow.com/a/44350542/14427765).
    '
    FILE_PATH_WITHOUT_EXTENSION=$(echo "${FILE_PATH%.*}")
    FILE_LAST_DIR_PATH=$(echo "${FILE_PATH%/*}")
    FILE_NAME_WITHOUT_EXTENSION=$(echo "${FILE_PATH_WITHOUT_EXTENSION#$FILE_LAST_DIR_PATH/}")
    FILE_NAME=$(echo "${FILE_PATH#$FILE_LAST_DIR_PATH/}")
    FILE_EXTENSION=$(echo "${FILE_PATH#*.}")

    for fileToRename in *."$fileExtensionToAddThePrefixToTheirName"; do
        if [ -f "$fileToRename" ]; then
            $(mv "$fileToRename" "$FILE_NAME_WITHOUT_EXTENSION""_""$fileToRename")
        fi
    done
}

addPsdFilenameAsPrefixToOtherFilenames() {
    psdFile=$(ls | grep *.psd)
    addFilenameAsPrefixToOtherFilenames $psdFile "jpg"
    addFilenameAsPrefixToOtherFilenames $psdFile "jpeg"
    addFilenameAsPrefixToOtherFilenames $psdFile "png"
}

addPsdFilenameAsPrefixToOtherFilenames
