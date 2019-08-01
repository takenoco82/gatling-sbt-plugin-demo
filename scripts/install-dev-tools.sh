#!/bin/bash

set -x

# install devlopment tools
apk add git zsh vim curl jq

# configure your custom settings
sh user-settings.sh
