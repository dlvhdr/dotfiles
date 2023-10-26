# properly setup gpg tty
set -e SSH_AUTH_SOCK
set -U -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)

set -x GPG_TTY (tty)

if not test (pgrep gpg-agent)
  gpg-agent --daemon --no-grab >/dev/null 2>&1
end
