function mkfile --description="Create file and its directory path"
  set -l file $argv[1]
  mkdir -p (dirname $file) && touch $file
end

function mk --description="Create file or directory"
  set -l file $argv[1]
  if string match -r \/\$ $file
    # create directories only
    mkdir -p $file
  else
    mkfile $file
  end
end
