# Torch doesn't work yet

# { pkgs ? import <nixpkgs> { }, torch ? import ../torch-new.nix { } }:
# pkgs.mkShell {
#   buildInputs = with pkgs; [ cudatoolkit snappy.dev graphicsmagick torch ];
# }
