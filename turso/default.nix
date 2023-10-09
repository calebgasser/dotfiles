final: prev: {
  turso-cli = prev.buildGo121Module rec {
    inherit (prev.turso-cli.drvAttrs)
      pname nativeBuildInputs tags preBuild preCheck postInstall;
    inherit (prev.turso-cli) meta;
    version = "0.86.0";
    src = prev.fetchFromGitHub {
      owner = "tursodatabase";
      repo = "turso-cli";
      rev = "v${version}";
      hash = "sha256-HSRlIRhYDXnQNBTc9gCT6yQizvzQcIW0pwlvh1Spf0U=";
    };
    vendorSha256 = "sha256-6ZvqVVSQVReFef/Ku2G9+0uqAZb1GhqGSlr0rZbULbA=";
  };
  # turso-cli = prev.turso-cli.overrideAttrs (_: rec {
  #   version = "0.86.0";
  #   src = prev.fetchFromGitHub {
  #     owner = "tursodatabase";
  #     repo = "turso-cli";
  #     rev = "v${version}";
  #     hash = "sha256-HSRlIRhYDXnQNBTc9gCT6yQizvzQcIW0pwlvh1Spf0U=";
  #   };
  #   vendorHash = null;
  # });
}