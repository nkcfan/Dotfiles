#!/bin/bash

# Creates a new ssh key, using the provided email as a label
ssh-keygen -t rsa

# Add your new key to the ssh-agent
ssh-add ~/.ssh/id_rsa

# Copy pub key in file to clipboard
UNAME=`uname`
if [[ "$UNAME" == "Linux" ]]; then
    cat ~/.ssh/id_rsa.pub
elif [[ "$UNAME" == "Darwin" ]]; then # OSX
    pbcopy < ~/.ssh/id_rsa.pub
else # Windows
    cat ~/.ssh/id_rsa.pub > /dev/clipboard
fi
