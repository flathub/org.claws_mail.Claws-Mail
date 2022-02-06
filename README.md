# Unofficial flatpak for Claws-Mail

The flathub recipe for building [Claws-Mail](https://claws-mail.org) as a flatpak distributable package.

See [packaging.md for flatpak-package details](packaging.md)

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
- libnotify
- libcanberra
- libenchant
- libnm (NetworkManager)
  - intltool
  - libndp
  - dbus-glib

Plug-ins with their dependencies:
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

- FIXME: how to handle GPG and card access?
  - `gpg-agent` not running, means neither `gpg-agent` socket nor `scdaemon` socket available.
  - some distros make `gpg-agent` available at login time, so `$XDG_RUNTIME/gnupg/S.gpg-agent` is available whenever flatpak runs.
  - after running `gpg --card-status` for the first time, `scdaemon` socket is available at `$XDG_RUNTIME_DIR/gnupg/S.scdaemon`.
  - after `gpg-agent` and `scdaemon` are both started, sockets are available at `$XDG_RUNTIME_DIR/gnupg` for both.
  - `gpg-agent` can be run in different ways, exhibiting different constraints/limitations.
  - PARTS: running `gpg-agent` in container is only a solution if `gpg-agent` is not yet running on host.
  - PARTS: `--socket=pcsc` is only a solution until `scdaemon` is running on the host.
  - PARTS: keeping `--socket=pcsc` for "back-up purposes" could mean that `gpg-agent` runs on the host while `scdaemon` runs in the container, from different binary packages/compiler options/dependencies. This is not a problem in itself, but it would be nicer to use everything from the host and just hook into the existing unix sockets (named pipes?).
- FIXME: need to update URLs of screenshots when merging into master.
- TODO: add accessibility bus. (something like `org.a11y.*`)
- TODO: optional dependencies:
  - libwebkit for fancy plugin
  - pygobject for python plugin
- TODO: upstream appdata-file

<!-- NOTES

## References

- [Flatpak manifest permissions](http://docs.flatpak.org/en/latest/sandbox-permissions.html)
- [AppStream metadata (appdata.xml)](https://www.freedesktop.org/software/appstream/docs/sect-Metadata-Application.html)

-->
