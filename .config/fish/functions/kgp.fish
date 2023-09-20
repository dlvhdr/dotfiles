function kgp
  set pod (kubectl get pod --no-headers -o json | jq -rj '.items[0].metadata.name')
  echo $pod | pbcopy
  echo "Copied pod name $pod to clipboard"
end
