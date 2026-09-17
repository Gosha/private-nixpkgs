{ pkgs ? import <nixpkgs> { }
, lib ? pkgs.lib
, buildGoModule ? pkgs.buildGoModule
, fetchFromGitHub ? pkgs.fetchFromGitHub
}:

buildGoModule rec {
  pname = "wolt-cli";
  version = "2.4.1";

  src = fetchFromGitHub {
    owner = "mekedron";
    repo = "wolt-cli";
    rev = "v${version}";
    hash = "sha256-JrtdcJe63OQvuPG9pMv2uk7VS+8thK410V8nrZlg/HA=";
  };

  vendorHash = "sha256-7reCguzo+A8m9kPV9k1Qh1oqbaYUEzXwDzaOXfWtsT0=";

  subPackages = [
    "cmd/wolt"
    "cmd/wolt-mcp"
  ];

  meta = with lib; {
    homepage = "https://github.com/mekedron/wolt-cli";
    description = "CLI for Wolt: discover venues, inspect menus and options, manage carts, and preview checkout from the terminal";
    mainProgram = "wolt";
    license = licenses.mit;
    maintainers = [ ];
  };
}
