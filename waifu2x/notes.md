# Snippets

To try building torch:

```shell
$ nix-shell --pure torch-new.nix \
  --command 'unpackPhase && cd source && eval "$buildPhase"; return'
```

Without CUDA:

```shell
$ nix-shell --pure torch-new.nix \
  --arg cudaSupport false \
  --command 'unpackPhase && cd source && eval "$buildPhase"; return'
```

```
  --command 'unpackPhase && cd source && eval "$buildPhase" && eval "$checkPhase"; return'
```

# State

Sometimes the build process fails on "THC" related stuff.
Sometimes it succeeds, but the tests fail to run.

```console
$ # install.sh:
$ cd ${THIS_DIR}/extra/cutorch && $PREFIX/bin/luarocks make rocks/cutorch-scm-1.rockspec
[...]
Killed
CMake Error at THC_generated_THCTensorMathPairwise.cu.o.cmake:267 (message):
  Error generating file
  /home/gosha/git/private-nix/waifu2x/source/extra/cutorch/build/lib/THC/CMakeFiles/THC.dir//./THC_generated_THCTensorMathPairwise.cu.o


make[2]: *** [lib/THC/CMakeFiles/THC.dir/build.make:161: lib/THC/CMakeFiles/THC.dir/THC_generated_THCTensorMathPairwise.cu.o] Error 1
make[2]: *** Waiting for unfinished jobs....
```

An attempt was made to use older versions of cudatoolkit in [torch-old.nix](./torch-old.nix)

---

Q: Hold on. Is CUDA optional?

A: Yep! Interestingly, the tests fail in the same way.
So the error might be with something other than CUDA!

```
Running 164 tests
  1/164 tanh ............................................................ [PASS]
  2/164 testCholesky .................................................... [WAIT]
 ** On entry to DGEMM  parameter number 13 had an illegal value
 ** On entry to DPOTRF parameter number  4 had an illegal value
  2/164 testCholesky .................................................... [ERROR]
  3/164 bhistc .......................................................... [WAIT]
./test.sh: line 33: 11449 Segmentation fault      th -ltorch -e "torch.test()"
```

# Links

- waifu2x:

  - https://github.com/nagadomi/waifu2x Main repo

  - https://github.com/DeadSix27/waifu2x-converter-cpp

  > This is a reimplementation of waifu2x (original) converter function, in C++, using OpenCV.
  > This is also a reimplementation of waifu2x python version by Hector Martin.
  > You can use this as command-line tool of image noise reduction or/and scaling.

- torch:

  - http://torch.ch/docs/getting-started.html
  - https://github.com/torch/distro/pull/254

    > update README.md install from CUDA 7.5 or higher

  - https://github.com/nagadomi/distro
    Fork of `torch` by the author of waifu2x.
    Claims to support newer versions of CUDA.

    > Unofficial maintenance repository of Torch7.
    > It supports CUDA10.1, Volta, Turing, Docker https://hub.docker.com/r/nagadomi/torch7

    > For CUDA10.x, see [#253](https://github.com/nagadomi/waifu2x/issues/253#issuecomment-445448928)

- cuda on WSL:

  - https://dinhanhthi.com/docker-wsl2-windows/

  - https://docs.nvidia.com/cuda/wsl-user-guide/index.html

  Says:

  > Note that NVIDIA Container Toolkit does not yet support Docker Desktop WSL 2 backend.
  > Use Docker-CE for Linux instead inside your WSL 2 Linux distribution.

- see also:

  - Deals with cudatoolkit too https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/development/python-modules/pytorch/default.nix#L304

# Errors

- Newer nixpkgs versions don't have old cudatoolkit versions (v<=9).
  But older do.
  So in theory it should work to just reference and old version of nixpkgs

- Looks like some packages expect specific ranges of GCC version.
  This can be accomodated with either `nixpkgs.gccXStdenv`, or by setting `CC=$(gccX)`

  On that note; it looks like what's being used to compile some stuff is `nvcc` from cudatoolkit?
  Maybe that's why other stuff breaks.

  https://github.com/NixOS/nixpkgs/blob/6933d068c5d2fcff398e802f7c4e271bbdab6705/pkgs/development/compilers/cudatoolkit/common.nix#L231 Maybe this is a better choise of `CC` env?

- When running with `stdenvNoCC` and setting `CC` manually:

  > ```
  >   Error running link command: No such file or directory
  > ```

- Hmm..
  > ```
  > -- The C compiler identification is GNU 7.5.0
  > -- The CXX compiler identification is GNU 6.5.0
  > ```

# Various

- `stdenv.mkDerivation` has an `installPhase`, which creates `$out`

  Maybe move the created `$source/install` with that when finished?

- Noticed that there's more build errors further up in the log.
  They were related to QT thought, so might not be relevant (yet).
