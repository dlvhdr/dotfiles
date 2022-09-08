#!/bin/bash

export HOMEBREW_NO_AUTO_UPDATE=1

OPTIONS=$(\
  gum spin --title "Fetching list of packages..." --show-output -- \
  brew bundle dump --describe --file - | \
  grep -E "^(brew|cask|#)" | \
  sed -E 's/^(brew|cask) \"(.*)\"(,.*)?/\2/' | \
  sed "s/#//" | \
  while read -r first;
    do
      if [[ $first != "#*" ]]; then
        read -r second
        echo "$second ($first)";
      else
        echo "$first"
      fi
    done \
)

echo "$OPTIONS" | gum choose --no-limit | sed -E "s/(.* )\(.*\)/\1/" | xargs brew uninstall
