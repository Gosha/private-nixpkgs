{ pkgs ? import <nixpkgs> { } }:
let
  lib = pkgs.lib;
  version = "2020-05-18";
in pkgs.mosh.overrideAttrs (attrs: {
  version = version;
  src = pkgs.fetchFromGitHub {
    owner = "mobile-shell";
    repo = "mosh";
    rev = "03087e7a761df300c2d8cd6e072890f8e1059dfa";
    sha256 = "170m3q9sxw6nh8fvrf1l0hbx0rjjz5f5lzhd41143kd1rps3liw8";
  };
  # Err, there's probably a better way to do this
  patches =
    lib.remove (lib.findFirst lib.isAttrs "" attrs.patches) attrs.patches;
})
