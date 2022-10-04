set -Ux EDITOR "nvim"
set -Ux TERMINAL "kitty"
set -Ux TERM "xterm-kitty"

set -Ux DOTFILES "$HOME/dotfiles"
set -Ux CODE "$HOME/code"

# Define XDG dirs https://specifications.freedesktop.org/basedir-spec/basedir-spec-0.6.html)
set -Ux XDG_CONFIG_HOME "$HOME/.config"
set -Ux XDG_DATA_HOME "$HOME/.local/share"
set -Ux XDG_CACHE_HOME "$HOME/.cache"
set -Ux XDG_RUNTIME_DIR "/tmp"
set -Ux XDG_STATE_HOME "$HOME/.local/state"
set -Ux GOPATH "$CODE/go"

set -Ux GEM_HOME "$XDG_CONFIG_HOME/.gem"
set -Ux ELECTRON_CONFIG_CACHE "$XDG_CONFIG_HOME/.electron"
set -Ux DOCKER_CONFIG "$XDG_CONFIG_HOME/docker"
set -Ux LESSHISTFILE "-"
set -Ux CARGO_HOME "$XDG_DATA_HOME/cargo"
set -Ux FNM_DIR "$XDG_DATA_HOME/fnm"
set -Ux RUSTUP_HOME "$XDG_DATA_HOME/rustup"
set -Ux NPM_CONFIG_USERCONFIG "$XDG_CONFIG_HOME/npm/npmrc"
set -Ux NPM_CONFIG_DEVDIR "$XDG_CACHE_HOME/node-gyp"
set -Ux CORE_D_DOTFILE "$XDG_RUNTIME_DIR/.eslint_d"
set -Ux HISTFILE "$XDG_STATE_HOME/bash/history"
set -Ux NODE_REPL_HISTORY "$XDG_DATA_HOME/node_repl_history"
set -Ux DOCKER_CONFIG "$XDG_CONFIG_HOME/docker"
set -Ux RUSTUP_HOME "$XDG_DATA_HOME/rustup"
set -Ux DOCKER_CONFIG "$XDG_CONFIG_HOME/docker"
set -Ux STARSHIP_CONFIG $DOTFILES/.config/starship.toml

# gum
set -Ux GUM_FILTER_INDICATOR "→"
set -Ux GUM_FILTER_PROMPT " "

# fzf
set -Ux FZF_DEFAULT_OPTS '
    --bind ctrl-j:down,ctrl-k:up
    --exact
    --reverse
    --cycle
    --height=20%
    --info=inline
    --prompt=""\ 
    --pointer=→
    --color=dark
    --color=fg:-1,bg:-1,hl:#9ece6a,fg+:#a9b1d6,bg+:#1D202F,hl+:#9ece6a
    --color=info:#9ece6a,prompt:#7aa2f7,pointer:#9ece6a,marker:#e5c07b,spinner:#61afef,header:#7aa2f7'

# scary
abbr -a rm "rm -i"
abbr -a mv "mv -i"
abbr -a cp "cp -riv"
abbr -a mkdir 'mkdir -vp'

# neovim
abbr -a vim "nvim"
abbr -a v "nvim"
abbr -a vi "nvim"

# configs
abbr -a ez "nvim $XDG_CONFIG_HOME/fish/config.fish"
abbr -a sz "source $XDG_CONFIG_HOME/fish/config.fish"
abbr -a ea "nvim $XDG_CONFIG_HOME/fish/config.fish"
abbr -a ev "nvim $XDG_CONFIG_HOME/nvim/"
abbr -a dot "nvim $HOME/dotfiles"
abbr -a cdot "cd $HOME/dotfiles"
abbr -a -- - 'cd -'
abbr -a -- -2 'prevd 2'
abbr -a -- -3 'prevd 3'
abbr -a -- -4 'prevd 4'

abbr -a ".." "cd ../"
abbr -a "..." "cd ../../"
abbr -a "...." "cd ../../../"
abbr -a "....." "cd ../../../../"
abbr -a "......" "cd ../../../../../"
abbr -a "......." "cd ../../../../../../"
abbr -a lcat "bat --paging always"
abbr -a cat "bat"
abbr -a tree "ls --tree -I \"node_modules|.git|dist|out|target|.husky\""
abbr -a f "ranger"
abbr -a gcode "$CODE"
abbr -a gd "cd $HOME/Downloads"
alias r "cd_repo"
alias p "cd_pkg"
abbr -a ssh "kitty +kitten ssh"


# others
abbr -a less 'less -r'
abbr -a c "clear"
abbr -a fh 'open -a Finder .'
abbr -a fix "stty sane"
abbr -a nuke-desktop 'rm -rf ~/Desktop/*'
abbr -a jq "jqless"
abbr -a dinner "roulette -o=🍕,🍔,🥓,🌯,🥒,🍗 --title=\"What's for dinner?\""
abbr -a scripts "bat package.json | jqless '.scripts'"

# wix
abbr -a npmpublic "npm config set registry https://registry.npmjs.org/ && npm config get registry"
abbr -a npmprivate "npm config set registry https://npm.dev.wixpress.com && npm config get registry"
abbr -a mkpr 'git push && gh pr create -d -f && pr'
abbr -a gwix "cd $CODE/wix"


# git
abbr -a g "git"
abbr -a sl "gt l"
abbr -a gst "git status"
abbr -a gca "git commit --amend"
abbr -a gaa "git add -A"
abbr -a gra "git rebase --abort"
abbr -a grc "git rebase --continue"
abbr -a gpf "git push --force"
abbr -a gcm 'git commit -m "$(gum input)"'
abbr -a gclean 'git branch | cut -c 3- | gum choose --no-limit | xargs git branch -D'
abbr -a pr "gh vpr"
abbr -a vr "gh vr"
abbr -a ga "git ls-files -m -o --exclude-standard | fzf --height 50% --preview 'bat {-1} --color always --style changes,numbers' --print0 -m | xargs -0 -t -o git add"
abbr -a gr "git ls-files -m -o --exclude-standard | fzf --print0 -m | xargs -0 -t -o git  -q HEAD --"
abbr -a lg "lazygit"
abbr -a gco "git_checkout"

# tmux
abbr -a ta "tmux a"
abbr -a tat "tmux attach -t"
abbr -a tn "tmux new -s \$(pwd | sed 's/.*\///g')"

abbr -a lnvim 'tmux list-panes -a -F "#{session_name} #{command} #{pane_pid} #{pane_title} #{window_name} #{pane_id} #{session_path}" | grep nvim'
