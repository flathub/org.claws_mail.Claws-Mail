{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/refs/tags/25.05.tar.gz") {} }:

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
    pkgs.appstream
  ];
}
