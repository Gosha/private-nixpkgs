# { pkgs ? import (fetchTarball https://github.com/NixOS/nixpkgs/archive/20.03.tar.gz) {};
{ pkgs ? import <nixpkgs> { }, pythonPackages ? pkgs.python3Packages
, buildPythonPackage ? pythonPackages.buildPythonPackage
, fetchFromGitHub ? pkgs.fetchFromGitHub, stdenv ? pkgs.stdenv

  # Flags
, withXattr ? true

}:
buildPythonPackage {
  pname = "pyanidb";
  version = "0.2.1";
  patches = [ ./0001-no-raise-stop-iteration.patch ];
  postPatch = ''
    # Upgrade some constructs to python3
    2to3 -w .
  '';
  src = fetchFromGitHub {
    owner = "xyzz";
    repo = "pyanidb";
    rev = "b9520212aa037da5344117779817337a1ad918f0";
    sha256 = "17inn816llqwp6qhm3d1m50v0xhalvq9vdnd8i76kjzz0ds6r8sm";
  };
  propagatedBuildInputs = [ ]
    ++ pkgs.lib.optional withXattr pythonPackages.xattr;
  meta = with stdenv.lib; {
    homepage = "https://github.com/xyzz/pyanidb";
    description =
      "PyAniDB is a client for AniDB's UDP API. (http://anidb.net/)";
    license = licenses.gpl2;
    maintainers = [ ];
  };
}
