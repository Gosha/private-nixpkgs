# { pkgs ? import (fetchTarball https://github.com/NixOS/nixpkgs/archive/20.03.tar.gz) {};
{ pkgs ? import <nixpkgs> { }, python3Packages ? pkgs.python3Packages
, buildPythonPackage ? python3Packages.buildPythonPackage
, fetchFromGitHub ? pkgs.fetchFromGitHub, stdenv ? pkgs.stdenv

  # Flags
, withXattr ? true

}:
buildPythonPackage {
  pname = "pyanidb";
  version = "0.2.2-a3";
  postPatch = ''
    # Upgrade some constructs to python3
    2to3 -w .
  '';
  src = fetchFromGitHub {
    owner = "Gosha";
    repo = "pyanidb";
    rev = "81eefb1947ddcd620eab08dee9930787e844120d";
    hash = "sha256-1KWnY/LkO5vexndUbm8u7R2+4VZ+3MJkkITbHxFgPAY=";
  };
  propagatedBuildInputs = [ python3Packages.pycryptodome ]
    ++ pkgs.lib.optional withXattr python3Packages.xattr;
  meta = with pkgs.lib; {
    homepage = "https://github.com/xyzz/pyanidb";
    description =
      "PyAniDB is a client for AniDB's UDP API. (http://anidb.net/)";
    license = licenses.gpl2;
    maintainers = [ ];
  };
}
