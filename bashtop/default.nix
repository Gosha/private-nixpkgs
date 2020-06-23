{ pkgs ? import <nixpkgs> { }, stdenv ? pkgs.stdenv
, fetchurl ? builtins.fetchurl

}:
let
  version = "0.9.16";
  python = pkgs.python3.withPackages (ps: [ ps.psutil ]);

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

  # That huge lines that creates a dictionary of replacement could probably be expressed in some better way..
  postBuild = ''
    sed -i 's@#\* Set correct names for GNU tools depending on OS@declare -A nix_tools@' bashtop
    sed -i "s@if \[\[ \$system != \"Linux\" \]\]; then tool_prefix=\"g\"; fi@nix_tools=( [\"dd\"]=\"${pkgs.coreutils}/bin/dd\" [\"df\"]=\"${pkgs.coreutils}/bin/df\" [\"stty\"]=\"${pkgs.coreutils}/bin/stty\" [\"tail\"]=\"${pkgs.coreutils}/bin/tail\" [\"realpath\"]=\"${pkgs.coreutils}/bin/realpath\" [\"wc\"]=\"${pkgs.coreutils}/bin/wc\" [\"rm\"]=\"${pkgs.coreutils}/bin/rm\" [\"mv\"]=\"${pkgs.coreutils}/bin/mv\" [\"sleep\"]=\"${pkgs.coreutils}/bin/sleep\" [\"stdbuf\"]=\"${pkgs.coreutils}/bin/stdbuf\" [\"mkfifo\"]=\"${pkgs.coreutils}/bin/mkfifo\" [\"date\"]=\"${pkgs.coreutils}/bin/date\" [\"kill\"]=\"${pkgs.coreutils}/bin/kill\" [\"sed\"]=\"${pkgs.gnused}/bin/sed\" )@" bashtop
    sed -i 's@set_tool="''${tool_prefix}''${tool}"@set_tool="''${nix_tools[$tool]}"@' bashtop
    sed -i "s@\$(curl@\$(${pkgs.curl}/bin/curl@" bashtop
    sed -i "s@\$(ps@\$(${pkgs.coreutils}/bin/ps@" bashtop
    sed -i "s@\$(nproc@\$(${pkgs.coreutils}/bin/nproc@" bashtop
    sed -i "s@\$(date@\$(${pkgs.coreutils}/bin/date@" bashtop
    sed -i "s@\$(uname@\$(${pkgs.coreutils}/bin/uname@" bashtop
    sed -i "s@\$(mktemp@\$(${pkgs.coreutils}/bin/mktemp@" bashtop
    sed -i "s@\$(lscpu@\$(${pkgs.coreutils}/bin/lscpu@" bashtop

    sed -i "s@<(uptime@<(${pkgs.coreutils}/bin/uptime@" bashtop
    sed -i "s@<(sensors@<(${pkgs.lm_sensors}/bin/sensors@" bashtop
    sed -i "s@<(iostat@<(${pkgs.sysstat}/bin/mktemp@" bashtop
    sed -i "s@<(echo@<(${pkgs.coreutils}/bin/echo@" bashtop

    sed -i "s@\$(ip@\$(${pkgs.iproute}/bin/ip@" bashtop
    sed -i "s@\$(locale@\$(${pkgs.locale}/bin/locale@" bashtop
    sed -i "s@python3 @${python}/bin/python3 @" bashtop
  '';
}
