# Unofficial flatpak for Claws-Mail

The flathub recipe for building [Claws-Mail](https://claws-mail.org) as a flatpak distributable package.

See [packaging.md for flatpak-package details](packaging.md)

## Functionality

Claws-Mail features: _Enchant_, _GnuTLS_, _Iconv_, _IPv6_, _LDAP_, _libetpan_, _librSVG_, _libSM_, _NetworkManager_, _OAuth2_.

And the following plug-ins:

- ACPI notifier
- Address keeper
- Archive
- Attach warner
- Attachment remover
- Bogofilter
- Clamd
- FetchInfo
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

### Extra plugins

This application provides a [Flatpak extension](https://docs.flatpak.org/en/latest/extension.html) entrypoint to install additional plugins as Flatpak extensions.

As of the time of writing, there are no extra plugins published yet but most up-to-date information take a look [here](https://flathub.org/apps/org.claws_mail.Claws-Mail) -> bottom of the page -> 'Addons'.

#### For plugin developers/packagers

Plugin files should be installed into `/app/extra-plugins/<PLUGIN_NAME>` as installation prefix, such as binaries are installed into `/app/extra-plugins/<PLUGIN_NAME>/bin` and libraries are installed into `/app/extra-plugins/<PLUGIN_NAME>/lib`, etc.

#### For plugin users

Plugins will follow naming convention of `org.claws_mail.Claws.Mail.Plugin.<PLUGIN_NAME>`. Inside Flatpak sandbox, plugin will be available under `/app/extra-plugins/<PLUGIN_NAME>`. For convenience, there's `/app/etra-plugins/lib` directory that combines libraries from all plugins. No need to look for plugin shared library in plugin-specific directory - it is all in one place.

## Contributions

With contributions and feedback by:

- [scabala](<https://github.com/scabala>)

## TODO

Reminders for later consideration.

- TODO: optional dependencies:
  - libwebkit for fancy plugin
  - pygobject for python plugin
- TODO: upstream appdata-file

<!-- NOTES

## References

- [Flatpak manifest permissions](http://docs.flatpak.org/en/latest/sandbox-permissions.html)
- [AppStream metadata (appdata.xml)](https://www.freedesktop.org/software/appstream/docs/sect-Metadata-Application.html)

-->
