{ pkgs ? import <nixpkgs> { }, lib ? pkgs.lib, stdenv ? pkgs.stdenv
, fetchurl ? pkgs.fetchurl }:

stdenv.mkDerivation {
  pname = "spogo";
  version = "0.10.3";

  src = fetchurl {
    url =
      "https://github.com/openclaw/spogo/releases/download/v0.10.3/spogo_0.10.3_spogo_linux_amd64_v1.tar.gz";
    sha256 = "b4145fb3ee047c4bf756056daae984715a51b0674fb7d012387060f1ba2777a6";
  };

  sourceRoot = ".";

  dontBuild = true;
  dontConfigure = true;

  installPhase = ''
    mkdir -p $out/bin
    install -m755 spogo $out/bin/spogo
  '';

  meta = with lib; {
    homepage = "https://github.com/openclaw/spogo";
    description = "Spotify TUI/CLI client";
    mainProgram = "spogo";
    license = licenses.mit;
    platforms = [ "x86_64-linux" ];
    maintainers = [ ];
  };
}
