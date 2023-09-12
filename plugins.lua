return {
  {
    "NvChad/nvim-colorizer.lua",
    lazy = false,
    opts = {
      user_default_options = {
        tailwind = true
      }
    }
  },
  {
    "elixir-tools/elixir-tools.nvim",
    version = "*",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local elixir = require("elixir")
      local elixirls = require("elixir.elixirls")

      elixir.setup {
        nextls = {enable = false },
        credo = {enable = false },
        elixirls = {
          enable = false,
          settings = elixirls.settings {
            dialyzerEnabled = false,
            enableTestLenses = false,
          },
          on_attach = function(client, bufnr)
            vim.keymap.set("n", "<space>fp", ":ElixirFromPipe<cr>", { buffer = true, noremap = true })
            vim.keymap.set("n", "<space>tp", ":ElixirToPipe<cr>", { buffer = true, noremap = true })
            vim.keymap.set("v", "<space>em", ":ElixirExpandMacro<cr>", { buffer = true, noremap = true })
          end,
        }
      }
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "nvim-pack/nvim-spectre",
    dependencies = { "nvim-pack/nvim-spectre" },
    config = true,
    cmd = "Spectre",
  },
  { "tpope/vim-surround", lazy = false },
  { "tpope/vim-repeat", lazy = false },
  {
    "tpope/vim-sexp-mappings-for-regular-people",
    ft = { "fennel", "clojure" },
    dependencies = {
      {
        "guns/vim-sexp",
        ft = { "fennel", "clojure" },
        config = function()
          vim.g.sexp_enable_insert_mode_mappings = 0
          vim.g.sexp_filetypes = "clojure,fennel"
        end,
      },
    },
  },
  { "Olical/conjure", ft = { "fennel", "clojure" } },
  { "jaawerth/fennel.vim", ft = { "fennel" } },
  { "rktjmp/hotpot.nvim", lazy = false, config = true },
  { "tpope/vim-fugitive", cmd = { "Git", "Gedit", "GBrowse" } },
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
  { "AndrewRadev/splitjoin.vim", lazy = false },
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
    config = true,
  },
  {
    "gmartsenkov/gotospec.nvim",
    lazy = false,
    build = "make",
    dependencies = { "jghauser/mkdir.nvim" },
    config = true,
  },
  {
    "NeogitOrg/neogit",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Neogit",
    config = true,
  },
  {
    "hrsh7th/nvim-cmp",
    opts = require "custom.configs.nvim-cmp",
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    lazy = false,
    config = function()
      require "custom.configs.null-ls"
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      { "RRethy/nvim-treesitter-endwise", lazy = false },
    },
    opts = {
      ensure_installed = {
        "eex",
        "surface",
        "heex",
        "html",
        "erlang",
        "lua",
        "vim",
        "ruby",
        "rust",
        "elixir",
        "c",
        "javascript",
        "markdown",
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
    lazy = false,
    opts = {},
  },
  {
    "vim-test/vim-test",
    cmd = { "TestFile", "TestSuite", "TestNearest", "TestLast", "TestVisit" },
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
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-telescope/telescope-project.nvim",
      "nvim-telescope/telescope-smart-history.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
    },
    cmd = "Telescope",
    opts = require "custom.configs.telescope",
  },
}
