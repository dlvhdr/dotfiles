function ws
  set TARGETPATH ("/etc/profiles/per-user/dlvhdr/bin/mono-cd" $1)

  if not test -z $TARGETPATH
    cd $TARGETPATH
  end
end
