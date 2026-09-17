{ pkgs ? import <nixpkgs> { }, lib ? pkgs.lib
, buildNpmPackage ? pkgs.buildNpmPackage, fetchurl ? pkgs.fetchurl }:

buildNpmPackage {
  pname = "oracle";
  version = "0.21.1";

  src = fetchurl {
    url = "https://registry.npmjs.org/@steipete/oracle/-/oracle-0.21.1.tgz";
    hash = "sha256-Y8J3lLyz2gzjFpy2nDVlgXHrojtckmuFt5FhAaHgLQ0=";
  };

  # The published tarball ships prebuilt dist/ output but no lockfile, so a
  # package-lock.json (generated with `npm install --package-lock-only
  # --legacy-peer-deps --ignore-scripts` against the same package.json) is
  # vendored alongside this derivation for buildNpmPackage/fetchNpmDeps.
  postPatch = ''
    cp ${./package-lock.json} package-lock.json
  '';

  npmDepsHash = "sha256-DEVZjPZYqgehOxSM0QTGgPDOT176P+O4srgEx/mFpqE=";

  npmFlags = [ "--ignore-scripts" "--legacy-peer-deps" ];

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
