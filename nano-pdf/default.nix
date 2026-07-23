{ pkgs ? import <nixpkgs> { }, lib ? pkgs.lib
, python3Packages ? pkgs.python3Packages
, buildPythonApplication ? python3Packages.buildPythonApplication
, fetchPypi ? python3Packages.fetchPypi }:

buildPythonApplication {
  pname = "nano-pdf";
  version = "0.2.1";

  src = fetchPypi {
    pname = "nano_pdf";
    version = "0.2.1";
    hash = "sha256-8ajF6r31pn1/KpnnPjxJpSy7x1S4AYFtRqLr7W0+tZI=";
  };

  format = "pyproject";

  nativeBuildInputs = [ python3Packages.setuptools ];

  propagatedBuildInputs = with python3Packages; [
    typer
    pdf2image
    pypdf
    pytesseract
    google-genai
    python-dotenv
    pillow
  ];

  doCheck = false;

  meta = with lib; {
    homepage = "https://github.com/gavrielc/Nano-PDF";
    description =
      "CLI tool to edit PDF slides using natural language prompts, powered by Gemini 3 Pro Image";
    mainProgram = "nano-pdf";
    license = licenses.mit;
    maintainers = [ ];
  };
}
