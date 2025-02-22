# A Makefile with shorthands for building, installing, running and validating
# flatpak packaging instructions.
#
# SPDX-License-Identifier: MIT
#
# To use:
# - modify `$(APPID)` and `$(RUNCMD)` in Makefile to reflect flatpak application.
# - requires `$(APPID).json` and `$(APPID).appdata.xml` to exist.
# - `static/` directory for static files. Makefile assumes it exists.
# - `flathub.json` file with build instructions for flathub.
#
# Directories `build`, `repo`, `.flatpak-builder` may be created as part of the process.

.PHONY: download install uninstall build build-shell run run-shell validate distclean clean

APPID = org.claws_mail.Claws-Mail
RUNCMD = /app/bin/claws-mail.sh

# Prescribed variables: changing these is not necessary.
APPDATA = $(APPID).appdata.xml
BUNDLE = $(APPID).bundle
MANIFEST = $(APPID).json
BUILDCMD = flatpak-builder --sandbox
ifdef IN_NIX_SHELL
	# don't bother fiddling around with fuse if we are already in a separate environment
	BUILDCMD += --disable-rofiles-fuse
endif

build: $(MANIFEST) $(APPDATA) flathub.json static/*
	$(BUILDCMD) --force-clean --disable-updates build $(MANIFEST)
	touch build

build-shell:
ifeq ($(MODULE),)
	@echo "MODULE=modulename is missing."
	@exit 1
endif
	$(BUILDCMD) --force-clean --stop-at=$(MODULE) build $(MANIFEST)
	#-----------------------------------------------------------------------------
	# All packages prior to build module have been built. Now press enter to
	# enter the build-shell.
	#-----------------------------------------------------------------------------
	@read -p 'Press any key to continue into build-shell or CTRL+C to abort.' _tempvar
	$(BUILDCMD) --build-shell=$(MODULE) build $(MANIFEST)

# Target `download` was defined for nix-shell to avoid needing internet access for every build. I'm not sure if this is still as useful.
download:
	$(BUILDCMD) --force-clean --download-only build $(MANIFEST)

# Run the flatpak application from the build directory.
# (There may on occasion be subtle difference with running from installed
# flatpak package.)
run: build
	flatpak-builder --run build $(MANIFEST) $(RUNCMD)

# Start a shell within the flatpak package.
run-shell: build
	flatpak-builder --run build $(MANIFEST) /bin/sh

# Install application directly from build-directory.
install: build
	$(BUILDCMD) --export-only --user --default-branch=local-build --install build -y $(MANIFEST)
	@echo
	@echo "Run with: flatpak run $(APPID)//local-build"

# Construct repository for application.
repo: build
	$(BUILDCMD) --export-only --repo repo build $(MANIFEST)
	touch repo

$(BUNDLE): repo
	flatpak build-bundle repo $(BUNDLE) $(APPID)

uninstall:
	flatpak uninstall -y --user $(APPID)//local-build

# Validate appdata-file to appstream validation rules.
validate:
	@(type appstream-util 1>/dev/null 2>&1 && (appstream-util validate $(APPDATA) || true)) || \
		echo "'appstream-util' cannot be found. This is needed for \"appdata\" metadata validation."

distclean: clean
	rm -rf .flatpak-builder

# Clean up build-directory and log, repository, bundle, and flatpak build-cache
# of current and previous builds, but preserve archive downloads and git
# repositories.
clean:
	rm -rf build build.log repo $(BUNDLE) .flatpak-builder/build .flatpak-builder/cache .flatpak-builder/ccache .flatpak-builder/checksums .flatpak-builder/rofiles

