
function scripts
  set entries (cat package.json | jq -c -r '.scripts | to_entries[]')
  set names (echo $entries | jq -r '.key')
  set script (printf '%s\n' $names | fzf --preview='echo {} | xargs -I @@ jq -r ".scripts[\"@@\"]" package.json | xargs -I {} printf {} | bat --color=always --decorations=never --language sh' --preview-window=right,90%,border-none)
  if test -n "$script"
    set title (echo "󰑮 Running:" | gum style --bold --foreground="2")
    set hint (echo '󰝑 copied to clipboard' | gum style --foreground="7" --italic)
    set command (echo $script | xargs -I @@ jq -r ".scripts[\"@@\"]" package.json)
    echo $title $script "( => $command)"
    echo $hint
    echo "nr $script" | pbcopy
    printf '---------------------------\n'
    nr $script
  end
end
