{ pkgs ? import <nixpkgs> { }, stdenv ? pkgs.stdenv
, fetchurl ? builtins.fetchurl

}:
let
  version = "0.9.16";
  python = pkgs.python3.withPackages (ps: [ ps.psutil ]);
  _replacements = {
    curl = pkgs.curl;
    ps = pkgs.procps;
    nproc = pkgs.coreutils;
    date = pkgs.coreutils;
    uname = pkgs.coreutils;
    mktemp = pkgs.coreutils;
    lscpu = pkgs.coreutils;
    uptime = pkgs.coreutils;
    echo = pkgs.coreutils;
    locale = pkgs.locale;
    dd = pkgs.coreutils;
    df = pkgs.coreutils;
    stty = pkgs.coreutils;
    tail = pkgs.coreutils;
    realpath = pkgs.coreutils;
    wc = pkgs.coreutils;
    rm = pkgs.coreutils;
    mv = pkgs.coreutils;
    sleep = pkgs.coreutils;
    stdbuf = pkgs.coreutils;
    mkfifo = pkgs.coreutils;
    kill = pkgs.coreutils;
    sed = pkgs.gnused;
  } // pkgs.lib.optionalAttrs stdenv.isLinux {
    sensors = pkgs.lm_sensors;
    ip = pkgs.iproute;
    iostat = pkgs.sysstat;
  };
  toSedEval = name: value:
    ''sed -i "s@\$(${name}@\$(${value}/bin/${name}@" bashtop'';
  toSedNamedPipe = name: value:
    ''sed -i "s@<(${name}@<(${value}/bin/${name}@" bashtop'';
  toBashKeyValue = name: value: ''[\"${name}\"]=\"${value}/bin/${name}\"'';
  nix_tools =
    builtins.toString (pkgs.lib.mapAttrsToList toBashKeyValue _replacements);
  replacements = builtins.concatStringsSep "\n"
    (pkgs.lib.mapAttrsToList toSedNamedPipe _replacements
      ++ pkgs.lib.mapAttrsToList toSedEval _replacements);

in stdenv.mkDerivation {
  name = "bashtop-${version}";
  src = fetchurl {
    url = "https://github.com/aristocratos/bashtop/archive/v${version}.tar.gz";
    sha256 = "0rqkaclfrqirwx15h6nf8mg0accrg2zc4c4gh7xl3pc59y380sl3";
  };
  meta = {
    homepage = "https://github.com/aristocratos/bashtop";
    description =
      "Resource monitor that shows usage and stats for processor, memory, disks, network and processes.";
  };
  installPhase = ''
    PREFIX=$out make install
  '';

  # Replace the obvious implicit dependencies
  # $ egrep -o '\$\([a-z]+' result/bin/bashtop | uniq
  # $ egrep -o '<\([a-z]+' result/bin/bashtop | uniq
  postBuild = ''
    sed -i 's@#\* Set correct names for GNU tools depending on OS@declare -A nix_tools@' bashtop
    sed -i "s@if \[\[ \$system != \"Linux\" \]\]; then tool_prefix=\"g\"; fi@nix_tools=( ${nix_tools} )@" bashtop
    sed -i 's@set_tool="''${tool_prefix}''${tool}"@set_tool="''${nix_tools[$tool]}"@' bashtop

    ${replacements}

    sed -i "s@python3 @${python}/bin/python3 @" bashtop
  '';
}
