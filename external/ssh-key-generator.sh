#!/bin/bash

# generate ssh key pair file name
# with 8 digits random characters
fname="KeyPair-$(
    cat /proc/sys/kernel/random/uuid | sed 's/[-]//g' | head -c 8
    echo
)"

# Check if the .ssh file is in the directory
# and create the .ssh file if it isn't.
if [[ ! -d "./external/.ssh" ]]; then
    mkdir ./external/.ssh
fi

# file path
fpath="./external/.ssh/${fname}"

# check if such a file exists in the directory
# and generate an ssh key file.
if [[ ! -f "${fpath}" ]]; then
    ssh-keygen -q -t rsa -N '' -b 2048 -v -f $fpath -m PEM
fi

# add .pem extension to the file
mv ${fpath} "${fpath}.pem"