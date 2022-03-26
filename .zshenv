# Define XDG dirs https://specifications.freedesktop.org/basedir-spec/basedir-spec-0.6.html)
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_RUNTIME_DIR="/tmp"
export XDG_STATE_HOME="$HOME/.local/state"

# ZSH
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
. "/Users/dolevh/.local/share/cargo/env"
