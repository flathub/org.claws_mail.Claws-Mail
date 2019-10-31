# A Makefile with shorthands for building, installing, running and validating
# flatpak packaging instructions.
#
# SPDX-License-Identifier: MIT
.PHONY: install uninstall run validate clean

APPID = org.claws_mail.Claws-Mail
APPDATA = $(APPID).appdata.xml
BUNDLE = $(APPID).bundle
MANIFEST = $(APPID).json
FLATHUB = flathub.json

build: $(MANIFEST) $(APPDATA) $(FLATHUB)
	flatpak-builder --sandbox --force-clean build $(MANIFEST) && touch build

install: build
	flatpak-builder --sandbox --export-only --user --install build $(MANIFEST)

run: build
	flatpak run --user $(APPID)

repo: build
	flatpak-builder --sandbox --export-only --repo repo build $(MANIFEST) && touch repo

$(BUNDLE): repo
	flatpak build-bundle repo $(BUNDLE) $(APPID)

uninstall:
	flatpak uninstall --user $(APPID)

validate:
	flatpak run org.freedesktop.appstream-glib validate-strict $(APPDATA)

clean:
	rm -rf build build.log repo $(BUNDLE)
