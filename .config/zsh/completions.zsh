# completion; use cache if updated within 24h
autoload -Uz compinit
if [[ -n "$ZDOTDIR"/.zcompdump(#qN.mh+24) ]]; then
  compinit -i
else
  compinit -C -i
fi

zmodload -i zsh/complist

autoload bashcompinit && bashcompinit

source /usr/local/etc/bash_completion.d/wt_completion

zstyle ':completion:*' menu select # select completions with arrow keys
zstyle ':completion:*' group-name '' # group results by category
zstyle ':completion:::::' completer _expand _complete _ignored _approximate # enable approximate matches for completion
zstyle ':completion:*' format '%F{magenta}  %d %f'
zstyle ':completion:*:options' description yes
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format '%F{yellow}  %d (errors: %e) %f'
zstyle ':completion:*:descriptions' format '%F{magenta}  %d %f'
zstyle ':completion:*:messages' format '%F{blue} 𥉉%d %f'
zstyle ':completion:*:warnings' format '%F{red}  No matches found... %f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*:default' list-colors "${(s.:.)LS_COLORS}"

