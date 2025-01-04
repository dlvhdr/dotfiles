function ls --wraps='eza --icons --group-directories-first' --description 'alias ls=eza --icons --group-directories-first'
  eza -a --icons --group-directories-first $argv; 
end

# function ls --wraps='lla --icons -g --sort-dirs-first' --description 'alias ls=lla --icons -g --sort-dirs-first'
#   lla --icons -g --sort-dirs-first $argv;
# end

# directories
# if command -qs exa
# 	abbr -a l 'exa -lh --icons'
# 	abbr -a ll 'exa -l --icons'
# 	abbr -a lt 'exa -l --icons --tree --level=2'
# else
# 	abbr -a l 'ls -lAh'
# 	abbr -a ll 'ls -l'
# end
# abbr -a sl ls
