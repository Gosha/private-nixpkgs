{ pkgs ? import <nixpkgs> { }, lib ? pkgs.lib, stdenv ? pkgs.stdenv
, fetchurl ? pkgs.fetchurl, autoPatchelfHook ? pkgs.autoPatchelfHook
, glibc ? pkgs.glibc }:

let
  version = "0.4.1";
  binaries = {
    "x86_64-linux" = {
      url = "https://github.com/lightpanda-io/browser/releases/download/${version}/lightpanda-x86_64-linux";
      hash = "sha256-HUCAHnLAvGGyy9PzVivPxG3nt54FaPM/aGtk8uWHYQo=";
    };
    "aarch64-linux" = {
      url = "https://github.com/lightpanda-io/browser/releases/download/${version}/lightpanda-aarch64-linux";
      hash = "sha256-Zkd1x/WracwxiZVMf5NF4lwWfLTazgFhc+Yp+aXoLEI=";
    };
  };
  bin = binaries.${stdenv.hostPlatform.system} or (throw "lightpanda: unsupported system ${stdenv.hostPlatform.system}");
in
stdenv.mkDerivation {
  pname = "lightpanda";
  inherit version;

  src = fetchurl {
    inherit (bin) url hash;
  };

  nativeBuildInputs = [ autoPatchelfHook ];
  buildInputs = [ glibc ];

  dontUnpack = true;
  dontBuild = true;

  installPhase = ''
    install -Dm755 $src $out/bin/lightpanda
  '';

  meta = with lib; {
    description = "Headless browser built for AI agents and automation";
    homepage = "https://github.com/lightpanda-io/browser";
    license = licenses.agpl3Only;
    platforms = [ "x86_64-linux" "aarch64-linux" ];
    mainProgram = "lightpanda";
    maintainers = [ ];
  };
}
