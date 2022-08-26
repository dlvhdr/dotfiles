#  ____  _ __     ___   _ ____  ____  
# |  _ \| |\ \   / / | | |  _ \|  _ \ 
# | | | | | \ \ / /| |_| | | | | |_) |
# | |_| | |__\ V / |  _  | |_| |  _ < 
# |____/|_____\_/  |_| |_|____/|_| \_\
#                                     
set fish_greeting

fzf_configure_bindings --directory=\ct
set fzf_preview_dir_cmd exa --group-directories-first --icons -a
set --export fzf_history_opts "--nth=4.." --preview=""

