{ pkgs ? import <nixpkgs> { }, stdenv ? pkgs.stdenv
, fetchurl ? builtins.fetchurl }:
let version = "0.4.4";

in stdenv.mkDerivation {
  name = "slurm-netstat-${version}";
  src = fetchurl {
    url =
      "https://github.com/mattthias/slurm/archive/refs/tags/upstream/${version}.tar.gz";
    sha256 = "00mcz49fwvb4x7warrpri6hj5lxr488wvi9j706wr1kgl6d6r11g";
  };
  meta = {
    homepage = "https://github.com/mattthias/slurm";
    description = "yet another network load monitor";
  };
  nativeBuildInputs = with pkgs; [ meson ninja pkg-config ];
  buildInputs = with pkgs; [ ncurses ];
}
