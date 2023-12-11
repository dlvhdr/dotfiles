#  ____  _ __     ___   _ ____  ____  
# |  _ \| |\ \   / / | | |  _ \|  _ \ 
# | | | | | \ \ / /| |_| | | | | |_) |
# | |_| | |__\ V / |  _  | |_| |  _ < 
# |____/|_____\_/  |_| |_|____/|_| \_\
#                                     
set -U fish_greeting # disable fish greeting

source $XDG_CONFIG_HOME/fish/themes/fish_tokyonight_storm.fish

eval (/opt/homebrew/bin/brew shellenv)

# fish_add_path /opt/homebrew/bin
fish_add_path $HOME/.local/share/npm/bin
fish_add_path $HOME/.config/tmux/plugins/t-smart-tmux-session-manager/bin

if status is-interactive
  pyenv init --path | source
end

# if status is-interactive
#   atuin init fish --disable-up-arrow | source
#   set -gx ATUIN_NOBIND "true"
#
#   bind \cr _atuin_search
#   bind -M insert \cr _atuin_search
# end

fnm env --use-on-cd --version-file-strategy recursive | source

if command -q starship
  starship init fish | source
end

# properly setup gpg tty
set -e SSH_AUTH_SOCK
set -U -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)

set -x GPG_TTY (tty)

if not test (pgrep gpg-agent)
  gpg-agent --daemon --no-grab >/dev/null 2>&1
end

# fzf_configure_bindings --directory=\ct --git_log=
set fzf_preview_dir_cmd exa --group-directories-first --icons -a
set fzf_history_time_format "%d-%m %H:%M"
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

# scary
abbr --add rm "rm -i"
abbr --add mv "mv -i"
abbr --add cp "cp -riv"
abbr --add mkdir 'mkdir -vp'

# neovim
abbr --add vim "nvim"
abbr --add v "nvim"
abbr --add vi "nvim"

# configs
abbr --add ez "nvim $XDG_CONFIG_HOME/fish/config.fish"
abbr --add sz "source $XDG_CONFIG_HOME/fish/config.fish"
abbr --add ea "nvim $XDG_CONFIG_HOME/fish/config.fish"
abbr --add ev "nvim $XDG_CONFIG_HOME/nvim/"
abbr --add dot "nvim $HOME/dotfiles"
abbr --add cdot "cd $HOME/dotfiles"
abbr --add -- - 'cd -'
abbr --add -- -2 'prevd 2'
abbr --add -- -3 'prevd 3'
abbr --add -- -4 'prevd 4'

abbr --add ".." "cd ../"
abbr --add "..." "cd ../../"
abbr --add "...." "cd ../../../"
abbr --add "....." "cd ../../../../"
abbr --add "......" "cd ../../../../../"
abbr --add "......." "cd ../../../../../../"
abbr --add lcat "bat --paging always"
abbr --add cat "bat"
abbr --add tree "et"
abbr --add f "ranger"
abbr --add gcode "$CODE"
abbr --add gd "cd $HOME/Downloads"
alias r "cd_repo"
alias p "cd_pkg"
abbr --add ssh "kitty +kitten ssh"
abbr --add "k" "kubectl"

# others
abbr --add less 'less -r'
abbr --add c "clear"
abbr --add fh 'open -a Finder .'
abbr --add fix "stty sane"
abbr --add nuke-desktop 'rm -rf ~/Desktop/*'
abbr --add jq "jqless"
abbr --add dinner "roulette -o=🍕,🍔,🥓,🌯,🥒,🍗 --title=\"What's for dinner?\""
abbr --add scripts "bat package.json | jq -r '.scripts | to_entries[] | \"\(.key) => \(.value)\"' | sort | fzf | cut -d' ' -f1 | xargs nr"

abbr --add mkpr 'git push && gh pr create -d -f && pr'

# git
abbr --add g "git"
abbr --add sl "gt ls"
abbr --add gst "git status"
abbr --add gca "git commit --amend"
abbr --add gaa "git add -A"
abbr --add gra "git rebase --abort"
abbr --add grc "git rebase --continue"
abbr --add gpf "git push --force"
abbr --add gcm 'git commit -m "$(gum input)"'
abbr --add gclean 'git branch | cut -c 3- | gum choose --no-limit | xargs git branch -D'
abbr --add pr "gh vpr"
abbr --add vr "gh vr"
abbr --add ga "git ls-files -m -o --exclude-standard | fzf --height 50% --preview 'bat {-1} --color always --style changes,numbers' --print0 -m | xargs -0 -t -o git add"
abbr --add gr "git ls-files -m -o --exclude-standard | fzf --print0 -m | xargs -0 -t -o git  -q HEAD --"
abbr --add lg "lazygit"
# abbr --add gco "git_checkout"
abbr --add gco "gt co"
abbr --add gsl "gt ls"

# tmux
abbr --add ta "tmux attach || tmux new -A -s default"
abbr --add tat "tmux attach -t"
abbr --add tn "tmux new -s \$(pwd | sed 's/.*\///g')"
abbr --add tco "tmux kill-session -a"

abbr --add lnvim 'tmux list-panes -a -F "#{session_name} #{command} #{pane_pid} #{pane_title} #{window_name} #{pane_id} #{session_path}" | grep nvim'

abbr --add nvim-lazy "NVIM_APPNAME=LazyVim nvim"
abbr --add nvim-chad "NVIM_APPNAME=NvChad nvim"
abbr --add nvim-astro "NVIM_APPNAME=AstroNvim nvim"
abbr --add nvim-lunar "NVIM_APPNAME=LunarVim nvim"

abbr --add bi "brew install"
abbr --add bic "brew install --cask"
abbr --add bin "brew info"
abbr --add binc "brew info --cask"
abbr --add bl "brew leaves"
abbr --add blr "brew leaves --installed-on-request"
abbr --add blp "brew leaves --installed-as-dependency"
abbr --add bs "brew search"

abbr --add s "scripts"
abbr --add kdp "kubectl describe pod"
abbr --add d "docker"
abbr --add dc "docker-compose"
abbr --add wip "gt modify -cu -m 'wip'"

