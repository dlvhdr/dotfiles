autoload -U colors
colors

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)

typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[cursor]="bg=white,standout"
ZSH_HIGHLIGHT_STYLES[alias]="fg=green,bold"
ZSH_HIGHLIGHT_STYLES[suffix-alias]="fg=blue,bold"
ZSH_HIGHLIGHT_STYLES[builtin]="fg=blue,bold"
ZSH_HIGHLIGHT_STYLES[function]="fg=blue,bold"
ZSH_HIGHLIGHT_STYLES[command]="fg=green,bold"
ZSH_HIGHLIGHT_STYLES[precommand]="fg=blue,bold"
ZSH_HIGHLIGHT_STYLES[hashed-command]="fg=blue,bold"
ZSH_HIGHLIGHT_STYLES[comment]="fg=blue,dim"
