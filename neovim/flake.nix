{
  description = "A very basic flake";

  inputs.nixvim = {
    url = "github:nix-community/nixvim";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs =
    { self
    , nixpkgs
    , nixvim
    , flake-utils
    }:
    let
      config = {
        options = {
          number = true;
          relativenumber = true;
          shiftwidth = 2;
          colorcolumn = "80";
        };
        clipboard = {
          providers.xclip.enable = true;
          register = "unnamedplus";
        };
        globals.mapleader = " ";
        maps = {
          # Escape using "kj"
          insert."kj" = {
            silent = true;
            action = "<Esc>";
          };

          # Toggle open terminal
          terminal."kj" = {
            silent = true;
            action = "<C-\\><C-n>:ToggleTerm<Cr>";
          };

          normalVisualOp."<leader>tt" = {
            silent = true;
            action = ":ToggleTerm direction=float<CR>";
          };

          normalVisualOp."<leader>tv" = {
            silent = true;
            action = ":ToggleTerm size=100 direction=vertical<CR>";
          };

          normalVisualOp."<leader>th" = {
            silent = true;
            action = ":ToggleTerm direction=horizontal<CR>";
          };

          # Telescope
          normalVisualOp."<leader>ff" = {
            silent = true;
            action = ":Telescope find_files<CR>";
          };
          normalVisualOp."<leader>fg" = {
            silent = true;
            action = ":Telescope live_grep<CR>";
          };
          normalVisualOp."<leader>fb" = {
            silent = true;
            action = ":Telescope buffers<CR>";
          };
          normalVisualOp."<leader>fh" = {
            silent = true;
            action = ":Telescope help_tags<CR>";
          };

          # Close current buffer
          normalVisualOp."<leader>x" = {
            silent = true;
            action = ":Bdelete<CR>";
          };

          # Navigate buffers
          normalVisualOp."<Tab>" = {
            silent = true;
            action = ":bnext<CR>";
          };
          normalVisualOp."<S-Tab>" = {
            silent = true;
            action = ":bprevious<CR>";
          };


          # Remap pane navigation
          normalVisualOp."<A-h>" = {
            silent = true;
            action = ":wincmd h<CR>";
          };
          normalVisualOp."<A-j>" = {
            silent = true;
            action = ":wincmd j<CR>";
          };
          normalVisualOp."<A-k>" = {
            silent = true;
            action = ":wincmd k<CR>";
          };
          normalVisualOp."<A-l>" = {
            silent = true;
            action = ":wincmd l<CR>";
          };

          # Open file browser
          normalVisualOp."<A-n>" = {
            silent = true;
            action = "<cmd>CHADopen<CR>";
          };
        };

        colorschemes.catppuccin = {
          enable = true;
          flavour = "mocha";
        };

        plugins.telescope = {
          enable = true;
        };

        plugins.treesitter = {
          enable = true;
        };

        plugins.leap = {
          enable = true;
        };

        plugins.which-key = {
          enable = true;
        };

        plugins.chadtree = {
          enable = true;
        };

        plugins.bufferline = {
          enable = true;
        };

        plugins.lsp = {
          enable = true;
          servers = {
            clangd = {
              enable = true;
            };
            bashls = {
              enable = true;
            };
            cmake = {
              enable = true;
            };
            cssls = {
              enable = true;
            };
            elixirls = {
              enable = true;
            };
            elmls = {
              enable = true;
            };
            eslint = {
              enable = true;
            };
            gopls = {
              enable = true;
            };
            hls = {
              enable = true;
            };
            html = {
              enable = true;
            };
            java-language-server = {
              enable = true;
            };
            jsonls = {
              enable = true;
            };
            lua-ls = {
              enable = true;
            };
            nixd = {
              enable = true;
            };
            pyright = {
              enable = true;
            };
            rnix-lsp = {
              enable = true;
            };
            rust-analyzer = {
              enable = true;
            };
            svelte = {
              enable = true;
            };
            tailwindcss = {
              enable = true;
            };
            terraformls = {
              enable = true;
            };
            tsserver = {
              enable = true;
            };
            yamlls = {
              enable = true;
            };
            zls = {
              enable = true;
            };
          };
        };

        plugins.lsp-format = {
          enable = true;
        };

        plugins.lsp-lines = {
          enable = true;
        };

        plugins.lspkind = {
          enable = true;
        };

        plugins.nvim-cmp = {
          enable = true;
          # List of sources:
          # https://github.com/hrsh7th/nvim-cmp/wiki/List-of-sources
          sources = [
            { name = "nvim_lsp"; }
            { name = "nvim_lsp_document_symbol"; }
            { name = "nvim_lsp_signature_help"; }
            { name = "luasnip"; }
            { name = "snippy"; }
            { name = "calc"; }
            { name = "spell"; }
            { name = "path"; }
            { name = "buffer"; }
            { name = "git"; }
            { name = "conventionalcommits"; }
            { name = "commit"; }
            { name = "cmdline"; }
            { name = "rg"; }
            { name = "fish"; }
            { name = "kitty"; }
            { name = "crates"; }
            { name = "npm"; }
            { name = "emoji"; }
            { name = "dictionary"; }
          ];
        };

        plugins.toggleterm = {
          enable = true;
          floatOpts = {
            border = "curved";
          };
        };

        plugins.lualine = {
          enable = true;
        };

        plugins.notify = {
          enable = true;
        };

        plugins.rust-tools = {
          enable = true;
        };

        plugins.vim-bbye = {
          enable = true;
        };

      };
    in
    flake-utils.lib.eachDefaultSystem (system:
    let
      nixvim' = nixvim.legacyPackages."${system}";
      nvim = nixvim'.makeNixvim config;
    in
    {
      packages = {
        inherit nvim;
        default = nvim;
      };
    });
}
