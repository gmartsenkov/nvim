local config = function()
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  local lspconfig = require "lspconfig"
  local servers = { "gopls", "solargraph", "tsserver", "clojure_lsp", "clangd" }

  -- local configs = require 'lspconfig.configs'
  -- configs.nextls = {
  --   default_config = {
  --     cmd = { '/opt/homebrew/bin/nextls',  '--stdio' },
  --     root_dir = lspconfig.util.root_pattern('.git'),
  --     filetypes = { 'elixir' },
  --   },
  -- }
  --
  for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
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
    capabilities = capabilities,
  }

  lspconfig["rust_analyzer"].setup {
    capabilities = capabilities,
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
          command = "clippy",
        },
      },
    },
  }

  lspconfig["lua_ls"].setup {
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = {
            [vim.fn.expand "$VIMRUNTIME/lua"] = true,
            [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
            [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
          },
          maxPreload = 100000,
          preloadFileSize = 10000,
        },
      },
    },
  }

  local function lspSymbol(name, icon)
    local hl = "DiagnosticSign" .. name
    vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
  end

  lspSymbol("Error", "󰅙")
  lspSymbol("Info", "󰋼")
  lspSymbol("Hint", "󰌵")
  lspSymbol("Warn", "")

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "single",
  })
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "single",
    focusable = false,
    relative = "cursor",
  })

  -- Borders for LspInfo winodw
  local win = require "lspconfig.ui.windows"
  local _default_opts = win.default_opts

  win.default_opts = function(options)
    local opts = _default_opts(options)
    opts.border = "single"
    return opts
  end
end

return {
  "neovim/nvim-lspconfig",
  lazy = false,
  config = config
}
