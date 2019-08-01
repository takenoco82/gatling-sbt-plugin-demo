#!/bin/bash

set -x

# install devlopment tools
apk add git zsh vim curl jq openssh

# copy ssh config into container works
mkdir -p ~/.ssh
cp -r ~/localhost_home/.ssh/* ~/.ssh
chmod 700 ~/.ssh
chmod 600 ~/.ssh/*

# copy git config into container works
cp ~/localhost_home/.gitconfig ~/
if [[ -f ~/localhost_home/.gitconfig.local ]]; then
  cp ~/localhost_home/.gitconfig.local ~/
fi
if [[ -f ~/localhost_home/.gitignore_global ]]; then
  cp ~/localhost_home/.gitignore_global ~/
fi

# configure your custom settings
sh user-settings.sh
