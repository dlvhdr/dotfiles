#!/usr/bin/env bash

ARGS=()
while [[ "$#" -gt 0 ]]; do case $1 in
  --tab)
    tab_index=$2
    shift 2
    ;;
  --title)
    title="$2"
    shift 2
    ;;
  --color)
    color="--color $2"
    shift 2
    ;;
  *)
    ARGS+=("$1")
    shift
    ;;
  esac done

set -- "${ARGS[@]}"

all=$(kitten @ ls -m session:.)
current_title=$(echo "$all" | jq '.[].tabs[].windows[] | select(.is_self) | .title')
if [[ $current_title = "$title" ]]; then
  exit 0
fi

existing_window=$(echo "$all" | jq -r ".[].tabs[].windows[] | select(.title | contains(\"$title\")) | .id")
if [[ ! -z $existing_window ]]; then
  kitten @ focus-window -m id:"$existing_window"
else
  kitten @ launch --type=tab --title="${title}" ${ARGS[@]}
fi

# kitten @ ls -m session:. -m title:${title} &>/dev/null

# if [[ $current_title = "$title" ]]; then
#   exit 0
# elif (kitten @ ls -m session:. -m title:${title} &>/dev/null); then
#   kitten @ focus-window -m title:${title}
# elif [[ -n $tab_index ]]; then
#   kitten @ launch ${color} -m index:$tab_index --title=${title} ${ARGS[@]}
#   kitten @ focus-window -m title:${title}
# else
#   kitten @ launch ${color} --type=tab --title=${title} ${ARGS[@]}
# fi
