function pkg
  set head (git rev-parse --show-toplevel)
  set packages (ls -D -r -s accessed --no-icons "$head"/packages 2>/dev/null) 

  if not set -q packages[1]
    echo "no packages"
    return
  end

  set selected (echo $packages  | string split -n " " | gum filter --indicator="→" --height=20)
  
  if test -n "$selected"
    cd "$head/packages/$selected" || return
  end
end

