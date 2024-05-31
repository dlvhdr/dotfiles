function pkg
  set head (git rev-parse --show-toplevel)
  set packages (ls -1 -D -r -s accessed --icons=never "$head"/packages "$head"/services "$head"/shared "$head"/tests 2>/dev/null | grep '^[a-zA-Z]') 

  if not set -q packages[1]
    echo "no packages/services"
    return
  end

  set selected (echo $packages  | string split -n " " | gum filter --indicator="→" --height=20)
  
  if test -n "$selected"
    if test -d "$head/packages/$selected"
      cd "$head/packages/$selected"
    else if test -d "$head/services/$selected"
      cd "$head/services/$selected"
    else if test -d "$head/shared/$selected"
      cd "$head/shared/$selected"
    end
  end
end

