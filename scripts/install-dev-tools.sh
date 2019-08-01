#!/bin/bash

set -x

# install devlopment tools
apk add git zsh vim curl jq openssh

# copy ssh config into container works
mkdir -p ~/.ssh
cp -r ~/localhost_home/.ssh/* ~/.ssh
chmod 700 ~/.ssh
chmod 600 ~/.ssh/*


# configure your custom settings
sh user-settings.sh
