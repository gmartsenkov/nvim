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
   ["vim-test/vim-test"] = {
     config = function()
       vim.g['test#strategy'] = 'neovim'
     end
   },
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
   ["rgroli/other.nvim"] = {
     config = function()
       require("other-nvim").setup({
           mappings = {
             {
               pattern = "/lib/(.*)/(.*).ex",
               target = "/test/%1/%2_test.exs",
             },
             {
               pattern = "/test/(.*)/(.*)_test.exs",
               target = "/lib/%1/%2.ex",
             },
             {
               pattern = "/lib/(.*)/(.*).rb",
               target = "/spec/%1/%2_spec.rb",
             },
             {
               pattern = "/spec/(.*)/(.*)_spec.rb",
               target = "/lib/%1/%2.rb",
             },
             {
               pattern = "/lib/(.*)/(.*).rb",
               target = "/spec/lib/%1/%2_spec.rb",
             },
             {
               pattern = "/spec/lib/(.*)/(.*)_spec.rb",
               target = "/lib/%1/%2.rb",
             },
           }})
     end
   }
}
