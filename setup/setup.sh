#!/bin/bash

echo "Installing gum to make this script glamorous..."
brew install gum > /dev/null 2>&1

function info() {
  gum style "$1"
}

function title() {
  gum style --foreground=4 "=> $1"
}

function frame() {
  gum style --border=rounded --padding="0 1" --foreground=4 --margin=1 --border-foreground=4 "$@"
}

function link() {
  src="$1"
  dest="$2"
  if test -e "$dest"; then
    mv "$dest" "$dest".backup && info "moved $dest to $dest.backup" || info "failed to backup $dest to $dest.backup"
  fi

  ln -sf "$src" "$dest"
  info "Linked $src to $dest"
}

frame "Starting setup..."

gum spin --title.foreground=4 --title "=> Installing zsh" brew install zsh

title "Creating code directories..."
mkdir -p "$HOME/code/personal"
mkdir -p "$HOME/code/playground"

title "Linking..."
DOTFILES_PATH=$(pwd -P)
link "$DOTFILES_PATH/.config" "$HOME/.config"
link "$DOTFILES_PATH/home/.zshenv" "$HOME/.zshenv"

gum confirm "$(gum join --vertical "Install essential brew packages?" "(nvim tmux exa fzf starship gh)")" && \
  brew install nvim tmux exa fzf starship gh rg shellcheck && npm i @fsouza/prettierd eslint_d 

title "Install addtional recommended brew packages? (press \'a\' to select all)"
gum choose --no-limit < "$DOTFILES_PATH"/setup/packages.txt | \
  sed -E 's/\:.*//' | \
  xargs gum spin --title "Installing packages..." brew install

title "Installing neovim plugins..."
if command -v nvim &> /dev/null; then
  gum spin nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync' &>/dev/null 
fi

title "Installing tmux plugin manager (TPM)..."
if command -v tmux &> /dev/null; then
  if ! test -d ~/.config/tmux/plugins/tpm/; then
    gum spin git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm > /dev/null
  fi
fi

title "Changing shell..."
command -v zsh | sudo tee -a /etc/shells
chsh -s "$(which zsh)"

DONE_MSG=$(gum style --bold=true --foreground=4 "Done.")
LOGOUT_MSG=$(gum style --foreground=4  "Please login and logout from your mac.")

frame "$(gum join --vertical --align="center" "$DONE_MSG" "$LOGOUT_MSG")"
