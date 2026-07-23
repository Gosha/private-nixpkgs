{ pkgs, stdenv, lib, buildPythonPackage, fetchFromGitHub }:

buildPythonPackage rec {
  pname = "dirigera_platform";
  version = "2.6.8";

  src = fetchFromGitHub {
    owner = "sanjoyg";
    repo = "dirigera_platform";
    rev = version;
    sha256 = "sha256-5eTHJsE5Jof5WSZFkf8/1UQafpgxpGTPuDWQMENgAG0=";
  };

  propagatedBuildInputs = [ pkgs.python312Packages.dirigera ];

  doCheck = false;

  # pythonImportsCheck = [ "pyelectroluxconnect" ];

  meta = with lib; {
    description =
      "Python client package to communicate with the Electrolux Connectivity Platform";
    homepage = "https://github.com/sanjoyg/dirigera_platform";
    license = licenses.mit;
    # maintainers = with maintainers; [ nathan-gs ];
  };
}
