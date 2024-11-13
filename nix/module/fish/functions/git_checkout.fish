function git_checkout
  if test (count $argv) -eq 0
    git branch | gum filter --indicator="→" --placeholder="Checkout branch..." | xargs git checkout
  end
end
