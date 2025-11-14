#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Search GitHub Repos
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🤖
# @raycast.argument1 { "type": "text", "placeholder": "search query", "percentEncoded": true }

if [ -z "$1" ]; then
	echo "Enter a search query!";
	exit 1;
fi

open "https://github.com/search?type=repos&q=""$1"
echo "Searching for: $1"

