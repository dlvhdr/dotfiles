#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Play Kan 88FM
# @raycast.mode silent

# Optional parameters:
# @raycast.packageName Spotify
# @raycast.icon images/spotify-logo.png

# Documentation:
# @raycast.author Dolev Hadar
# @raycast.authorURL https://github.com/dlvhdr
# @raycast.description Play playlist or track in Spotify.

# Customization:
# 1. Copy URI of track or playlist from Spotify, e.g. your discover weekly
# 2. Adjust title and description of command
property uri: "spotify:playlist:6EOBRaHfU63LNFKLJmeS3S"

tell application "Spotify" to play track uri
