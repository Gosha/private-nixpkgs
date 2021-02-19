# { pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/20.09.tar.gz") { },
{ pkgs ? import <nixpkgs> { }, stdenv ? pkgs.stdenv, fetchurl ? pkgs.fetchurl
, mono ? pkgs.mono }:
stdenv.mkDerivation {
  name = "AVDump2";
  src = fetchurl {
    url = "https://static.anidb.net/client/avdump2/avdump2_7100.zip";
    sha256 = "1f8132zx7mimpcw4n34r0a5y6n4jrilmqm2i87dzaywkl08sc0gx";
  };
  dontStrip = true;
  nativeBuildInputs = [ pkgs.unzip ];
  installPhase = ''
    mkdir -p $out/{files,bin}
    cp -r ./* $out/files
    cat > $out/bin/avdump2 << EOF
    #!/bin/bash
    ${mono}/bin/mono $out/files/AVDump2CL.exe "\$@"
    EOF
    chmod a+x $out/bin/avdump2
  '';
}
