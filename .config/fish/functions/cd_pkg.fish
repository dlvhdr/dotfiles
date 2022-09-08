function cd_pkg
  set head (git rev-parse --show-toplevel)
  set packages (ls -D -r -s accessed --no-icons "$head"/packages)
  # | grep -E ^wix

  set selected (echo $packages  | string split -n " " | gum filter --indicator="→" --height=20)
  
  if test -n "$selected"
    cd "$head/packages/$selected" || exit
  end
end

