_get_pane_info() {
    tmux list-panes -s -F "#{pane_id} #{window_id} #{pane_current_command}"
}

get_pane_id_by_command() {
    cmd_name=$1
    pane_id=$(_get_pane_info |
        awk -v cmd_name="$cmd_name" '$3 == cmd_name { print $1; exit }')
    echo "$pane_id"
}

get_window_id_by_command() {
    cmd_name=$1
    window_id=$(_get_pane_info |
        awk -v cmd_name="$cmd_name" '$3 == cmd_name { print $2; exit }')
    echo "$window_id"
}
