#  ____  _ __     ___   _ ____  ____  
# |  _ \| |\ \   / / | | |  _ \|  _ \ 
# | | | | | \ \ / /| |_| | | | | |_) |
# | |_| | |__\ V / |  _  | |_| |  _ < 
# |____/|_____\_/  |_| |_|____/|_| \_\
#                                     
set fish_greeting

source $XDG_CONFIG_HOME/fish/themes/fish_tokyonight_storm.fish
fzf_configure_bindings --directory=\ct --git_log=
set fzf_preview_dir_cmd exa --group-directories-first --icons -a
set -gx fzf_history_opts "--nth=4.." --preview=""
set -gx FZF_DEFAULT_OPTS '
    --exact
    --reverse
    --cycle
    --height=20%
    --info=inline
    --prompt=""\ 
    --pointer=→
    --color=dark
    --color=fg:-1,bg:-1,hl:#9ece6a,fg+:#a9b1d6,bg+:#24283b,hl+:#9ece6a
    --color=info:#9ece6a,prompt:#7aa2f7,pointer:#9ece6a,marker:#e5c07b,spinner:#61afef,header:#7aa2f7'

set -gx GUM_FILTER_INDICATOR "→"
set -gx GUM_FILTER_PROMPT " "

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/dolevh/Downloads/google-cloud-sdk/path.fish.inc' ]; . '/Users/dolevh/Downloads/google-cloud-sdk/path.fish.inc'; end
