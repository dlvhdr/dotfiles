function jqless
  # -F tell less exit if output content can be displayed on one screen
  gojq -C "$argv[-1]" | less -FR
end
