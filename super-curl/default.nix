{ lib, buildNpmPackage, fetchFromGitHub, makeWrapper, lightpanda }:

buildNpmPackage rec {
  pname = "super-curl";
  version = "0.1.3";

  src = fetchFromGitHub {
    owner = "geoffmiller";
    repo = "super-curl";
    rev = "229770c1721373c009e8a97ad9333ae8037dbeae";
    hash = "sha256-yF0bMI17sj0+THiq/pV+AtNp+iWzjJWCqVC02JiEvk4=";
  };

  npmDepsHash = "sha256-wi7P/LvJx+CPuhUUFTyhZOr20jRGj6pXJyyLf0+NQrw=";

  nativeBuildInputs = [ makeWrapper ];

  dontNpmBuild = true;

  postInstall = ''
    wrapProgram $out/bin/scurl \
      --prefix PATH : ${lib.makeBinPath [ lightpanda ]}
  '';

  meta = with lib; {
    description = "A curl-style CLI that uses a headless browser runtime for JS-heavy pages";
    homepage = "https://github.com/geoffmiller/super-curl";
    license = licenses.mit;
    mainProgram = "scurl";
    maintainers = [ ];
  };
}
