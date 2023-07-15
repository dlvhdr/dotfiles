#  ____  _ __     ___   _ ____  ____  
# |  _ \| |\ \   / / | | |  _ \|  _ \ 
# | | | | | \ \ / /| |_| | | | | |_) |
# | |_| | |__\ V / |  _  | |_| |  _ < 
# |____/|_____\_/  |_| |_|____/|_| \_\
#                                     
set -U fish_greeting # disable fish greeting

source $XDG_CONFIG_HOME/fish/themes/fish_tokyonight_storm.fish

fzf_configure_bindings --directory=\ct --git_log=
set fzf_preview_dir_cmd exa --group-directories-first --icons -a
set -gx fzf_history_opts "--nth=4.." --preview="" --border-label=" history " --prompt="  "
set -gx FZF_DEFAULT_OPTS "\
--reverse \
--border rounded \
--no-info \
--pointer='' \
--marker=' ' \
--ansi \
--height=20%
--color='16,bg+:-1,gutter:-1,prompt:5,pointer:5,marker:6,border:4,label:4,header:italic'"

set -gx GUM_FILTER_INDICATOR "→"
set -gx GUM_FILTER_PROMPT " "

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/dolevh/Downloads/google-cloud-sdk/path.fish.inc' ]; . '/Users/dolevh/Downloads/google-cloud-sdk/path.fish.inc'; end
