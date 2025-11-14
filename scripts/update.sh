#!/bin/bash
set -euo pipefail

echo "Updating Homebrew..."
brew update
brew upgrade
brew cleanup

echo "Updating Brewfile..."
rm Brewfile && brew bundle dump

echo "Updating Neovim..."
nvim --headless +"Lazy! sync" +qa &>/dev/null

echo "Updating tmux plugins..."
"$HOME"/.config/tmux/plugins/tpm/bin/update_plugins all
