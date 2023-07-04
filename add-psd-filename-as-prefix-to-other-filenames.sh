#!/bin/sh

: '
    Description:
    A script that scans for a given file. Retrieves its name (without extension),
    and adds it as a prefix, followed by an underscore, to all the file names in
    its directory, that have a certain given file extension.

    Parameters:
    $1: pathOfFileToTakeItsNameAsPrefix
    Specify the path to the target file to retrieve its name, that will serve as
    a prefix to all the files with the given
    `fileExtensionToAddThePrefixToTheirName` extension in its directory.

    $2: fileExtensionToAddThePrefixToTheirName
    Specify the target file extension, so all of the files with this file
    extension that are located in the directory of the given
    `pathOfFileToTakeItsNameAsPrefix` will be renamed to have a prefix, that
    will include the file `pathOfFileToTakeItsNameAsPrefix`, followed by an
    underscore.

    Notes:
    MIT License
    Author: Tal Jacob

    Example Of Use:
    ```
    addFilenameAsPrefixToOtherFilenames "/mnt/demo.txt" "jpg"
    ```
'
addFilenameAsPrefixToOtherFilenames() {
    pathOfFileToTakeItsNameAsPrefix="$1"
    fileExtensionToAddThePrefixToTheirName="$2"

    FILE_PATH="$pathOfFileToTakeItsNameAsPrefix"
    FILE_PATH_WITHOUT_EXTENSION=$(echo "${FILE_PATH%.*}")
    FILE_LAST_DIR_PATH=$(echo "${FILE_PATH%/*}")
    FILE_NAME_WITHOUT_EXTENSION=$(echo "${FILE_PATH_WITHOUT_EXTENSION#$FILE_LAST_DIR_PATH/}")

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
