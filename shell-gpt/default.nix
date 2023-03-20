{ pkgs ? import (fetchTarball
  "https://github.com/NixOS/nixpkgs/archive/d586805a5c24e643b713306dfd773a6a8f97aff6.tar.gz")
  { }, python3Packages ? pkgs.python3Packages
, buildPythonPackage ? python3Packages.buildPythonPackage
, fetchPypi ? pkgs.python3Packages.fetchPypi }:
buildPythonPackage rec {
  pname = "shell-gpt";
  version = "0.7.3";
  src = fetchPypi {
    inherit version;
    pname = "shell_gpt";
    sha256 = "sha256:1wmnjq4mimw7ak8jav1h1dcjfi3wl9xc12b2ygxlrw91vcp36bwm";
  };
  doCheck = false; # Tests requires require API access
  propagatedBuildInputs = with python3Packages; [
    typer
    requests
    rich
    click
    distro
  ];
  meta = with pkgs.lib; {
    homepage = "https://github.com/ther1d/shell_gpt";
    description =
      "A command-line productivity tool powered by ChatGPT, will help you accomplish your tasks faster and more efficiently.";
    license = licenses.mit;
    maintainers = [ ];
  };
}
