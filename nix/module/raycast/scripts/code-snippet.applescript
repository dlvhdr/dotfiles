#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Wrap in Code Block
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/code.icns
# @raycast.packageName Code Block

# Documentation:
# @raycast.description Wrap the currently selected text in a code block.
# @raycast.author dlvhdr
# @raycast.authorURL https://github.com/dlvhdr

tell application "System Events"
    delay 0.1
    keystroke "c" using {command down}
    delay 0.1
    do shell script "echo '```\n' $(pbpaste) '\n```' | pbcopy"
    keystroke "v" using {command down}
end
