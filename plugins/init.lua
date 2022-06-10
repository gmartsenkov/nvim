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
       require('telescope').load_extension('projects')
     end
   },
   ["vim-test/vim-test"] = {
     config = function()
       vim.g['test#strategy'] = 'neovim'
       vim.g['test#neovim#start_normal'] = 1
     end
   },
   ["nvim-telescope/telescope-fzy-native.nvim"] = {
     run = 'make'
   },
   ["nvim-telescope/telescope.nvim"] = {
     config = function()
       require "plugins.configs.telescope"
       require('telescope').load_extension('fzy_native')
       require('telescope').load_extension('projects')
     end,
   },
   ["vinibispo/ruby.nvim"] = {
     config = function()
       require("ruby_nvim").setup({
         test_cmd = "bundle exec rspec"
       })
     end
   },
   ["ray-x/go.nvim"] = {
     config = function()
       require('go').setup()
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
   ["mhanberg/elixir.nvim"] = {
     config = function()
       require("elixir").setup()
     end
   },
   ["elixir-editors/vim-elixir"] = {},
   ["jghauser/mkdir.nvim"] = {}
}
