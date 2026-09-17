# { pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/20.09.tar.gz") { },
{ pkgs ? import <nixpkgs> { }, stdenv ? pkgs.stdenv, fetchurl ? pkgs.fetchurl
, mono ? pkgs.mono }:
stdenv.mkDerivation rec {
  pname = "AVDump2";
  version = "7101";
  src = fetchurl {
    url = "https://cdn.anidb.net/client/avdump2/avdump2_${version}.zip";
    sha256 = "sha256-gH7zyJ31EiATVPdYGbTJlbfJAesxaJIOHmMAB0ZvbjQ=";
  };
  sourceRoot = ".";
  dontStrip = true;
  nativeBuildInputs = [ pkgs.unzip ];
  installPhase = ''
    mkdir -p $out/{files,bin}
    cp -r ./* $out/files
    cat > $out/bin/avdump2 << EOF
    #!/bin/bash
    export LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath [ pkgs.zlib stdenv.cc.cc.lib ]}\''${LD_LIBRARY_PATH:+:\$LD_LIBRARY_PATH}"
    exec ${mono}/bin/mono $out/files/AVDump2CL.exe "\$@"
    EOF
    chmod a+x $out/bin/avdump2
  '';
}
