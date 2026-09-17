{ pkgs ? import <nixpkgs> { }, lib ? pkgs.lib
, buildGoModule ? pkgs.buildGoModule, fetchFromGitHub ? pkgs.fetchFromGitHub }:

buildGoModule rec {
  pname = "songsee";
  version = "0.1.2";

  src = fetchFromGitHub {
    owner = "openclaw";
    repo = "songsee";
    rev = "v0.1.2";
    hash = "sha256-dETvxFqeIyRTqAvgpunlAI3W+U0JpiR3twxXsURzGQc=";
  };

  subPackages = [ "cmd/songsee" ];

  ldflags = [ "-X main.version=${version}" ];

  postPatch = ''
    substituteInPlace cmd/songsee/main_test.go internal/audio/ffmpeg_test.go \
      --replace-fail /bin/sleep sleep
  '';

  vendorHash = "sha256-81O9/82wSxDoFShRuGjp4ygtHE+RSvqEBYnWR0F/pl4=";

  meta = with lib; {
    homepage = "https://github.com/openclaw/songsee";
    description = "Terminal audio waveform / spectrogram viewer";
    mainProgram = "songsee";
    license = licenses.mit;
    maintainers = [ ];
  };
}
