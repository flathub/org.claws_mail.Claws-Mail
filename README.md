# Unofficial flatpak for Claws-Mail

The flathub recipe for building [Claws-Mail](https://claws-mail.org) as a flatpak distributable package.

## Functionality

Claws-Mail with the following plug-ins:

- ACPI notifier
- Address keeper
- Archive
- Attach warner
- Attachment remover
- Bogofilter
- Clamd
- FetchInfo
- GData
- Libravatar
- Lite-HTML viewer
- MBox mailstore support
- Manage sieve
- New Mail-notifications
- Notifications
- PDF Viewer
- PGP/Core
- PGP/Inline
- PGP/MIME
- RSSyl
- S/MIME
- Spam Assassin
- Spam report
- TNEF parser
- vCalendar

## Running Claws-Mail

As _Claws-Mail_ inside the flatpak is fairly isolated from the host system, it will start and kill its own `gpg-agent` for internal use. Assuming your `~/.gnupg` has the appropriate keys, Claws-Mail will be able to sign/verify, encrypt/decrypt your email messages.

In some cases, you will want to communicate directly with `gpg-agent` running on the host. For example, to provide access to smartcards. You can do this by starting Claws-Mail using: `flatpak run --filesystem=xdg-run/gnupg:ro org.claws_mail.Claws-Mail`.

Or as a script: (halts if `gpg-agent` is not running)
```
#!/bin/sh
gpg-agent && flatpak run --filesystem=xdg-run/gnupg:ro org.claws_mail.Claws-Mail
```

## Packaging details

### Dependencies

The dependencies are as follows. In addition, the dependencies are in-order in the [Claws-Mail manifest](org.claws_mail.Claws-Mail.json).

Claws-Mail dependencies:
- libetpan

Plug-in with dependencies:
- TNEF
  - libytnef
- PDF-viewer
  - libpoppler
    - libopenjpeg
- vCalendar
  - libical
- Lite HTML-viewer
  - libgumbo
- GData
  - liboauth
  - libuhttpmock
- Bogofilter
  - bogofilter (cli filter application)
- GPG
  - pinentry

Disabled plug-ins due to unresolved dependencies:
- Dillo (assumes `dillo` is available)
- BSFilter (assumes `bsfilter` is available)
- Perl (assumes `perl` is available)

## TODO

Reminders for later consideration.

- TODO: fix issue with contacting smartcards/yubikeys, either:
  - Manage to get the `pcsc` socket working to facilitate pass-through.
  - Ensure that `gpg-agent` is running on the host before starting Claws-Mail, such that we can make `--filesystem=xdg-run/gnupg:ro` a persistent rule.
- TODO: upstream appdata-file
- TODO: Check if we can integrate with NetworkManager. This feature is now disabled.

<!-- NOTES

## References

- [Flatpak manifest permissions](http://docs.flatpak.org/en/latest/sandbox-permissions.html)
- [AppStream metadata (appdata.xml)](https://www.freedesktop.org/software/appstream/docs/sect-Metadata-Application.html)

-->
