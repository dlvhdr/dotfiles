#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Wix Package Search
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🤖
# @raycast.packageName Developer Utils

# Documentation:
# @raycast.description Search for the repo of a Wix package
# @raycast.author Dolev Hadar
# @raycast.authorURL https://github.com/dlvhdr
# @raycast.argument1 { "type": "text", "placeholder": "package name", "percentEncoded": true }

if [ -z "$1" ]; then
	echo "Enter a search query!";
	exit 1;
fi

escaped_package_name=$(echo "$1" | sed "s#%2F#%5C%2F#g")
echo "Searching for $escaped_package_name..."

open "https://cs.github.com/?scope=org%3Awix-private&scopeName=wix-private&q=%2F%22name%22%3A+%22$escaped_package_name%22%2F+path%3Apackage.json"
