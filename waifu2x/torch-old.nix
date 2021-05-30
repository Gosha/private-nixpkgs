{ pkgs ? import <nixpkgs> { }
  # import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/25bca77c48ddb0bacdb46e7398d948a348d06119.tar.gz") { }
  # import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/2b37fe7a77b618ed259f55c73280312435d42aca.tar.gz") { }
}:
let
  oldPkgs = import (fetchTarball
    "https://github.com/NixOS/nixpkgs/archive/2b37fe7a77b618ed259f55c73280312435d42aca.tar.gz")
    { };
  # pkgs = oldPkgs;
  # in pkgs.gcc6Stdenv.mkDerivation {
in pkgs.gcc49Stdenv.mkDerivation {
  name = "torch";
  src = pkgs.fetchFromGitHub {
    repo = "distro";
    fetchSubmodules = true;
    owner = "torch";
    rev = "0219027e6c4644a0ba5c5bf137c989a0a8c9e01b";
    sha256 = "sha256-pqNkPw3HXAklZ9CB2XdN4HM6CuZlME9IzvnDeQM2nvU=";
    # owner = "nagadomi";
    # rev = "2dac858fccf28846e969ec8b202f106166fa27b7";
    # sha256 = "sha256-CqSj9vE5KQY/URms7hW/OkDrPt2athiu6JhLwKi5MZI=";
  };
  dontConfigure = true;
  buildPhase = ''
    # mkdir $out
    # PREFIX=$out
    # export CC=${pkgs.gcc}/bin/gcc
    # https://github.com/torch/distro/pull/254/files
    export TORCH_NVCC_FLAGS="-D__CUDA_NO_HALF_OPERATORS__"
    bash ./install.sh -s
  '';
  buildInputs = with pkgs; [
    wget
    # cudatoolkit
    # - For CUDA9.x/CUDA8.x, see [#222](https://github.com/nagadomi/waifu2x/issues/222)
    oldPkgs.cudatoolkit_7_5
    # oldPkgs.cudatoolkit_8
    # cudnn # TODO: Is this really needed?
    which
    cmake
    git
    readline62
    libjpeg
    imagemagick
    zeromq
    graphicsmagick
    openssl
    gnuplot
    pkgconfig
    openblas
  ];
  doCheck = true;
  checkPhase = ''
    PATH=$out/bin:$PATH bash ./test.sh
  '';
}
