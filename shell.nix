{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/refs/tags/25.05.tar.gz") {} }:

pkgs.mkShell {
  buildInputs = [
    pkgs.which
    pkgs.htop
    pkgs.zlib
    pkgs.less
    pkgs.cacert
#    pkgs.git
#    pkgs.iputils
#    pkgs.iproute2
#    pkgs.dig

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
