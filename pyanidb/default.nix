# { pkgs ? import (fetchTarball https://github.com/NixOS/nixpkgs/archive/20.03.tar.gz) {};
{ pkgs ? import <nixpkgs> { }, python3Packages ? pkgs.python3Packages
, buildPythonPackage ? python3Packages.buildPythonPackage
, fetchFromGitHub ? pkgs.fetchFromGitHub, stdenv ? pkgs.stdenv

  # Flags
, withXattr ? true

}:
buildPythonPackage {
  pname = "pyanidb";
  version = "0.2.2-a2";
  postPatch = ''
    # Upgrade some constructs to python3
    2to3 -w .
  '';
  src = fetchFromGitHub {
    owner = "Gosha";
    repo = "pyanidb";
    rev = "dcf129c4b97f01f198a5cab37e0e8c880c330562";
    sha256 = "15wgbz2d2328lsqw4im7dhl42zpzf5wd88dyds02nzzw73km09l0";
  };
  propagatedBuildInputs = [ ]
    ++ pkgs.lib.optional withXattr python3Packages.xattr;
  meta = with pkgs.lib; {
    homepage = "https://github.com/xyzz/pyanidb";
    description =
      "PyAniDB is a client for AniDB's UDP API. (http://anidb.net/)";
    license = licenses.gpl2;
    maintainers = [ ];
  };
}
