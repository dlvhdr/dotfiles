# scary
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -riv"
alias mkdir='mkdir -vp'

# neovim
alias vim="nvim"
alias v="nvim"
alias vi="nvim"

# git
alias g="git"
alias sl="gt l"
alias config="/usr/bin/git --git-dir=$HOME/code/personal/dotfiles --work-tree=$HOME"
alias gst="git status"
alias gca="git commit --amend"
alias gaa="git add -A"
alias gra="git rebase --abort"
alias grc="git rebase --continue"
alias gpf="git push --force"

# wix
alias npmpublic="npm config set registry https://registry.npmjs.org/ && npm config get registry"
alias npmprivate="npm config set registry https://npm.dev.wixpress.com && npm config get registry"
alias pkg="\$(git rev-parse --is-inside-work-tree) && cd \$(ls -r -s accessed --no-icons \$(git rev-parse --show-toplevel)/packages | fzf | xargs -I{} echo \$(git rev-parse --show-toplevel)/packages/'{}')"

# configs
alias ez="vim $XDG_CONFIG_HOME/zsh/.zshrc"
alias sz='source $XDG_CONFIG_HOME/zsh/.zshrc; echo "zsh config reloaded..."' 
alias ea="vim $XDG_CONFIG_HOME/zsh/aliases.zsh"
alias ev="vim $XDG_CONFIG_HOME/nvim/"

# directories
alias wix="cd $CODE/wix/"
alias cc="cd $CODE/wix/wix-code-code-editor"
alias cx="cd $CODE/wix/wix-code-devex"
alias ls="exa --group-directories-first --icons -a"
alias code="code --user-data-dir ~/.config/vscode --extensions-dir ~/.config/vscode/extensions"
alias tree="ls --tree"
alias f="ranger"

# brew
alias update="brew update && brew upgrade && brew upgrade --cask --greedy && npm update -g"

# others
alias limelight="launchctl load -w ~/Library/LaunchAgents/limelight.plist"
alias c="echo -n '\r¯\_(ツ)_/¯'; clear"
alias sl=ls
alias fh='open -a Finder .'
alias fix="stty sane"
alias yarn='yarn --use-yarnrc "$XDG_CONFIG_HOME/yarn/config"'
alias nuke-desktop='rm -rf ~/Desktop/*'
