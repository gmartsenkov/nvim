return {
  {"kkharji/sqlite.lua", lazy = false},
  {'akinsho/toggleterm.nvim',
    version = "*",
    lazy=false,
    opts = {
      close_on_exit = true,
      direction = 'horizontal',
      open_mapping = [[<C-t>]],
      size = function(term)
        if term.direction == "horizontal" then
          return 20
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
    }
  },
  {
    "famiu/bufdelete.nvim",
    cmd = "Bdelete"
  },
  {
    "ggandor/leap.nvim",
    lazy = false,
    config = function ()
      require('leap').add_default_mappings()
      vim.api.nvim_set_hl(0, 'LeapBackdrop', { fg = 'grey' })
      vim.api.nvim_set_hl(0, 'LeapLabelPrimary', { fg = 'red' })
    end
  },
  {
    "gmartsenkov/gotospec",
    lazy = false,
    build = "make",
    dependencies = { 'jghauser/mkdir.nvim' },
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
    dependencies = {"RRethy/nvim-treesitter-textsubjects"},
    opts = {
      ensure_installed = {
        "lua",
        "vim",
        "ruby",
        "rust",
        "elixir"
      },
      endwise = {
        enable = true,
      },
      indent = {
        enable = true,
        disable = { 'ruby' }
      },
      textsubjects = {
        enable = true,
        prev_selection = ',', -- (Optional) keymap to select the previous selection
        keymaps = {
          ['.'] = 'textsubjects-smart',
          [';'] = 'textsubjects-container-outer',
          ['i;'] = 'textsubjects-container-inner',
        },
      },
    }
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "TroubleToggle",
    config = function()
      require("trouble").setup {}
    end
  },
  {
    "vim-test/vim-test",
    lazy = false,
    dependencies = { "gmartsenkov/gotospec" },
    config = function()
      vim.g["test#custom_strategies"] = {
        term = function (cmd)
          local terminals = require("toggleterm.terminal").get_all()
          for _, term in ipairs(terminals) do
            vim.cmd(term.bufnr .. "bdelete!")
          end
          vim.cmd("TermExec cmd='" .. cmd .. "'")
        end
      }
      vim.g["test#strategy"] = "term"
      vim.g["test#preserve_screen"] = 1
      vim.g["ruby#use_binstubs"] = 0
      vim.g["test#custom_alternate_file"] = function ()
        return require("gotospec").jump_suggestion()
      end
    end
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-smart-history.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
      "ahmedkhalf/project.nvim",
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
      c.extensions_list = { "themes", "terms", "projects", "file_browser", "smart_history" }
      return c
    end
  }
}
