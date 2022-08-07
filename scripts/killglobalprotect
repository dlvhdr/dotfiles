#!/bin/sh
#
# Kill the Palo Alto Networks Global Protect VPN software.
#
# This software can cause problems for some users because it keeps
# trying to connect, popping up dialog boxes, with no way to quit.
#
#   * The UI does not have any kind of "Quit" button or menu item.
#
#   * The macOS Activity Monitor can use "Quit" or "Force Quit",
#     and the command line process tools can use `kill` or `pkill`, 
#     but the software restarts when it's loaded into launchctl.
#
#   * The software is able to run simultaneously on multiple user
#     accounts on the same Mac; this is an atypical setup for a solo
#     user, but a typical setup for our teammates, who may have a user
#     account for normal work, and a separate user account for demos.
#
# This implementation uses `launchctl` to `unload the code,
# then kills all processes named GlobalProtect and PanGPS.
##
set -uf

launchctl unload -w /Library/LaunchAgents/com.paloaltonetworks.gp.pangpa.plist
launchctl unload -w /Library/LaunchAgents/com.paloaltonetworks.gp.pangps.plist

while true; do
  sudo killall GlobalProtect || break
  sleep 1
done

while true; do
  sudo killall -9 GlobalProtect || break
  sleep 1
done

while true; do
  sudo killall PanGPS || break
  sleep 1
done

while true; do
  sudo killall -9 PanGPS || break
  sleep 1
done
