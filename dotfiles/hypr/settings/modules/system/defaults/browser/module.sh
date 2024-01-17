#!/usr/bin/env bash
_getHeader "$name" "$author"

echo "Define the start command to start the browser (Default: chromium)."

# Define File
targetFile="$HOME/dotfiles/.settings/browser.sh"

# Current Value
echo "Current Value: $(cat $targetFile)"

# Select Value
customvalue=$(gum input --placeholder "Command to start")
if [ ! -z $customvalue ] ;then
    # Write into file
    echo "$customvalue" > $targetFile
else 
    echo "Please define a command"
    sleep 1
fi
    _goBack


