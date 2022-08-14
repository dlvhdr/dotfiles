# scary
alias cat="bat"
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -riv"
alias mkdir='mkdir -vp'

# neovim
alias vim="nvim"
alias v="nvim"
alias vi="nvim"

function wix_code_search() {
  open "https://cs.github.com/?scope=org%3Awix-private&scopeName=wix-private&q=""$*"
}
alias wcs="wix_code_search"

function git_checkout() { 
  if [ $# -eq 0 ] 
  then 
    git branch | gum filter --indicator="→" --placeholder="Checkout branch..." | xargs git checkout
  fi
}; 

function dirs_fzf() { 
  selected=$(dirs -p | fzf)
  if [ -n "$selected" ]; then
    cd "$selected" || exit
  fi
}; 
alias d=dirs_fzf

# wix
alias npmpublic="npm config set registry https://registry.npmjs.org/ && npm config get registry"
alias npmprivate="npm config set registry https://npm.dev.wixpress.com && npm config get registry"
alias mkpr='git push && gh pr create -d -f && pr'

# configs
alias ez="vim $XDG_CONFIG_HOME/zsh/.zshrc"
alias sz='exec zsh' 
alias ea="vim $XDG_CONFIG_HOME/zsh/aliases.zsh"
alias ev="vim $XDG_CONFIG_HOME/nvim/"
alias dot="vim $HOME/dotfiles"
alias cdot="cd $HOME/dotfiles"
alias -- -="cd -"

# directories
alias gcode="$CODE"
alias gwix="cd $CODE/wix"
alias gd="cd $HOME/Downloads"

# brew
function update_choose() {
  cmds=("brew update && brew upgrade" "brew upgrade --cask --greedy" "npm update -g --fetch-timeout 3000" "yarn global upgrade" "gh extensions upgrade --all" "gup update" "rustup update")
  chose=$(gum choose --no-limit $cmds)
  for cmd in $chose
  do
    eval "$cmd"
  done
}
alias update='update_choose'

# others
alias c="clear"
alias fh='open -a Finder .'
alias fix="stty sane"
alias nuke-desktop='rm -rf ~/Desktop/*'
alias sl=ls

if command -v exa &> /dev/null; then
	alias l='exa -lh --icons'
	alias ll='exa -l --icons'
	alias lt='exa -l --icons --tree --level=2'
else
	alias l='ls -lAh'
	alias ll='ls -l'
fi

alias ls="exa --group-directories-first --icons -a"
alias code="code --user-data-dir ~/.config/vscode --extensions-dir ~/.config/vscode/extensions"
alias tree="ls --tree -I \"node_modules|.git|dist|out|target|.husky\""
alias f="ranger"
alias cat="bat"
alias lcat="bat --paging=always"

# alias bathelp='bat -plhelp'
# help() (
#     set -o pipefail
#     "$@" --help 2>&1 | bathelp
# )


function cd_pkg() {
  head=$(git rev-parse --show-toplevel)
  packages=$(ls -D -r -s accessed --no-icons "${head}"/packages)
  # | grep -E ^wix

  selected=$(echo ${packages} | gum filter --indicator="→")
  
  if [ -n "$selected" ]; then
    cd "${head}/packages/${selected}" || exit
  fi
}

function cd_repo() {
  repos=$(find ~/code/wix ~/code/personal ~/code/playground -type d  -mindepth 1 -maxdepth 1 | sed "s#$HOME/code/##" | grep -v "DS_Store")

  selected=$(echo "${repos}" | "$HOME"/code/playground/gum/gum filter --height 10 --indicator="→")
  
  if [ -n "$selected" ]; then
    cd "$HOME/code/${selected}" || exit
  fi
}

jqjq() {
  # -F tell less exit if output content can be displayed on one screen
  jq -C "$@" | less -FR
}
alias jq="jqjq"

alias g="git"
alias sl="gt l"
alias gst="git status"
alias gca="git commit --amend"
alias gaa="git add -A"
alias gra="git rebase --abort"
alias grc="git rebase --continue"
alias gpf="git push --force"
alias gcm='git commit -m "$(gum input)"'
alias pr="gh vpr"
alias vr="gh vr"
alias ga="git ls-files -m -o --exclude-standard | fzf --height 50% --preview 'bat {-1} --color=always --style changes,numbers' --print0 -m | xargs -0 -t -o git add"
alias gr="git ls-files -m -o --exclude-standard | fzf --print0 -m | xargs -0 -t -o git  -q HEAD --"
alias lg="lazygit"

alias gco="git_checkout"
alias pkg="cd_pkg"
alias repo='cd_repo'
alias r="repo"
alias p="pkg"
alias lnvim='tmux list-panes -a -F "#{session_name} #{command} #{pane_pid} #{pane_title} #{window_name} #{pane_id} #{session_path}" | grep nvim'
alias dinner="go run . -o=🍕,🍔,🥓,🌯,🥒,🍗 --title=\"What's for dinner?\""

alias ta="tmux a"
alias tat="tmux attach -t"
alias tn="tmux new -s \$(pwd | sed 's/.*\///g')"
