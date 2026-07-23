{ stdenv, pkgs, fetchFromGitHub, buildHomeAssistantComponent
#, dirigera_platform
}:

buildHomeAssistantComponent rec {

  owner = "sanjoyg";
  domain = "dirigera_platform";
  version = "2.6.8";

  src = fetchFromGitHub {
    owner = "sanjoyg";
    repo = "dirigera_platform";
    rev = version;
    sha256 = "sha256-5eTHJsE5Jof5WSZFkf8/1UQafpgxpGTPuDWQMENgAG0=";
  };

  # propagatedBuildInputs = [ dirigera_platform ];

}
