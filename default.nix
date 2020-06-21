{ pkgs ? import <nixpkgs> { } }: { pyanidb = pkgs.callPackage ./pyanidb { }; }
