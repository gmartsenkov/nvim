local M = {}

M.setup_lsp = function(attach, capabilities)
   local lspconfig = require "lspconfig"

   -- lspservers with default config
   local servers = { "gopls", "solargraph", "elixirls", "rust_analyzer", "ember", "tsserver", "clojure_lsp" }

   for _, lsp in ipairs(servers) do
      lspconfig[lsp].setup {
         on_attach = attach,
         capabilities = capabilities,
      }
   end
end

vim.diagnostic.config {
   virtual_text = false,
   signs = true,
   underline = true,
   update_in_insert = false,
}

return M
