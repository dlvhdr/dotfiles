# completion; use cache if updated within 24h
autoload -Uz compinit
for dump in "$ZDOTDIR"/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

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

#compdef gt
###-begin-gt-completions-###
#
# yargs command completion script
#
# Installation: /usr/local/bin/gt completion >> ~/.zshrc
#    or /usr/local/bin/gt completion >> ~/.zprofile on OSX.
#
_gt_yargs_completions()
{
  local reply
  local si=$IFS
  IFS=$'
' reply=($(COMP_CWORD="$((CURRENT-1))" COMP_LINE="$BUFFER" COMP_POINT="$CURSOR" /usr/local/bin/gt --get-yargs-completions "${words[@]}"))
  IFS=$si
  _describe 'values' reply
}
compdef _gt_yargs_completions gt
###-end-gt-completions-###
