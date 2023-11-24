final: prev: {
  pre-commit = prev.python3Packages.buildPythonApplication rec {
    inherit (prev.pre-commit.drvAttrs)
      pname;
    inherit (prev.pre-commit) meta;

     version = "3.5.0";
    doCheck = false;
    disabled = prev.python3Packages.pythonOlder "3.8";
    src = prev.fetchFromGitHub {
      owner = "pre-commit";
      repo = "pre-commit";
      rev = "v${version}";
      hash = "sha256-KQshmYJtXCfbfDpS4+8p8x+CXjDf4jrtxNHItrRojZ8=";
    };
  };
}
