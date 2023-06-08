return {
  {
    "guns/vim-sexp",
    lazy = false,
    ft = { "fennel", "clojure" },
    config = function()
      vim.g.sexp_enable_insert_mode_mappings = 0
      vim.g.sexp_filetypes = "clojure,fennel"
    end,
  },
  { "tpope/vim-surround", lazy = false },
  { "tpope/vim-repeat", lazy = false },
  {
    "tpope/vim-sexp-mappings-for-regular-people",
    ft = { "fennel", "clojure" },
    dependencies = { "guns/vim-sexp", "tpope/vim-repeat", "tpope/vim-surround" },
  },
  { "Olical/conjure", ft = { "fennel", "clojure" } },
  { "jaawerth/fennel.vim", lazy = false },
  { "rktjmp/hotpot.nvim", lazy = false, config = true },
  { "tpope/vim-fugitive", lazy = false },
  {
    "williamboman/mason-lspconfig",
    dependencies = { "williamboman/mason.nvim" },
    lazy = false,
    opts = {
      ensure_installed = {
        "clangd",
        "clojure_lsp",
        "lua_ls",
        "rust_analyzer",
        "solargraph",
        "fennel_language_server",
      },
    },
  },
  {
    "saecki/crates.nvim",
    tag = "v0.3.0",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = { "BufRead Cargo.toml" },
    config = true,
  },
  {
    "gmartsenkov/root.nvim",
    lazy = false,
    config = true,
    build = "make",
  },
  {
    "echasnovski/mini.nvim",
    version = "*",
    lazy = false,
    config = function()
      -- require("mini.surround").setup()
      require("mini.splitjoin").setup()
    end,
  },
  {
    "ruifm/gitlinker.nvim",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true,
  },
  { "kkharji/sqlite.lua", lazy = false },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    lazy = false,
    opts = {
      close_on_exit = true,
      direction = "horizontal",
      shade_terminals = false,
      open_mapping = [[<C-t>]],
      size = function(term)
        if term.direction == "horizontal" then
          return vim.o.lines * 0.4
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
    },
  },
  { "famiu/bufdelete.nvim", cmd = "Bdelete" },
  {
    "phaazon/hop.nvim",
    cmd = { "HopWord", "HopChar1", "HopChar2", "HopLine", "HopAnywhere" },
    config = function()
      require("hop").setup {}
    end,
  },
  {
    "gmartsenkov/gotospec.nvim",
    lazy = false,
    build = "make",
    dependencies = { "jghauser/mkdir.nvim", "gmartsenkov/root.nvim" },
    config = true,
  },
  {
    "TimUntersberger/neogit",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Neogit",
  },
  { "RRethy/nvim-treesitter-endwise", ft = { "ruby", "elixir", "lua", "bash" } },
  { "nvim-telescope/telescope-project.nvim", lazy = false },
  { "nvim-telescope/telescope-fzf-native.nvim", lazy = false, build = "make" },
  { "nvim-telescope/telescope-smart-history.nvim", lazy = false },
  { "nvim-telescope/telescope-file-browser.nvim", lazy = false },
  {
    "hrsh7th/nvim-cmp",
    opts = {
      mapping = {
        ["<Down>"] = require("cmp").mapping.select_next_item(),
        ["<C-j>"] = require("cmp").mapping.select_next_item(),
        ["<C-k>"] = require("cmp").mapping.select_prev_item(),
        ["<Up>"] = require("cmp").mapping.select_prev_item(),
        ["<S-CR>"] = require("cmp").mapping.abort(),
      },
      sources = {
        { name = "luasnip", max_item_count = 5 },
        { name = "nvim_lsp", max_item_count = 5 },
        { name = "crates", max_items_count = 10 },
        { name = "nvim_lua", max_item_count = 5 },
        { name = "path", max_item_count = 5 },
        { name = "buffer", max_item_count = 5 },
      },
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
        "rust",
        "elixir",
      },
      endwise = {
        enable = true,
      },
      indent = {
        enable = true,
        disable = { "ruby" },
      },
    },
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "TroubleToggle",
    config = function()
      require("trouble").setup {}
    end,
  },
  {
    "vim-test/vim-test",
    lazy = false,
    dependencies = { "gmartsenkov/gotospec.nvim" },
    config = function()
      vim.g["test#custom_strategies"] = {
        term = function(cmd)
          local terminals = require("toggleterm.terminal").get_all()
          for _, term in ipairs(terminals) do
            vim.cmd(term.bufnr .. "bdelete!")
          end
          vim.cmd("TermExec cmd='" .. cmd .. "'")
        end,
      }
      vim.g["test#strategy"] = "term"
      vim.g["test#preserve_screen"] = 1
      vim.g["ruby#use_binstubs"] = 0
      vim.g["test#custom_alternate_file"] = function()
        return require("gotospec").jump_suggestion(require("root").find())
      end
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-smart-history.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
      "nvim-telescope/telescope-project.nvim",
    },
    lazy = false,
    opts = function()
      local c = require "plugins.configs.telescope"
      local actions = require "telescope.actions"
      local project_actions = require "telescope._extensions.project.actions"
      local fb_actions = require "telescope._extensions.file_browser.actions"

      c.defaults.mappings = {
        i = {
          ["<esc>"] = require("telescope.actions").close,
          ["<C-j>"] = require("telescope.actions").move_selection_next,
          ["<C-k>"] = require("telescope.actions").move_selection_previous,
          ["<C-n>"] = require("telescope.actions").cycle_history_next,
          ["<C-p>"] = require("telescope.actions").cycle_history_prev,
          ["<C-a>"] = { "<home>", type = "command" },
          ["<C-e>"] = { "<end>", type = "command" },
        },
      }
      c.defaults.file_ignore_patterns = { "node_modules", "resources/public/js/", ".git/", ".shadow-cljs/" }
      c.extensions = {
        file_browser = {
          mappings = {
            i = {
              ["<Tab>"] = actions.select_default,
              ["<C-CR>"] = fb_actions.create_from_prompt,
            },
          },
        },
        project = {
          base_dirs = { "~/Development/", "~/.config/nvim/lua/" },
          on_project_selected = function(prompt_bufnr)
            -- Do anything you want in here. For example:
            project_actions.change_working_directory(prompt_bufnr, false)
            -- project_actions.find_project_files(prompt_bufnr, false)
          end,
        },
        fzf = {
          fuzzy = false, -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = "smart_case", -- or "ignore_case" or "respect_case"
          -- the default case_mode is "smart_case"
        },
        advanced_git_search = {
          -- fugitive or diffview
          diff_plugin = "fugitive",
          -- customize git in previewer
          -- e.g. flags such as { "--no-pager" }, or { "-c", "delta.side-by-side=false" }
          git_flags = {},
          -- customize git diff in previewer
          -- e.g. flags such as { "--raw" }
          git_diff_flags = {},
        },
      }
      c.extensions_list = { "themes", "terms", "file_browser", "smart_history", "fzf", "project" }
      return c
    end,
  },
}
