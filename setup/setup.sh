#!/bin/bash

echo "Installing gum to make this script glamorous..."
if ! command -v brew &> /dev/null; then
  sudo apt update && sudo apt install gum
else
  brew install gum > /dev/null 2>&1
fi


function info() {
  gum style "$*"
}

function title() {
  gum style --foreground=4 "=> $1"
}

function ask() {
  gum style --foreground=6 --bold -- "- $*"
}

function frame() {
  gum style --border=rounded --padding="0 1" --foreground=4 --margin=1 --border-foreground=4 "$@"
}

function link() {
  src="$1"
  dest="$2"
  if test -e "$dest"; then
    TIME=$(date +%s)
    BACKUP="$dest".backup."$TIME"
    mv "$dest" "$BACKUP" && info "moved $dest to $BACKUP" || info "failed to backup $dest to $BACKUP"
  fi

  ln -sf "$src" "$dest"
  info "Linked $src to $dest"
}

function setup_git() {
  user_name=""
  user_email=""
  if test -z "$(git config --global --get user.email)"; then
      ask 'What is your github author name?'
      user_name=$(gum input --placeholder="username")
      ask 'What is your github author email?'
      user_email=$(gum input --placeholder="email")

      test -n "$user_name"
        or echo "please inform the git author name"
      test -n "$user_email"
        or abort "please inform the git author email"
  fi

  git config --global user.name "$user_name" && git config --global user.email "$user_email"
}

frame "Starting setup..."

ask "At which dir do you want to store you code repos?"
CODE=$(gum input --value="$HOME/code")

title "Creating code directories..."
mkdir -p "$CODE/personal"
mkdir -p "$CODE/playground"

title "Linking..."
DOTFILES_PATH=$(pwd -P)
link "$DOTFILES_PATH/.config" "$HOME/.config"
link "$DOTFILES_PATH/home/.zshenv" "$HOME/.zshenv"
link "$DOTFILES_PATH/scripts" "$CODE/scripts"

function install_essentials() {
  gum spin --title "Installing essential brew packages" -- brew install zsh nvim tmux exa fzf starship gh rg shellcheck
  gum spin --title "Installing essential npm packages" -- npm i -g @fsouza/prettierd eslint_d
  gum spin --title "Installing nerd font (Fira Code)" -- brew tap homebrew/cask-fonts
  gum spin --title "Installing nerd font (Fira Code)" -- brew install --cask font-fira-code-nerd-font
  gum spin --title "Installing italic nerd font (SFMono)" -- brew tap epk/epk
  gum spin --title "Installing italic nerd font (SFMono)" -- brew install --cask font-sf-mono-nerd-font
}

gum confirm "$(gum join --vertical "Install essential brew packages?" "(zsh nvim tmux exa fzf starship gh)")" && \
  install_essentials && \
  info "Essentials installed successfully"

ask "Install additional recommended brew packages?"
info "$(gum style --foreground=242 -- "Select all by pressing")" "$(gum style --foreground="248" --background="0" --padding="0 1" -- "a")"

gum choose --no-limit < "$DOTFILES_PATH"/setup/packages.txt | \
  sed -E 's/\:.*//' | \
  xargs gum spin --title "Installing packages..." brew install \
  info "Additional packages installed"

title "Installing neovim plugins..."
if command -v nvim &> /dev/null; then
  gum spin nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync' > /dev/null 
fi

title "Installing tmux plugin manager (TPM)..."
if command -v tmux &> /dev/null; then
  if ! test -d ~/.config/tmux/plugins/tpm/; then
    gum spin git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm > /dev/null
  fi
fi

ask "Changing shell, please enter your password:"
command -v zsh | sudo tee -a /etc/shells
chsh -s "$(which zsh)"

DONE_MSG=$(gum style --bold=true --foreground=4 "Done.")
LOGOUT_MSG=$(gum style --foreground=4  "Please login and logout from your mac.")
frame "$(gum join --vertical --align="center" "$DONE_MSG" "$LOGOUT_MSG")"

ask "Next steps:"
gum format -- "* Change any environment variables you need in \`$DOTFILES/.config/zsh/env.zsh\` to match your setup" \
  "* Edit any aliases in \`$DOTFILES/.config/zsh/aliases.zsh\` to match your config." \
  "* Run \`nvim\` - it will setup all the Neovim plugins. Exit and run it again afterward." \
  "* Run \`tmux new -s dev\`. My prefix key is the **backtick** sign (where the \`~\` key is). Press it followed by \`I\` to install all the tmux plugins."

ask "Resources:"
gum format -- "* A [blog post](https://dlvhdr.me/posts/dev-setup) I made explaining my dev setup" \
  "* A [guide to tmux](https://leanpub.com/the-tao-of-tmux/read)" \
  "* The [README of this repo](https://github.com/dlvhdr/dotfiles)"

