{
  description = "Neovim plugin overlay";
  inputs = {
    nvim-lspconfig = {
       url = "github:neovim/nvim-lspconfig";
       flake = false;
    };
    telescope = {
      url = "github:nvim-telescope/telescope.nvim";
      flake = false;
    };
    telescope-file-browser = {
      url = "github:nvim-telescope/telescope-file-browser.nvim";
      flake = false;
    };
  };
  outputs = 
  { self
  , nixpkgs
  , nvim-lspconfig
  , telescope
  , telescope-file-browser
  }: {
    overlays.default = final: prev: {
      nvimPlugins = {
        nvim-lspconfig = prev.pkgs.vimUtils.buildVimPluginsFrom2Nix rec {
          pname = "nvim-lspconfig";
          version = src.latModifiedDate;
          src = nvim-lspconfig;
        };
	telescope = prev.pkgs.vimUtils.buildVimPluginFrom2Nix rec {
          pname = "telescope";
          version = src.lastModifiedDate;
          src = telescope;
        };
        telescope-file-browser = prev.pkgs.vimUtils.buildVimPluginFrom2Nix rec {
          pname = "telescope-file-browser";
          version = src.lastModifiedDate;
          src = telescope-file-browser;
        };
      };
    };
  };
}
