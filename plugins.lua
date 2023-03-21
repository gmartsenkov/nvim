return {
  {
    dir = "~/Development/jump-test",
    lazy = false,
    dependencies = { 'jghauser/mkdir.nvim' },
    config = function()
      package.cpath = package.cpath .. ";/Users/gogo/Development/jump-test/lua/goto.so"
      require("goto")
    end
  },
  {
    "TimUntersberger/neogit",
    dependencies = { 'nvim-lua/plenary.nvim' },
    cmd = "Neogit"
  },
  { "RRethy/nvim-treesitter-endwise", lazy = false },
  { "jghauser/mkdir.nvim", lazy = false },
  {
    "ahmedkhalf/project.nvim",
    lazy = false,
    config = function()
      require("project_nvim").setup {}
    end
  },
  {
    'prochri/telescope-all-recent.nvim',
    lazy = false,
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require'telescope-all-recent'.setup{}
    end
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    lazy = false,
    build = 'make'
  },
  { "nvim-telescope/telescope-smart-history.nvim", lazy = false },
  { "nvim-telescope/telescope-file-browser.nvim", lazy = false },
  {
    "hrsh7th/nvim-cmp",
    opts = {
      mapping = {
        ["<C-j>"] = require("cmp").mapping.select_next_item(),
        ["<C-k>"] = require("cmp").mapping.select_prev_item(),
      }
    },
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
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "lua",
        "vim",
        "ruby",
      },
      endwise = {
        enable = true,
      },
      indent = {
        enable = true,
        disable = { 'ruby' }
      }
    }
  },
  {
    "nvim-telescope/telescope-frecency.nvim",
    lazy = false,
    dependencies = {"kkharji/sqlite.lua"}
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("trouble").setup {}
    end
  },
  {
    "kassio/neoterm",
    lazy = false,
    config = function ()
      vim.g["neoterm_default_mod"] = "botright"
      vim.g["neoterm_autoscroll"] = 1
    end
  },
  {
    "vim-test/vim-test",
    lazy = false,
    config = function()
      vim.g["test#strategy"] = "neoterm"
      vim.g["test#preserve_screen"] = 1
      vim.g["ruby#use_binstubs"] = 0
    end
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-smart-history.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
      "ahmedkhalf/project.nvim",
      "nvim-telescope/telescope-frecency.nvim"
    },
    opts = function()
      local c = require "plugins.configs.telescope"
      c.defaults.mappings = {
        i = {
          ["<esc>"] = require("telescope.actions").close,
          ["<C-j>"] = require("telescope.actions").move_selection_next,
          ["<C-k>"] = require("telescope.actions").move_selection_previous,
          ["<C-n>"] = require('telescope.actions').cycle_history_next,
          ["<C-p>"] = require('telescope.actions').cycle_history_prev,
        },
      }
      c.defaults.file_ignore_patterns = { "node_modules", "resources/public/js/", ".git/", ".shadow-cljs/" }
      c.extensions = {
        fzf = {
          fuzzy = false,                    -- false will only do exact matching
          override_generic_sorter = true,  -- override the generic sorter
          override_file_sorter = true,     -- override the file sorter
          case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
          -- the default case_mode is "smart_case"
        }
      }
      c.extensions_list = { "themes", "terms", "projects", "file_browser", "smart_history", "frecency" }
      return c
    end
  }
}
