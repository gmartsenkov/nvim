-- EXAMPLE
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = { "html", "cssls", "solargraph" }


local on_attach = function(client, bufnr)
  local conf = require("nvconfig").ui.lsp

  if conf.signature and client.server_capabilities.signatureHelpProvider then
    require("nvchad.lsp.signature").setup(client, bufnr)
  end
end
-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

-- typescript
lspconfig.tsserver.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}

lspconfig.elixirls.setup {
  cmd = { "elixir-ls" };
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}

lspconfig["tailwindcss"].setup {
  init_options = {
    userLanguages = {
      elixir = "phoenix-heex",
      eruby = "erb",
      heex = "phoenix-heex",
      svelte = "html",
    },
  },
  settings = {
    includeLanguages = {
      typescript = "javascript",
      typescriptreact = "javascript",
      ["html-eex"] = "html",
      ["phoenix-heex"] = "html",
      heex = "html",
      eelixir = "html",
      elm = "html",
      erb = "html",
      svelte = "html",
    },
    tailwindCSS = {
      lint = {
        cssConflict = "warning",
        invalidApply = "error",
        invalidConfigPath = "error",
        invalidScreen = "error",
        invalidTailwindDirective = "error",
        invalidVariant = "error",
        recommendedVariantOrder = "warning",
      },
      experimental = {
        classRegex = {
          [[class= "([^"]*)]],
          [[class: "([^"]*)]],
          '~H""".*class="([^"]*)".*"""',
        },
      },
      validate = true,
    },
  },
  on_attach = on_attach,
  capabilities = capabilities,
}

vim.diagnostic.config {
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
}

