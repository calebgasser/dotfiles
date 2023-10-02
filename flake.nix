{
  description = "Flake for my environments.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim = {
      url = "path:./neovim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = 
  { self 
  , nixpkgs
  , home-manager
  , neovim
  , ...
  }@inputs:
  let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
      config = { allowUnfree = true; };
    };

    lib = nixpkgs.lib;

  in {

    nixosConfigurations = {
     commander = lib.nixosSystem {
       inherit system; 
       modules = [
        ./nixos/commander
       ];
     };

     devone = lib.nixosSystem {
       inherit system;
       modules = [
         ./nixos/devone
       ];
     };

     x220 = lib.nixosSystem {
       inherit system;
       modules = [
         ./nixos/x220
       ];
     };
    };

    homeManagerConfigurations = {
      "cgasser" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
	modules = [
	 {
	   home.packages = [ neovim.packages.${system}.default ];
	 }
          ./home.nix
	];
      };
    };

  };
}
