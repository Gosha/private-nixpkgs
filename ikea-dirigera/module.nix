{ lib, home-assistant, fetchFromGitHub, buildHomeAssistantComponent }:

buildHomeAssistantComponent rec {
  owner = "sanjoyg";
  domain = "dirigera_platform";
  version = "2.7.1";

  src = fetchFromGitHub {
    owner = "sanjoyg";
    repo = "dirigera_platform";
    rev = version;
    sha256 = "sha256-N4H07CmIEqUqv1VkLlL1f924TvZ4Cb4IuVKlRYJA9CM=";
  };

  dependencies = [ home-assistant.python3Packages.dirigera ];

  postPatch = ''
    substituteInPlace custom_components/dirigera_platform/manifest.json \
      --replace-fail 'dirigera==1.2.6' 'dirigera==${home-assistant.python3Packages.dirigera.version}' \
      --replace-fail '"version": "0.0.1"' '"version": "${version}"'
  '';

  meta = {
    description = "Home Assistant integration for IKEA Dirigera hubs";
    homepage = "https://github.com/sanjoyg/dirigera_platform";
    license = lib.licenses.mit;
  };
}
