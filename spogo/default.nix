{
  pkgs ? import <nixpkgs> { },
  lib ? pkgs.lib,
  stdenv ? pkgs.stdenv,
  fetchurl ? pkgs.fetchurl,
}:

stdenv.mkDerivation {
  pname = "spogo";
  version = "0.13.0";

  src = fetchurl {
    url = "https://github.com/openclaw/spogo/releases/download/v0.13.0/spogo_0.13.0_linux_amd64.tar.gz";
    sha256 = "sha256-kU711EW3CPnC01fSNF7WIlpUcmN/EAsQw22f4/7aeig=";
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
