#!/bin/bash
# Usage: is_vim.sh <tty>
#   tty: Specify tty to check for vim process.
set -x
tty=$1

# Construct process tree.
children=();
while read -r pid ppid; do
  [[ -n $pid && pid -ne ppid ]] && children[ppid]+=" $pid"
done <<< "$(ps -e -o pid= -o ppid=)"

# Get all descendant pids of processes in $tty with BFS
idx=0
IFS=$'\n' read -r -d '' -a pids < <(ps -o pid= -t $tty && printf '\0')
while (( ${#pids[@]} > idx )); do
  pid=${pids[idx++]}; pids+=( ${children[pid]-} )
done

function join_by {
  local d=${1-} f=${2-}
  if shift 2; then
    printf %s "$f" "${@/#/$d}"
  fi
}

# Check whether any child pids are vim
ps -o state= -o comm= -p "$(join_by , "${pids[@]}")" | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'
exit $?
