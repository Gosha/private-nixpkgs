{ pkgs ? import <nixpkgs> { }, lib ? pkgs.lib
, buildGoModule ? pkgs.buildGoModule, fetchFromGitHub ? pkgs.fetchFromGitHub }:

buildGoModule {
  pname = "songsee";
  version = "0.1.1";

  src = fetchFromGitHub {
    owner = "openclaw";
    repo = "songsee";
    rev = "v0.1.1";
    hash = "sha256-PfyBqa4oiKBXAD3JGdLr7iaGk327YPUvcBF8B7+tfU4=";
  };

  subPackages = [ "cmd/songsee" ];

  vendorHash = "sha256-KEjVrjrIQzK3sjsDjLA9xQpny/RYi6q/b4pdJGrCk6w=";

  meta = with lib; {
    homepage = "https://github.com/openclaw/songsee";
    description = "Terminal audio waveform / spectrogram viewer";
    mainProgram = "songsee";
    license = licenses.mit;
    maintainers = [ ];
  };
}
