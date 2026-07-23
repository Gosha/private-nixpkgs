{ pkgs ? import <nixpkgs> { }, lib ? pkgs.lib
, buildGoModule ? pkgs.buildGoModule, fetchFromGitHub ? pkgs.fetchFromGitHub }:

buildGoModule {
  pname = "gifgrep";
  version = "0.3.0";

  src = fetchFromGitHub {
    owner = "steipete";
    repo = "gifgrep";
    rev = "v0.3.0";
    hash = "sha256-1wr+A8McmODSibQd9qLg8DIuhgQnbbv07WjrDIhGXvo=";
  };

  subPackages = [ "cmd/gifgrep" ];

  vendorHash = "sha256-Bthc6ERm1bXeWI+OMKBeRU3H+I6/Zcrzv7+B7d+segY=";

  meta = with lib; {
    homepage = "https://github.com/steipete/gifgrep";
    description = "Search and grep through GIFs";
    mainProgram = "gifgrep";
    license = licenses.mit;
    maintainers = [ ];
  };
}
