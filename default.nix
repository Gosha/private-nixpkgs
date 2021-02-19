{ pkgs ? import <nixpkgs> { } }: {
  #
  pyanidb = pkgs.callPackage ./pyanidb { };
  avdump2 = pkgs.callPackage ./avdump2 { };
}
