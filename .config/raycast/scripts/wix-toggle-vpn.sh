#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Wix Toggle VPN
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🤖
# @raycast.packageName Developer Utils

# Documentation:
# @raycast.author Dolev Hadar
# @raycast.authorURL https://github.com/dlvhdr

cd "/Users/dolevh/code/wix/wix-cli-go/dist/wix-cli-go_darwin_amd64_v1" || exit
./wix vpn toggle
