{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/4d2b37a84fad1091b9de401eb450aae66f1a741e.tar.gz") {} }:

pkgs.mkShell {
  buildInputs = [
    pkgs.which
    pkgs.htop
    pkgs.zlib
    pkgs.less
    #pkgs.iproute2
    #pkgs.gitMinimal

    pkgs.gnumake
    pkgs.autoconf
    pkgs.libtool
    pkgs.automake
    pkgs.pkg-config

    pkgs.flatpak
    pkgs.flatpak-builder
  ];
}
