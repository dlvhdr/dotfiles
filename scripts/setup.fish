#!/usr/bin/env fish

set -Ux DOTFILES "$HOME/dotfiles"
set -Ux CODE "$HOME/code"

# Define XDG dirs https://specifications.freedesktop.org/basedir-spec/basedir-spec-0.6.html)
set -Ux XDG_CONFIG_HOME "$HOME/.config"
set -Ux XDG_DATA_HOME "$HOME/.local/share"
set -Ux XDG_CACHE_HOME "$HOME/.cache"
set -Ux XDG_RUNTIME_DIR "/tmp"
set -Ux XDG_STATE_HOME "$HOME/.local/state"
set -Ux GOPATH "$CODE/go"

# Other
# set -Ux TERMINFO "$XDG_DATA_HOME/terminfo"
# set -Ux TERMINFO_DIRS "$XDG_DATA_HOME/terminfo:/usr/share/terminfo"
set -Ux GEM_HOME "$XDG_CONFIG_HOME/.gem"
set -Ux ELECTRON_CONFIG_CACHE "$XDG_CONFIG_HOME/.electron"
set -Ux GNUPGHOME "$HOME/.gnupg"
set -Ux LESSHISTFILE "-"
set -Ux CARGO_HOME "$XDG_DATA_HOME/cargo"
set -Ux FNM_DIR "$XDG_DATA_HOME/fnm"
set -Ux RUSTUP_HOME "$XDG_DATA_HOME/rustup"
set -Ux GNUPGHOME "$XDG_DATA_HOME/gnupg"
set -Ux NPM_CONFIG_USERCONFIG "$XDG_CONFIG_HOME/npm/npmrc"
set -Ux NPM_CONFIG_DEVDIR "$XDG_CACHE_HOME/node-gyp"
set -Ux CORE_D_DOTFILE "$XDG_RUNTIME_DIR/.eslint_d"
set -Ux HISTFILE "$XDG_STATE_HOME/bash/history"
set -Ux NODE_REPL_HISTORY "$XDG_DATA_HOME/node_repl_history"
set -Ux RUSTUP_HOME "$XDG_DATA_HOME/rustup"
