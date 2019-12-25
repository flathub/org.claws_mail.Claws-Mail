#!/bin/sh
/usr/bin/gpg-agent --homedir ~/.gnupg --daemon --pinentry-program /app/bin/pinentry
/app/bin/claws-mail $@

