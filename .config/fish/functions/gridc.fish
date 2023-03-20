function gridc
  kubectl get pod -l kore/grid-app-id=3b5f489a-28b3-419c-92a8-fd1a746f0069 --no-headers -o json | gojq -rj '.items[0].metadata.name' | pbcopy
end
