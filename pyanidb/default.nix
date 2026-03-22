{ pkgs ? import <nixpkgs> { }, lib ? pkgs.lib
, python3Packages ? pkgs.python3Packages
, buildPythonPackage ? python3Packages.buildPythonPackage
, fetchFromGitHub ? pkgs.fetchFromGitHub
, pycryptodome ? python3Packages.pycryptodome, xattr ? python3Packages.xattr
, setuptools ? python3Packages.setuptools, wheel ? python3Packages.wheel
, withXattr ? true }:

buildPythonPackage {
  pname = "pyanidb";
  version = "0.2.2a3";

  src = fetchFromGitHub {
    owner = "Gosha";
    repo = "pyanidb";
    rev = "81eefb1947ddcd620eab08dee9930787e844120d";
    hash = "sha256-1KWnY/LkO5vexndUbm8u7R2+4VZ+3MJkkITbHxFgPAY=";
  };

  format = "pyproject";

  nativeBuildInputs = [ setuptools wheel ];

  propagatedBuildInputs = [ pycryptodome ] ++ lib.optional withXattr xattr;

  meta = with lib; {
    homepage = "https://github.com/Gosha/pyanidb";
    description =
      "PyAniDB is a client for AniDB's UDP API. (http://anidb.net/)";
    mainProgram = "anidb";
    license = licenses.gpl2;
    maintainers = [ ];
  };
}
