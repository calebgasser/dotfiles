final: prev: {
  turso-cli = prev.buildGo121Module rec {
    inherit (prev.turso-cli.drvAttrs)
      pname nativeBuildInputs tags preCheck postInstall;
    inherit (prev.turso-cli) meta;
    version = "0.86.0";
    src = prev.fetchFromGitHub {
      owner = "tursodatabase";
      repo = "turso-cli";
      rev = "v${version}";
      hash = "sha256-HSRlIRhYDXnQNBTc9gCT6yQizvzQcIW0pwlvh1Spf0U=";
    };
    preBuild = ''
      echo "v${version}" > internal/cmd/version.txt
    '';
    vendorSha256 = "sha256-6ZvqVVSQVReFef/Ku2G9+0uqAZb1GhqGSlr0rZbULbA=";
  };
}