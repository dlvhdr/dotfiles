if status is-interactive
  atuin init fish --disable-up-arrow | source
  set -gx ATUIN_NOBIND "true"

  bind \cr _atuin_search
  bind -M insert \cr _atuin_search
end
