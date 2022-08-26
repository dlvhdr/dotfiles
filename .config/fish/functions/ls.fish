function ls --wraps='exa --icons --group-directories-first' --description 'alias ls=exa --icons --group-directories-first'
  exa -a --icons --group-directories-first $argv; 
end

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
