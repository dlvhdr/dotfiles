#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Copy JumpCloud OTP
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🤖

op read --force "op://Private/JumpCloud/one-time password?attribute=otp" | pbcopy
