local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = { "gopls", "solargraph", "tsserver", "clojure_lsp", "clangd", "fennel_language_server" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

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

lspconfig["elixirls"].setup {
  cmd = { "/Users/gogo/.local/share/nvim/mason/bin/elixir-ls" },
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig["rust_analyzer"].setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = {
        command = "clippy",
      },
    },
  },
}

vim.diagnostic.config {
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
}
