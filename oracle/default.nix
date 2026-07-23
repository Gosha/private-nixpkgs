{ pkgs ? import <nixpkgs> { }, lib ? pkgs.lib
, buildNpmPackage ? pkgs.buildNpmPackage, fetchurl ? pkgs.fetchurl }:

buildNpmPackage {
  pname = "oracle";
  version = "0.16.1";

  src = fetchurl {
    url = "https://registry.npmjs.org/@steipete/oracle/-/oracle-0.16.1.tgz";
    hash = "sha256-falNkB7ti8iWUvH3xpQxl9iEI1drWdnsgc2fhRg+l4Y=";
  };

  # The published tarball ships prebuilt dist/ output but no lockfile, so a
  # package-lock.json (generated with `npm install --package-lock-only
  # --legacy-peer-deps --ignore-scripts` against the same package.json) is
  # vendored alongside this derivation for buildNpmPackage/fetchNpmDeps.
  postPatch = ''
    cp ${./package-lock.json} package-lock.json
  '';

  npmDepsHash = "sha256-Qx2kkYhOAofw7GXl4Kti+/DEPW0yegQmQsrj0NhkwWo=";

  npmFlags = [ "--ignore-scripts" ];

  dontNpmBuild = true;

  meta = with lib; {
    homepage = "https://askoracle.sh";
    description =
      "CLI wrapper around OpenAI Responses API with GPT-5 reasoning modes";
    mainProgram = "oracle";
    license = licenses.mit;
    maintainers = [ ];
  };
}
