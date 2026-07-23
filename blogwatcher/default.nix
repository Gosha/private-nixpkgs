{ pkgs ? import <nixpkgs> { }, lib ? pkgs.lib
, buildGoModule ? pkgs.buildGoModule, fetchFromGitHub ? pkgs.fetchFromGitHub }:

buildGoModule {
  pname = "blogwatcher";
  version = "0.0.3";

  src = fetchFromGitHub {
    owner = "Hyaxia";
    repo = "blogwatcher";
    rev = "v0.0.3";
    hash = "sha256-Zd3Pqv2gCB6EwSR5uh88aHEXtI49mmXSbKuVDf2vAGA=";
  };

  subPackages = [ "cmd/blogwatcher" ];

  vendorHash = "sha256-TfcMKlr/mdElYLf2zw9iNLJgGVJzMVg97jJm015ClTQ=";

  meta = with lib; {
    homepage = "https://github.com/Hyaxia/blogwatcher";
    description = "Stay on top of your favorite blogs";
    mainProgram = "blogwatcher";
    license = licenses.mit;
    maintainers = [ ];
  };
}
