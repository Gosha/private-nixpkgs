{ pkgs ? import <nixpkgs> { }, stdenv ? pkgs.stdenv
, fetchurl ? builtins.fetchurl }:
let version = "0.4.3";

in stdenv.mkDerivation {
  name = "slurm-netstat-${version}";
  src = fetchurl {
    url =
      "https://github.com/mattthias/slurm/archive/refs/tags/upstream/${version}.tar.gz";
    sha256 = "1b53sckvg1j8510gi4bc48q61191jcc1nvhp5k8f2ywj2p9c0q5r";
  };
  meta = {
    homepage = "https://github.com/mattthias/slurm";
    description = "yet another network load monitor";
  };
  buildInputs = with pkgs; [ ncurses cmake ];
  buildPhase = ''
    mkdir _build
    cd _build
    cmake ..
    cd ..
    make
  '';
}
