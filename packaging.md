# Flatpak-packaging

This document contains questions/answers for matters that are specific to the flatpak-package of Claws-Mail.

## GnuPG interoperability with host

GnuPG -- and smartcards and security keys -- are supported. However, interoperability with the host is somewhat of a complicated matter due to the variety of ways linux distributions can set up GnuPG.

Make sure `gpg-agent` is running on the host system and the socket is available at the default location: `$XDG_RUNTIME_DIR/gnupg`.

## Debugging

Debug-extension: `org.claws_mail.Claws_Mail.Debug`. (Install with: `flatpak install flathub org.claws_mail.Claws_Mail.Debug`)  

The [documentation on debugging](https://docs.flatpak.org/en/latest/debugging.html) explains debugging flatpaks in more detail.

## Flatpak and the Claws-Mail flatpak-package

A few things to know about Flatpak:

- Your linux distribution maintains a few flatpak packages, e.g. on Debian `flatpak` and `libflatpak0`. These packages exist to set up the isolated environment in which flatpak-applications run. Updates to these packages should not influence how a flatpak-package runs directly.
- `flatpak` has an update-mechanism -- through `flatpak update` -- which looks for and downloads updates to installed flatpak-packages, both applications and runtimes. These updates are also checked from within your favorite "software installer/updater".
- Individual flatpak-packages make changes to their manifest and content. Hence, also the Claws-Mail flatpak-package.

## What does "unofficial" mean?

The flatpak-package is (currently) not maintained by the original developers. Flatpak-packages on flathub are built from their infrastructure according to a manifest-file that describes the steps to take to package Claws-Mail. You can inspect these files yourself.

- [org.claws_mail.Claws-Mail.json](<org.claws_mail.Claws-Mail.json> "The Claws-Mail manifest file") the manifest containing the dependencies and build instructions.
- [org.freedesktop.Platform](<https://gitlab.com/freedesktop-sdk/freedesktop-sdk>) the SDK and platform that provides the basis for Claws-Mail flatpak.

