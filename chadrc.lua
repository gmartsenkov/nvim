-- Just an example, supposed to be placed in /lua/custom/

local M = {}

-- make sure you maintain the structure of `core/default_config.lua` here,
-- example of changing theme:

local userPlugins = require "custom.plugins"

M.plugins = {
  user = userPlugins,
  override = {
    ["nvim-telescope/telescope.nvim"] = {
      extensions = {
        fzf = {
          fuzzy = false,                    -- false will only do exact matching
          override_generic_sorter = true,  -- override the generic sorter
          override_file_sorter = true,     -- override the file sorter
          case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
          -- the default case_mode is "smart_case"
        }
      }
    },
    ["hrsh7th/nvim-cmp"] = {
      sources = {
        { name = "nvim_lsp" },
        { name = "path" },
      }
    },
    ["nvim-treesitter/nvim-treesitter"] = {
      ensure_installed = {
        "lua",
        "vim",
        "ruby"
      },
      endwise = {
        enable = true,
      },
    }
  }
}

M.ui = {
   theme = "gruvchad",
}

return M
