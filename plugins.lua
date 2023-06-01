return {
  { "tpope/vim-fugitive", lazy = false },
  {
    "williamboman/mason-lspconfig",
    lazy = false,
    opts = {
      ensure_installed = {
        "clangd",
        "clojure_lsp",
        "lua_ls",
        "rust_analyzer",
        "solargraph",
      },
    },
  },
  {
    "saecki/crates.nvim",
    tag = "v0.3.0",
    requires = { "nvim-lua/plenary.nvim" },
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
      require("mini.surround").setup()
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
  { "RRethy/nvim-treesitter-endwise", lazy = false },
  {
    "ahmedkhalf/project.nvim",
    lazy = false,
    config = function()
      require("project_nvim").setup {
        scope_chdir = "tab",
      }
    end,
  },
  { "nvim-telescope/telescope-fzf-native.nvim", lazy = false, build = "make" },
  { "nvim-telescope/telescope-smart-history.nvim", lazy = false },
  { "nvim-telescope/telescope-file-browser.nvim", lazy = false },
  {
    "hrsh7th/nvim-cmp",
    opts = {
      formatting = {
        fields = { "abbr", "menu", "kind" },
        format = function(entry, item)
          -- Define menu shorthand for different completion sources.
          local menu_icon = {
            nvim_lsp = "NLSP",
            nvim_lua = "NLUA",
            luasnip = "LSNP",
            buffer = "BUFF",
            path = "PATH",
          }
          -- Set the menu "icon" to the shorthand for each completion source.
          item.menu = menu_icon[entry.source.name]

          -- Set the fixed width of the completion menu to 60 characters.
          -- fixed_width = 20

          -- Set 'fixed_width' to false if not provided.
          fixed_width = fixed_width or false

          -- Get the completion entry text shown in the completion window.
          local content = item.abbr

          -- Set the fixed completion window width.
          if fixed_width then
            vim.o.pumwidth = fixed_width
          end

          -- Get the width of the current window.
          local win_width = vim.api.nvim_win_get_width(0)

          -- Set the max content width based on either: 'fixed_width'
          -- or a percentage of the window width, in this case 20%.
          -- We subtract 10 from 'fixed_width' to leave room for 'kind' fields.
          local max_content_width = fixed_width and fixed_width - 10 or math.floor(win_width * 0.2)

          -- Truncate the completion entry text if it's longer than the
          -- max content width. We subtract 3 from the max content width
          -- to account for the "..." that will be appended to it.
          if #content > max_content_width then
            item.abbr = vim.fn.strcharpart(content, 0, max_content_width - 3) .. "..."
          else
            item.abbr = content .. (" "):rep(max_content_width - #content)
          end
          return item
        end,
      },
      mapping = {
        ["<C-j>"] = require("cmp").mapping.select_next_item(),
        ["<C-k>"] = require("cmp").mapping.select_prev_item(),
      },
      sources = {
        { name = "luasnip", max_item_count = 5 },
        { name = "nvim_lsp", max_item_count = 5 },
        { name = "crates", max_items_count = 10 },
        { name = "buffer", max_item_count = 5 },
        { name = "nvim_lua", max_item_count = 5 },
        { name = "path", max_item_count = 5 },
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
      "ahmedkhalf/project.nvim",
    },
    opts = function()
      local c = require "plugins.configs.telescope"
      c.defaults.mappings = {
        i = {
          ["<esc>"] = require("telescope.actions").close,
          ["<C-j>"] = require("telescope.actions").move_selection_next,
          ["<C-k>"] = require("telescope.actions").move_selection_previous,
          ["<C-n>"] = require("telescope.actions").cycle_history_next,
          ["<C-p>"] = require("telescope.actions").cycle_history_prev,
        },
      }
      c.defaults.file_ignore_patterns = { "node_modules", "resources/public/js/", ".git/", ".shadow-cljs/" }
      c.extensions = {
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
      c.extensions_list = { "themes", "terms", "projects", "file_browser", "smart_history", "fzf" }
      return c
    end,
  },
}
