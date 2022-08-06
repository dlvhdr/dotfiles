#!/bin/bash

if ! command -v fzf &> /dev/null; then
  exit
fi

export FZF_DEFAULT_COMMAND='fd --type f -H --exclude ".git" --exclude "node_modules"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

bindkey -r '^T'
bindkey '^Y' fzf-file-widget

if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/usr/local/opt/fzf/bin"
fi

[[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null

source "/usr/local/opt/fzf/shell/key-bindings.zsh"

export FZF_DEFAULT_OPTS='
    --bind ctrl-j:down,ctrl-k:up
    --exact
    --reverse
    --cycle
    --height=20%
    --info=inline
    --prompt=❯\ 
    --pointer=→
    --color=dark
    --color=fg:-1,bg:-1,hl:#9ece6a,fg+:#a9b1d6,bg+:#1D202F,hl+:#9ece6a
    --color=info:#9ece6a,prompt:#7aa2f7,pointer:#9ece6a,marker:#e5c07b,spinner:#61afef,header:#7aa2f7'

