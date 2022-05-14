# auto-notify
# AUTO_NOTIFY_IGNORE+=("bpytop" "git diff" "g diff" "glow" "go run" "slides" "nvim" "vim" "v " "tig" "g commit" "git commit" "less" "ranger")
zstyle ':notify:*' blacklist-regex 'glow|bpytop|go run|slides|nvim|vim|^v[:blank:]|^g[:blank:]|less|^lg$|^dot$'
