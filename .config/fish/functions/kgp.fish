function kgp
  set pod (kubectl get pod --no-headers -o json | jq -j '.items[0].metadata.name')
  echo -n $pod | pbcopy
  gum format --theme=dark "✅ Copied pod name `$pod` to clipboard"
end
