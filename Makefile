# A Makefile with shorthands for building, installing, running and validating
# flatpak packaging instructions.
#
# SPDX-License-Identifier: MIT
.PHONY: install uninstall build-shell run run-shell validate clean distclean

APPID = org.claws_mail.Claws-Mail
RUNCMD = /app/bin/claws-mail

# Prescribed variables: changing these is not necessary.
APPDATA = $(APPID).appdata.xml
BUNDLE = $(APPID).bundle
MANIFEST = $(APPID).json

build: $(MANIFEST) $(APPDATA) flathub.json static/*
	flatpak-builder --sandbox --force-clean build $(MANIFEST)
	touch build

build-shell:
ifeq ($(MODULE),)
	@echo "MODULE=modulename is missing."
	@exit 1
endif
	flatpak-builder --sandbox --build-shell=$(MODULE) build $(MANIFEST)

run: build
	flatpak-builder --run build $(MANIFEST) $(RUNCMD)

run-shell: build
	flatpak-builder --run build $(MANIFEST) /bin/sh

install: build
	flatpak-builder --sandbox --export-only --user --install build -y $(MANIFEST)

repo: build
	flatpak-builder --sandbox --export-only --repo repo build $(MANIFEST)
	touch repo

$(BUNDLE): repo
	flatpak build-bundle repo $(BUNDLE) $(APPID)

uninstall:
	flatpak uninstall -y --user $(APPID)

validate:
	which appstream-util && appstream-util validate $(APPDATA) || (\
	    flatpak info org.freedesktop.appstream-glib > /dev/null || flatpak install -y --system flathub org.freedesktop.appstream-glib;\
	    flatpak run org.freedesktop.appstream-glib validate $(APPDATA))

distclean: clean
	rm -rf .flatpak-builder

clean:
	rm -rf build build.log repo $(BUNDLE) .flatpak-builder/build .flatpak-builder/cache .flatpak-builder/ccache .flatpak-builder/checksums .flatpak-builder/rofiles

