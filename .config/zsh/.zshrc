source "$ZDOTDIR/env.zsh"

# fnm
eval "$(fnm env --use-on-cd)"

plugins=(
  vi-mode
	zsh-syntax-highlighting
  auto-notify
  you-should-use
  yarn-autocompletions
  fzf-yarn
)

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

colorscript -r

eval "$(starship init zsh)"

# zmodload zsh/zprof
# zprof
