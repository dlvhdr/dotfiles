#!/bin/bash

set -x
set -e

# TODO: need to test on VM

CODE_PATH = "$HOME/code/personal"
DOTFILES_REPO_NAME = "dotfiles"
DOTFILES_REPO_URL = "https://github.com/dlvhdr/$DOTFILES_REPO_NAME.git"
DOTFILES_PATH = "$CODE_PATH/$DOTFILES_REPO_NAME"

echo "------------------------"
echo "Installing hombrew"
echo "------------------------"
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew tap Homebrew/bundle

echo "------------------------"
echo "Creating code directory"
echo "------------------------"
mkdir -p "$CODE_PATH"

echo "------------------------"
echo "Cloning dotfiles from $DOTFILES_REPO_URL into $CODE_PATH"
echo "------------------------"
git clone "$DOTFILES_REPO_URL" "$CODE_PATH/$DOTFILES_REPO_NAME"

echo "------------------------"
echo "Linking..."
echo "------------------------"
ln -s "$DOTFILES_PATH/.config" "$HOME/.config"
ln -s "$DOTFILES_PATH/home/.zshenv" "$HOME/.zshenv"

echo "------------------------"
echo "Sourcing env variables"
echo "------------------------"
source ~/.zshenv

echo "------------------------"
echo "Installing brew packages..."
echo "------------------------"
brew bundle install --file "$DOTFILES_PATH/setup/Brewfile"
