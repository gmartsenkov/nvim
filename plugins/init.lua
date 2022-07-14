return {
  ["RRethy/nvim-treesitter-endwise"] = {
    before = 'nvim-treesitter'
  },
  ["TimUntersberger/neogit"] = {
    config = function()
      require("neogit").setup {}
    end,
  },
  ["ahmedkhalf/project.nvim"] = {
    config = function()
      require("project_nvim").setup {}
    end
  },
  ["guns/vim-sexp"] = {},
  ["tpope/vim-sexp-mappings-for-regular-people"] = {},
  ["tpope/vim-commentary"] = {},
  ["tpope/vim-surround"] = {},
  ["gmartsenkov/vim-test"] = {
    config = function()
      vim.g["test#custom_alternate_file"] = function()
        local other = require("other-nvim")
        local other_file = other.findOther("test")[1]

        if other_file then
          return other_file.filename
        else
          return ""
        end
      end

      vim.g["test#strategy"] = "neovim"
      vim.g["test#preserve_screen"] = 1
      vim.g["ruby#use_binstubs"] = 0
    end
  },
  ["Olical/conjure"] = {},
  ["nvim-telescope/telescope-file-browser.nvim"] = {},
  ["nvim-telescope/telescope-fzf-native.nvim"] = {
    run = 'make'
  },
  ["gmartsenkov/friendly-snippets"] = {
    module = "cmp_nvim_lsp",
    event = "InsertEnter"
  },
  ["vinibispo/ruby.nvim"] = {
    config = function()
      require("ruby_nvim").setup({
        test_cmd = "bundle exec rspec"
      })
    end
  },
  ["ray-x/go.nvim"] = {
    after = "nvim-lspconfig",
    config = function()
      require('go').setup()
    end
  },
  ["mhanberg/elixir.nvim"] = {
    after = "nvim-lspconfig",
    config = function()
      require("elixir").setup()
    end
  },
  ["goolord/alpha-nvim"] = {
    disable = false,
  },
  ["jose-elias-alvarez/null-ls.nvim"] = {
    after = "nvim-lspconfig",
    config = function()
      require("custom.plugins.null-ls").setup()
    end,
  },
  ["nvim-telescope/telescope.nvim"] = {
    config = function()
      require("custom.plugins.telescope").setup()
    end,
  },
  ["hrsh7th/nvim-cmp"] = {
    config = function()
      require("custom.plugins.cmp").setup()
    end,
  },
  ["elixir-editors/vim-elixir"] = {},
  ["jghauser/mkdir.nvim"] = {},
  ["yalesov/vim-emblem"] = {},
  ["akinsho/toggleterm.nvim"] = {
    tag = 'v1.*', config = function()
      require("toggleterm").setup({
        size = 30,
        open_mapping = [[<c-t>]],
        start_in_insert = true,
        insert_mappings = true,
        terminal_mappings = true,
        shade_terminals = false
      })
    end
  },
  ["gmartsenkov/other.nvim"] = {
    config = function()
      require("custom.plugins.other").setup()
    end
  }
}
