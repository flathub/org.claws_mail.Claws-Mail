#!/bin/sh
test -S "$XDG_RUNTIME_DIR/gnupg/S.gpg-agent" && echo 'INFO: gpg-agent is available.' || echo 'WARNING: the socket to gpg-agent on the host cannot be found. If you need to use GPG in Claws-Mail, there may be issues. Please make sure gpg-agent is running before starting Claws-Mail.'
test -S "$XDG_RUNTIME_DIR/gnupg/S.scdaemon" && echo 'INFO: scdaemon is available.' || echo 'INFO: the socket to scdaemon on the host cannot be found. Claws-Mail will try to start it and connect to pcscd if needed.'
SANDBOXING_WARNING_FILE="$HOME/.claws-mail-flatpak-sandboxing"
echo "Checking $SANDBOXING_WARNING_FILE about whether to display the sandboxing-message."
echo 'Check <https://github.com/flathub/org.claws_mail.Claws-Mail> for information on how Flatpak sandboxing determines how your mail is stored.'
test -f $SANDBOXING_WARNING_FILE || (/usr/bin/zenity --question --cancel-label='Show again' --ok-label='Dismiss' --text='Mail is stored in the persistent storage of this Flatpak-package, as is customary for Flatpak. This is necessary for strict sandboxing. See the README at https://github.com/flathub/org.claws_mail.Claws-Mail/ for more information, and how to migrate from the former situation.' && touch $SANDBOXING_WARNING_FILE)
echo 'Starting Claws-Mail ...'
/app/bin/claws-mail $*
