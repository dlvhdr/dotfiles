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
alias gc="git commit -m"
alias pr="gh vpr"
alias ga="git ls-files -m -o --exclude-standard | fzf --height 50% --preview 'bat {-1} --color=always --style changes,numbers' --print0 -m | xargs -0 -t -o git add"
alias gr="git ls-files -m -o --exclude-standard | fzf --print0 -m | xargs -0 -t -o git  -q HEAD --"

function wix_code_search() {
  open "https://cs.github.com/?scope=org%3Awix-private&scopeName=wix-private&q=""$@"
}
alias wcs="wix_code_search"

function git_checkout() { 
  if [ $# -eq 0 ] 
  then 
    git branch | fzf --header "Checkout" | xargs git checkout
  else 
    git checkout $@ 
  fi
}; 

alias gco="git_checkout"

# wix
alias npmpublic="npm config set registry https://registry.npmjs.org/ && npm config get registry"
alias npmprivate="npm config set registry https://npm.dev.wixpress.com && npm config get registry"
alias pkg="\$(git rev-parse --is-inside-work-tree) && cd \$(ls -r -s accessed --no-icons \$(git rev-parse --show-toplevel)/packages | fzf | xargs -I{} echo \$(git rev-parse --show-toplevel)/packages/'{}')"
alias repo='cd ~/code/$(find ~/code/wix ~/code/personal ~/code/playground -mindepth 1 -maxdepth 1 | sed "s#/Users/dolevh/code/##" | fzf)'

# configs
alias ez="vim $XDG_CONFIG_HOME/zsh/.zshrc"
alias sz='exec zsh' 
alias ea="vim $XDG_CONFIG_HOME/zsh/aliases.zsh"
alias ev="vim $XDG_CONFIG_HOME/nvim/"
alias dot="vim $CODE/personal/dotfiles"
alias cdot="cd $CODE/personal/dotfiles"

# directories
alias wix="cd $CODE/wix/"
alias cc="cd $CODE/wix/wix-code-code-editor"
alias cx="cd $CODE/wix/wix-code-devex"

# brew
alias update="brew update && brew upgrade && brew upgrade --cask --greedy && npm update -g"

# others
alias limelight="launchctl load -w ~/Library/LaunchAgents/limelight.plist"
alias c="clear"
alias sl=ls
alias fh='open -a Finder .'
alias fix="stty sane"
alias yarn='yarn --use-yarnrc "$XDG_CONFIG_HOME/yarn/config"'
alias nuke-desktop='rm -rf ~/Desktop/*'
alias ls="exa --group-directories-first --icons -a"
alias code="code --user-data-dir ~/.config/vscode --extensions-dir ~/.config/vscode/extensions"
alias tree="ls --tree -I \"node_modules|.git|dist|out|target|.husky\""
alias f="ranger"

globalprotect () {
  killall GlobalProtect
  open /Applications/GlobalProtect.app
}

alias vpn="globalprotect"

