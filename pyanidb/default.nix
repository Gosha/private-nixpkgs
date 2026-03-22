{ pkgs ? import <nixpkgs> { }, python3Packages ? pkgs.python3Packages
, buildPythonPackage ? python3Packages.buildPythonPackage
, fetchFromGitHub ? pkgs.fetchFromGitHub, withXattr ? true }:

buildPythonPackage {
  pname = "pyanidb";
  version = "0.2.2a3";

  src = fetchFromGitHub {
    owner = "Gosha";
    repo = "pyanidb";
    rev = "81eefb1947ddcd620eab08dee9930787e844120d";
    hash = "sha256-1KWnY/LkO5vexndUbm8u7R2+4VZ+3MJkkITbHxFgPAY=";
  };

  format = "setuptools";

  propagatedBuildInputs = [ python3Packages.pycryptodome ]
    ++ pkgs.lib.optional withXattr python3Packages.xattr;

  meta = with pkgs.lib; {
    homepage = "https://github.com/Gosha/pyanidb";
    description =
      "PyAniDB is a client for AniDB's UDP API. (http://anidb.net/)";
    license = licenses.gpl2;
    maintainers = [ ];
  };
}
