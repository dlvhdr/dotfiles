#  ____  _ __     ___   _ ____  ____  
# |  _ \| |\ \   / / | | |  _ \|  _ \ 
# | | | | | \ \ / /| |_| | | | | |_) |
# | |_| | |__\ V / |  _  | |_| |  _ < 
# |____/|_____\_/  |_| |_|____/|_| \_\
#                                     

status is-interactive; or exit

set -U fish_greeting # disable fish greeting

set -gx GOPRIVATE "github.com/dlvhdr/*"
set -gx GOPATH "$HOME/code/go"

fish_add_path "$GOPATH" "$HOME/.krew/bin" "$XDG_DATA_HOME/google-cloud-sdk/bin" "$XDG_DATA_HOME/cargo/bin" "/usr/local/opt/ruby/bin" "$GOPATH/bin" "$HOME/.local/bin" "$DOTFILES/scripts" "$XDG_DATA_HOME/npm/bin" "$HOME/.config/tmux/plugins/t-smart-tmux-session-manager/bin" "$HOME/.local/share/npm/bin"

# evalcache for fish for caching source/eval commands for faster startups
# https://github.com/kyohsuke/fish-evalcache

_evalcache /opt/homebrew/bin/brew shellenv
fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/opt/rustup/bin
fish_add_path /Applications/Ghostty.app/Contents/MacOS
fish_add_path "$HOME/code/port/scripties"
fish_add_path "$HOME/.bin"

bind -M insert \cv edit_command_buffer

set -gx EDITOR "nvim"
set -gx DOCKER_CONFIG "$HOME/.docker"
set -gx HOMEBREW_NO_AUTO_UPDATE true
set -gx devbox_no_prompt true
set -gx RESTERM_CONFIG_DIR "$XDG_CONFIG_HOME/resterm"
set -gx NVPM_HOME "$XDG_CONFIG_HOME/nvpm"
set -gx NVPM_CACHE "$XDG_CACHE_HOME/nvpm"

_evalcache nvpm env fish | source

set -gx DIRENV_LOG_FORMAT ""

# fnm env --use-on-cd --version-file-strategy recursive | source

set -gx GUM_FILTER_INDICATOR "→"
set -gx GUM_FILTER_PROMPT " "

set -gx FZF_DEFAULT_OPTS "--layout=reverse --border rounded --no-info --pointer='' --marker=' ' --ansi --height=20% --color='16,bg+:-1,gutter:-1,prompt:5,pointer:5,marker:6,border:4,label:4,header:italic'"
set -gx FZF_COMPLETION_OPTS "--nth=4.. --preview='' --border-label=' history ' --prompt='  '"
# tmux set-environment -g FZF_DEFAULT_OPTS $FZF_DEFAULT_OPTS
# tmux set-environment -g FZF_COMPLETION_OPTS $FZF_COMPLETION_OPTS

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
alias ls="eza --icons --group-directories-first"

alias ct "create-task"
alias p "cd_pkg"
abbr --add "k" "kubectl"

# others
abbr --add less 'less -r'
abbr --add c "clear"
abbr --add fh 'open -a Finder .'
abbr --add fix "stty sane"
abbr --add nuke-desktop 'rm -rf ~/Desktop/*'
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
abbr --add gm 'git commit -m "$(gum input)"'
abbr --add gcm 'gt modify -cu -m "$(gum input)"'
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

abbr --add nvim-lazy "NVIM_APPNAME=lazyvim nvim"
abbr --add nvim-chad "NVIM_APPNAME=NvChad nvim"
abbr --add nvim-astro "NVIM_APPNAME=AstroNvim nvim"
abbr --add nvim-lunar "NVIM_APPNAME=LunarVim nvim"

abbr --add s "scripts"
abbr --add kdp "kubectl describe pod"
abbr --add d "docker"
abbr --add dc "docker compose"
abbr --add wip "gt modify -cu -m 'wip'"
# abbr --add hl "humanlog --truncate=false"
abbr --add ld "lazydocker -f ~/code/komodor/mono/docker-compose.yml"
# abbr --add e "yazi"
abbr --add "?" "mods --role shell -q"

abbr --add eslint-restart "~/.local/share/nvim/mason/bin/eslint_d restart"

abbr --add dr "devbox run"
abbr --add ds "devbox services"
abbr --add lsi "timg -pk --grid=4x1 --upscale=i --center --title --frames=1 -bgray -Bdarkgray *.{png,jpg,jpeg,svg}"

abbr --add db "harlequin --config-path ~/.config/harlequin/config.toml"

abbr --add refresh "yarn && yarn pkg:build && devbox services restart"
abbr fd 'fd --hidden'

fish_add_path "/Users/dlvhdr/.local/share/../bin"
fish_add_path -p "HOME/.bin"
source "$XDG_CONFIG_HOME"/fish/themes/fish_tokyonight_storm.fish

# Credit: https://github.com/artefactory/artefiles/blob/da8736abd8014b795c10cbb465f24b3dda4ae8b7/dot_config/fish/config.fish.tmpl#L207
# atuin's init spawns `atuin uuid` for the session id; uuidgen produces the
# same 32 hex chars for a fraction of the cost, so seed the two variables
# the init checks before sourcing it.
if not set -q ATUIN_SESSION; or test "$ATUIN_SHLVL" != "$SHLVL"
    set -gx ATUIN_SESSION (uuid -v 4 | string replace -a - '' | tr -d '\n')
    set -gx ATUIN_SHLVL $SHLVL
end
_evalcache atuin init fish --disable-up-arrow

function fish_user_key_bindings
    fish_default_key_bindings -M insert
    fish_vi_key_bindings --no-erase insert
    bind --preset -M command ctrl-p up-or-search
    bind --preset -M command ctrl-n down-or-search
    bind --preset -M insert ctrl-n down-or-search
    bind -s --preset -M visual -m default y 'fish_clipboard_copy; commandline -f end-selection repaint-mode'
    bind --preset --erase \ep
    bind --preset -M visual --erase \ep
    bind --preset -M insert --erase \ep
end

set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore
set fish_cursor_visual block
set -g fish_vi_force_cursor 1

bind yy fish_clipboard_copy
bind Y fish_clipboard_copy
bind p fish_clipboard_paste
bind \cv edit_command_buffer

set __done_notification_command 'terminal-notifier -title \\\$title -message \\\$message'

_evalcache zoxide init fish
_evalcache starship init fish
_evalcache direnv hook fish
