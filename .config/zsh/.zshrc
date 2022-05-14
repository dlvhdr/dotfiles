source "$ZDOTDIR/env.zsh"


# oh-my-zsh
zstyle ':omz:update' mode disabled

plugins=(
  auto-notify
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
source "$ZSH/oh-my-zsh.sh"
source "$ZDOTDIR/keybindings.zsh"
source "$ZDOTDIR/opt.zsh"
source "$ZDOTDIR/colors.zsh"
source "$ZDOTDIR/completions.zsh"
source "$ZDOTDIR/plugins.zsh"
source "$ZDOTDIR/fzf.zsh"
source "$ZDOTDIR/aliases.zsh"
source "$ZDOTDIR/less.zsh"
source "$ZDOTDIR/ranger.zsh"
source "$ZDOTDIR/vi.zsh"
source "$ZDOTDIR/zoxide.zsh"

eval "$(starship init zsh)"

timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}

# fnm
if [ "$(command -v fnm)" ]; then
  eval "$(fnm env)"
fi

# Plugins loading times
# ---------------------
# 6: vi-mode
# 19: zsh-syntax-highlighting
# 9: auto-notify
# 22: you-should-use
# 9: yarn-autocompletions
# 5: fzf-yarn

# Misc 
# ---------------------
# colorscript -r
# zmodload zsh/zprof
# zprof
