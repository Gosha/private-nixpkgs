{ pkgs ? import <nixpkgs> { }, python3Packages ? pkgs.python3Packages
, buildPythonPackage ? python3Packages.buildPythonPackage
, fetchPypi ? pkgs.python3Packages.fetchPypi }:
buildPythonPackage rec {
  pname = "shell-gpt";
  version = "1.5.1";
  pyproject = true;
  src = fetchPypi {
    inherit version;
    pname = "shell_gpt";
    sha256 = "1c528f960b1c515c882eec351ba3ac78ba6f306cece9cbe554d3ad350c8b5bfe";
  };
  build-system = [ python3Packages.hatchling ];
  pythonRelaxDeps = [ "rich" ];
  doCheck = false; # Tests requires require API access
  propagatedBuildInputs = with python3Packages; [
    typer
    openai
    prompt-toolkit
    rich
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
