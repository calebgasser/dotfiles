final: prev: {
  turso-cli = prev.turso-cli.overrideAttrs (_: rec {
    version = "0.86.0";
    src = prev.fetchFromGitHub {
      owner = "tursodatabase";
      repo = "turso-cli";
      rev = "v${version}";
      hash = "sha256-HSRlIRhYDXnQNBTc9gCT6yQizvzQcIW0pwlvh1Spf0U=";
    };
    vendorHash = null;
  });
}