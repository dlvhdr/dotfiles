function flushdns 
  dscacheutil -flushcache
  sudo killall -HUP mDNSResponder
  sudo killall -9 mDNSResponder mDNSResponderHelper
  sudo launchctl stop homebrew.mxcl.dnsmasq
  sudo launchctl start homebrew.mxcl.dnsmasq
  echo "MacOS DNS cache has been cleared!!!"
end
