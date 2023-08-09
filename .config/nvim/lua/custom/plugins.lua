local plugins = {
  {
    "christoomey/vim-tmux-navigator",
    lazy = false
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
     "jose-elias-alvarez/null-ls.nvim",
     config = function()
       require "custom.configs.null-ls"
     end,
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "ansible-language-server",
        "bash-language-server",
        "cmake-language-server",
        "docker-compose-language-service",
        "dockerfile-language-server",
        "eslint-lsp",
        "helm-ls",
        "golangci-lint-langserver",
        "perlnavigator",
        "json-lsp",
        "terraform-ls",
        "tailwindcss-language-server",
        "yaml-language-server",
        "lua-language-server",
        "clangd",
        "clang-format",
        "python-lsp-server",
        "html-lsp",
        "css-lsp",
        "prettier",
        "stylua",
      },
    },
  },
}
return plugins
