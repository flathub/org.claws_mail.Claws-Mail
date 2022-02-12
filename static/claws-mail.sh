#!/bin/sh
test -S "$XDG_RUNTIME_DIR/gnupg/S.gpg-agent" && echo 'INFO: gpg-agent is available.' || echo 'WARNING: the socket to gpg-agent on the host cannot be found. If you need to use GPG in Claws-Mail, there may be issues. Please make sure gpg-agent is running before starting Claws-Mail.'
test -S "$XDG_RUNTIME_DIR/gnupg/S.scdaemon" && echo 'INFO: scdaemon is available.' || echo 'INFO: the socket to scdaemon on the host cannot be found. Claws-Mail will try to start it and connect to pcscd if needed.'
/usr/bin/gpg-agent --homedir ~/.gnupg --daemon --pinentry-program /app/bin/pinentry || true
echo 'Starting Claws-Mail ...'
/app/bin/claws-mail $*
pkill -TERM "gpg-agent" || true
