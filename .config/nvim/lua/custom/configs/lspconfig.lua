local configs = require("plugins.configs.lspconfig")
local on_attach = configs.on_attach
local capabilities = configs.capabilities

local lspconfig = require "lspconfig"
local servers = { "pylsp", "lua_ls", "html", "cssls", "clangd", "ansiblels",
  "bashls", "cmake", "dockerls", "docker_compose_language_service",
  "eslint", "helm_ls", "golangci_lint_ls", "perlnavigator", "jsonls",
  "terraformls", "tailwindcss", "yamlls",
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- Without the loop, you would have to manually set up each LSP 
-- 
-- lspconfig.html.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
-- }
--
-- lspconfig.cssls.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
-- }
