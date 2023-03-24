local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = { "gopls", "solargraph", "rust_analyzer", "tsserver", "clojure_lsp" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end
lspconfig["elixirls"].setup {
  cmd = { "/Users/gogo/.local/share/nvim/mason/bin/elixir-ls" },
  on_attach = on_attach,
  capabilities = capabilities,
}


vim.diagnostic.config {
   virtual_text = false,
   signs = true,
   underline = true,
   update_in_insert = false,
}

