{ lib, stdenv, fetchurl, autoPatchelfHook, glibc }:

let
  version = "0.2.7";
  binaries = {
    "x86_64-linux" = {
      url = "https://github.com/lightpanda-io/browser/releases/download/${version}/lightpanda-x86_64-linux";
      hash = "sha256-cGrMzVDnChi4IG/Js8Fvy4V0uYS21prgWppCYv7KvxI=";
    };
    "aarch64-linux" = {
      url = "https://github.com/lightpanda-io/browser/releases/download/${version}/lightpanda-aarch64-linux";
      hash = "sha256-C0LCBkVxnjzfYCKUrIH7zcEMi7NhBL4IbPMoTax4gAs=";
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
