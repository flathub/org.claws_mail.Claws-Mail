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

Disabled plug-ins due to unresolved dependencies:
- Dillo (assumes `dillo` is available)
- BSFilter (assumes `bsfilter` is available)
- Perl (assumes `perl` is available)

## TODO

Reminders for later consideration.

- TODO: upstream appdata-file
- TODO: Check if we can skip building documentation for _gdata_ dependency.
- TODO: Check if we can integrate with NetworkManager. This feature is now disabled.
- TODO: Investigate if building for i386 is possible.

<!-- NOTES

## References

- [Flatpak manifest permissions](http://docs.flatpak.org/en/latest/sandbox-permissions.html)
- [AppStream metadata (appdata.xml)](https://www.freedesktop.org/software/appstream/docs/sect-Metadata-Application.html)

-->
