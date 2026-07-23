{ pkgs ? import <nixpkgs> { } }:
let
  lightpanda = pkgs.callPackage ./lightpanda { };
in {
  #
  pyanidb = pkgs.callPackage ./pyanidb { };
  avdump2 = pkgs.callPackage ./avdump2 { };
  lightpanda = lightpanda;
  super-curl = pkgs.callPackage ./super-curl { inherit lightpanda; };
  blogwatcher = pkgs.callPackage ./blogwatcher { };
  gifgrep = pkgs.callPackage ./gifgrep { };
  songsee = pkgs.callPackage ./songsee { };
  spogo = pkgs.callPackage ./spogo { };
  oracle = pkgs.callPackage ./oracle { };
  nano-pdf = pkgs.callPackage ./nano-pdf { };
}
