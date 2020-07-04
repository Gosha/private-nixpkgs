# { pkgs ? import (fetchTarball https://github.com/NixOS/nixpkgs/archive/20.03.tar.gz) {};
{ pkgs ? import <nixpkgs> { }, python3Packages ? pkgs.python3Packages
, buildPythonPackage ? python3Packages.buildPythonPackage
, fetchFromGitHub ? pkgs.fetchFromGitHub, stdenv ? pkgs.stdenv

  # Flags
, withXattr ? true

}:
buildPythonPackage {
  pname = "pyanidb";
  version = "0.2.2-a1";
  postPatch = ''
    # Upgrade some constructs to python3
    2to3 -w .
  '';
  src = fetchFromGitHub {
    owner = "Gosha";
    repo = "pyanidb";
    rev = "8e5a789aeac2d5ff1276e690420525f7b1ad34af";
    sha256 = "0fyrb2b0v1aj8znpzkpzrwxk3qq4hl1754853llzqz1i8z192cgm";
  };
  propagatedBuildInputs = [ ]
    ++ pkgs.lib.optional withXattr python3Packages.xattr;
  meta = with stdenv.lib; {
    homepage = "https://github.com/xyzz/pyanidb";
    description =
      "PyAniDB is a client for AniDB's UDP API. (http://anidb.net/)";
    license = licenses.gpl2;
    maintainers = [ ];
  };
}
