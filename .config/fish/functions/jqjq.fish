function jqjq
  # -F tell less exit if output content can be displayed on one screen
  jq -C "$@" | less -FR
end
