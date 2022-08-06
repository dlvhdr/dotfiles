#      _ _       _         _                _     
#   __| | |_   _| |__   __| |_ __   _______| |__  
#  / _` | \ \ / / '_ \ / _` | '__| |_  / __| '_ \ 
# | (_| | |\ V /| | | | (_| | |     / /\__ \ | | |
#  \__,_|_| \_/ |_| |_|\__,_|_|    /___|___/_| |_|
#                                                 

# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && . "$HOME/.fig/shell/zshrc.pre.zsh"
source "$ZDOTDIR/env.zsh"

unalias run-help
autoload run-help
HELPDIR=$(command brew --prefix)/share/zsh/help
alias help=run-help

# oh-my-zsh
zstyle ':omz:update' mode disabled

plugins=(
  notify
  vi-mode
	zsh-syntax-highlighting
  you-should-use
  yarn-autocompletions
  fzf-yarn
)

if [[ -z "$ZSH_CACHE_DIR" ]]; then
  ZSH_CACHE_DIR="$ZSH/cache"
fi
ZSH_COMPDUMP="$ZSH_CACHE_DIR/zcompdump-${HOST}-${ZSH_VERSION}"
ZSH_DISABLE_COMPFIX=true
DISABLE_AUTO_TITLE=true

# source
. "$ZSH/oh-my-zsh.sh"
. "$ZDOTDIR/keybindings.zsh"
. "$ZDOTDIR/opt.zsh"
. "$ZDOTDIR/colors.zsh"
. "$ZDOTDIR/completions.zsh"
. "$ZDOTDIR/plugins.zsh"
. "$ZDOTDIR/fzf.zsh"
. "$ZDOTDIR/aliases.zsh"
. "$ZDOTDIR/less.zsh"
. "$ZDOTDIR/ranger.zsh"
. "$ZDOTDIR/vi.zsh"
. "$ZDOTDIR/zoxide.zsh"

eval "$(starship init zsh)"

# fnm
if [ "$(command -v fnm)" ]; then
  eval "$(fnm env --use-on-cd)"
fi

# Uncomment to perf test
# ---------------------
# timezsh() {
#   shell=${1-$SHELL}
#   for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
# }
# zmodload zsh/zprof
# zprof

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && . "$HOME/.fig/shell/zshrc.post.zsh"
