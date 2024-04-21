return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
    {
      "gmartsenkov/root.nvim",
      lazy = false,
      config = true,
      opts = { patterns = { ".git", "Gemfile", "Cargo.toml" } },
      build = "make",
    },
    {
      "gmartsenkov/gotospec.nvim",
      lazy = false,
      build = "make",
      dependencies = { "jghauser/mkdir.nvim" },
      config = true,
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
    {
      "neovim/nvim-lspconfig",
      config = function()
        require("nvchad.configs.lspconfig").defaults()
        require "configs.lspconfig"
      end,
    },
  },
  { "RRethy/nvim-treesitter-endwise", lazy = false },
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      { "RRethy/nvim-treesitter-endwise", lazy = false },
    },
    opts = {
      ensure_installed = {
        "ruby", "elixir", "rust", "heex", "lua",
        "vim",
        "html", "css"
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
    "hrsh7th/nvim-cmp",
    dependencies = {
      "onsails/lspkind.nvim",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    opts = function()
      local conf = require "nvchad.configs.cmp"

      conf.formatting.format = require("lspkind").cmp_format {
        mode = 'text',
        with_text = true,
        maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
        ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

        menu = {
          codeium = '[AI]',
          buffer = '[BUF]',
          nvim_lsp = '[LSP]',
          nvim_lsp_signature_help = '[LSP]',
          nvim_lsp_document_symbol = '[LSP]',
          nvim_lua = '[API]',
          path = '[PATH]',
          luasnip = '[SNIP]',
        },
      }
      conf.mapping = {
        ["<Down>"] = require("cmp").mapping.select_next_item(),
        ["<C-j>"] = require("cmp").mapping.select_next_item(),
        ["<C-k>"] = require("cmp").mapping.select_prev_item(),
        ["<Up>"] = require("cmp").mapping.select_prev_item(),
        ["<S-CR>"] = require("cmp").mapping.abort(),
        ["<CR>"] = require("cmp").mapping.confirm {
          behavior = require("cmp").ConfirmBehavior.Insert,
          select = true,
        },
        ["<Tab>"] = require("cmp").mapping(function(callback)
          if require("luasnip").expand_or_jumpable() then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
          else
            callback()
          end
        end),
        ["<S-Tab>"] = require("cmp").mapping(function(callback)
          if require("luasnip").expand_or_jumpable() then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
          else
            callback()
          end
        end),
      }

      -- conf.formatting = {
      --   format = function(entry, vim_item)
      --     vim_item.abbr = string.sub(vim_item.abbr, 1, 20)
      --     vim_item.kind = string.sub(vim_item.kind, 1, 20)
      --     return vim_item
      --   end
      -- }

      return conf
    end
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
  { "famiu/bufdelete.nvim", cmd = "Bdelete" },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-telescope/telescope-project.nvim",
      "nvim-telescope/telescope-smart-history.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-frecency.nvim",
    },
    opts = function()
      local conf = require "nvchad.configs.telescope"
      local actions = require "telescope.actions"
      local project_actions = require "telescope._extensions.project.actions"
      local fb_actions = require "telescope._extensions.file_browser.actions"

      conf.defaults.mappings.i = {
        ["<esc>"] = require("telescope.actions").close,
        ["<C-j>"] = require("telescope.actions").move_selection_next,
        ["<C-k>"] = require("telescope.actions").move_selection_previous,
        ["<C-n>"] = require("telescope.actions").cycle_history_next,
        ["<C-p>"] = require("telescope.actions").cycle_history_prev,
        ["<C-a>"] = { "<home>", type = "command" },
        ["<C-e>"] = { "<end>", type = "command" },
      }
      conf.defaults.file_ignore_patterns = { "node_modules", "resources/public/js/", ".git/", ".shadow-cljs/", "assets/vendor" }
      conf.extensions = {
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
        }
      }
      conf.extensions_list = { "themes", "terms", "file_browser", "smart_history", "fzf", "project", "frecency" }

      -- or
      -- table.insert(conf.defaults.mappings.i, your table)

      return conf
    end,
  }
}
