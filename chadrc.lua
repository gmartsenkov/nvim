-- Just an example, supposed to be placed in /lua/custom/

local M = {}

-- make sure you maintain the structure of `core/default_config.lua` here,
-- example of changing theme:

local userPlugins = require "custom.plugins"

M.plugins = {
  user = userPlugins,
  override = {
    ["nvim-telescope/telescope.nvim"] = {
      defaults = {
        mappings = {
          i = {
            ["<esc>"] = require("telescope.actions").close,
            ["<C-j>"] = require("telescope.actions").move_selection_next,
            ["<C-k>"] = require("telescope.actions").move_selection_previous
          },
        },
      },
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
        { name = "nvim_lsp", max_item_count = 8 },
        { name = "path" },
      },
      mapping = {
        ["<C-j>"] = require("cmp").mapping.select_next_item(),
        ["<C-k>"] = require("cmp").mapping.select_prev_item()
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
  },
  remove = {},
  options = {
    lspconfig = {
      setup_lspconf = "custom.plugins.lspconfig",
    },
  },
}

M.ui = {
   theme = "everforest",
}

M.mappings = require "custom.mappings"

return M
