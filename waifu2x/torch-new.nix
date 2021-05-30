{ pkgs ? import <nixpkgs> { }
  # Flags
, cudaSupport ? true }:
let
  cudatoolkit = pkgs.cudatoolkit_10_1;
  # in pkgs.gcc49Stdenv.mkDerivation {
  # in pkgs.gcc6Stdenv.mkDerivation {
in pkgs.gcc7Stdenv.mkDerivation {
  # in pkgs.gcc8Stdenv.mkDerivation {
  # in pkgs.stdenvNoCC.mkDerivation {
  # in pkgs.stdenv.mkDerivation {
  name = "torch";
  src = pkgs.fetchFromGitHub {
    repo = "distro";
    fetchSubmodules = true;
    owner = "nagadomi";
    rev = "2dac858fccf28846e969ec8b202f106166fa27b7";
    sha256 = "sha256-CqSj9vE5KQY/URms7hW/OkDrPt2athiu6JhLwKi5MZI=";
  };
  dontConfigure = true;
  buildPhase = ''
    # ${if cudaSupport then "export CC=${cudatoolkit.cc}/bin/gcc" else ""}
    bash ./install.sh -s
  '';
  buildInputs = with pkgs;
    [
      wget
      which
      cmake
      git
      readline62
      libjpeg
      imagemagick
      zeromq
      graphicsmagick
      openssl
      gnuplot
      pkgconfig
      openblas
    ] ++ pkgs.lib.optional cudaSupport cudatoolkit;

  doCheck = true;
  checkPhase = ''
    . install/bin/torch-activate
    bash ./test.sh
  '';
}
