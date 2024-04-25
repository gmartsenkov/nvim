require("defaults")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

require("lazy").setup({
  {
    "lukas-reineke/indent-blankline.nvim",
    version = "2.20.7",
    lazy = false,
    opts = function()
      return {
        scope = { enabled = true},
        indentLine_enabled = 1,
        filetype_exclude = {
          "help",
          "terminal",
          "lazy",
          "lspinfo",
          "TelescopePrompt",
          "TelescopeResults",
          "mason",
          "nvdash",
          "nvcheatsheet",
          "",
        },
        buftype_exclude = { "terminal" },
        show_trailing_blankline_indent = false,
        show_first_indent_level = false,
        show_current_context = true,
        show_current_context_start = true,
      }
    end,
    config = function(_, opts)
      require("indent_blankline").setup(opts)
      vim.api.nvim_set_hl(0, "IndentBlanklineChar", { fg="#333333" })
      vim.api.nvim_set_hl(0, "IndentBlanklineSpaceChar", { fg="#333333" })
      vim.api.nvim_set_hl(0, "IndentBlanklineContextChar", { fg="#404040" })
      vim.api.nvim_set_hl(0, "IndentBlanklineContextStart", { bg="#404040" })
    end
  },
  {"nanozuki/tabby.nvim", lazy=false},
  -- {
  --   'nvim-lualine/lualine.nvim',
  --   dependencies = { 'nvim-tree/nvim-web-devicons' },
  --   lazy = false,
  --   config = true
  -- },
  {
    "elixir-tools/elixir-tools.nvim",
    version = "*",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("elixir").setup {
        nextls = { enable = false },
        credo = { enable = false },
        elixirls = { enable = true }
      }
    end,
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  { "tpope/vim-surround", lazy = false },
  { "tpope/vim-repeat", lazy = false },
  {
    "saecki/crates.nvim",
    tag = "v0.3.0",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = { "BufRead Cargo.toml" },
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
    opts = {
      kind = "tab",
      remember_settings = false,
    }
  },
  {
    "vim-test/vim-test",
    cmd = { "TestFile", "TestSuite", "TestNearest", "TestLast", "TestVisit" },
    dependencies = { "gmartsenkov/gotospec.nvim" },
    config = function()
      vim.g["test#project_root"] = function ()
        return require("root").find()
      end
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
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-frecency.nvim"
    },
    cmd = "Telescope",
    opts = require "plugins.telescope",
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    opts = {},
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      {"onsails/lspkind.nvim", lazy = false},
      {
        -- snippet plugin
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
        config = function()
          require("luasnip.loaders.from_snipmate").lazy_load { paths = vim.fn.stdpath("config") .. "/snippets" }
        end
      },
      {
        "windwp/nvim-autopairs",
        opts = {
          fast_wrap = {},
          disable_filetype = { "TelescopePrompt", "vim" },
        },
        config = function(_, opts)
          require("nvim-autopairs").setup(opts)

          -- setup cmp for autopairs
          local cmp_autopairs = require "nvim-autopairs.completion.cmp"
          require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
      },
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    opts = require "plugins.nvim-cmp",
    config = function(_, opts)
      require("cmp").setup(opts)
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    ft = { "gitcommit", "diff" },
    init = function()
      -- load gitsigns only when a git file is opened
      vim.api.nvim_create_autocmd({ "BufRead" }, {
        group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
        callback = function()
          vim.fn.system("git -C " .. '"' .. vim.fn.expand "%:p:h" .. '"' .. " rev-parse")
          if vim.v.shell_error == 0 then
            vim.api.nvim_del_augroup_by_name "GitSignsLazyLoad"
            vim.schedule(function()
              require("lazy").load { plugins = { "gitsigns.nvim" } }
            end)
          end
        end,
      })
    end,
    opts =  {
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "󰍵" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "│" },
      }
    },
    config = true
  },
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
    opts = {
      ensure_installed = { "lua-language-server", "nextls" },

      PATH = "skip",

      ui = {
        icons = {
          package_pending = " ",
          package_installed = "󰄳 ",
          package_uninstalled = " 󰚌",
        },

        keymaps = {
          toggle_server_expand = "<CR>",
          install_server = "i",
          update_server = "u",
          check_server_version = "c",
          update_all_servers = "U",
          check_outdated_servers = "C",
          uninstall_server = "X",
          cancel_installation = "<C-c>",
        },
      },

      max_concurrent_installers = 10
    },
    config = function(_, opts)
      require("mason").setup(opts)

      -- custom nvchad cmd to install all mason binaries listed
      vim.api.nvim_create_user_command("MasonInstallAll", function()
        vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
      end, {})

      vim.g.mason_binaries_list = opts.ensure_installed
    end,
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      require "plugins.lspconfig"
    end,
  },
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
    "gmartsenkov/root.nvim",
    lazy = false,
    config = true,
    opts = { patterns = { ".git", "Gemfile", "Cargo.toml" } },
    build = "make",
  },
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
  {
    "gmartsenkov/root.nvim",
    lazy = false,
    config = true,
    build = "make",
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = true
  },
  -- {
  --   "nyoom-engineering/oxocarbon.nvim",
  --   priority = 100,
  --   lazy = false
  -- },
  {
    "nvim-treesitter/nvim-treesitter",
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    dependencies = { { "RRethy/nvim-treesitter-endwise", lazy = false } },
    config = true,
    opts = {
      highlight = {
        enable = true,
        use_languagetree = true,
      },
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
}, {
    root = "/Users/gogo/.config2/lazy",
    defaults = { lazy = true },
    install = { colorscheme = { "oxocarbon" } },

    ui = {
      icons = {
        ft = "",
        lazy = "󰂠 ",
        loaded = "",
        not_loaded = "",
      },
    },

    performance = {
      rtp = {
        disabled_plugins = {
          "2html_plugin",
          "tohtml",
          "getscript",
          "getscriptPlugin",
          "gzip",
          "logipat",
          "netrw",
          "netrwPlugin",
          "netrwSettings",
          "netrwFileHandlers",
          "matchit",
          "tar",
          "tarPlugin",
          "rrhelper",
          "spellfile_plugin",
          "vimball",
          "vimballPlugin",
          "zip",
          "zipPlugin",
          "tutor",
          "rplugin",
          "syntax",
          "synmenu",
          "optwin",
          "compiler",
          "bugreport",
          "ftplugin",
        },
      },
    },
  })

-- vim.opt.background = "dark"
vim.cmd.colorscheme "catppuccin"

vim.api.nvim_set_hl(0, "TermCursorNC", {})

local opt = vim.opt
local o = vim.o
local g = vim.g
o.expandtab = true
o.shiftwidth = 2
o.smartindent = true
o.tabstop = 2
o.softtabstop = 2

opt.whichwrap:append "<>[]hl"
opt.fillchars = { eob = " " }
o.ignorecase = true
o.smartcase = true
o.mouse = "a"

require("mappings")
