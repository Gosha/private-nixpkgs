{ pkgs ? import <nixpkgs> { }
, lib ? pkgs.lib
, buildGoModule ? pkgs.buildGoModule
, fetchFromGitHub ? pkgs.fetchFromGitHub
}:

buildGoModule rec {
  pname = "wolt-cli";
  version = "2.2.0";

  src = fetchFromGitHub {
    owner = "mekedron";
    repo = "wolt-cli";
    rev = "v${version}";
    hash = "sha256-uRVdDEplxh4u2DDizJmobRh9DExrNh37SYLQvwMtXoo=";
  };

  vendorHash = "sha256-/XM/BF3YIIZzp+it92fv1Z9QBFIQYI75tnqnAE5KsJo=";

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
