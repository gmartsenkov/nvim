return {
    ["TimUntersberger/neogit"] = {
      config = function()
         require("neogit").setup {}
      end,
   },
    ["neovim/nvim-lspconfig"] = {
      config = function()
        require'lspconfig'.gopls.setup{}
        require'lspconfig'.solargraph.setup{}

        on_attach = function(client, _)
          client.server_capabilities.document_formatting = false
          client.server_capabilities.document_range_formatting = false

          require("core.mappings").lspconfig()
        end
      end,
   },
   ["ahmedkhalf/project.nvim"] = {
     config = function()
       require("project_nvim").setup {}
       require('telescope').load_extension('projects')
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
     setup = function()
       -- load default mappings first
       require("core.mappings").telescope()

       -- then load your mappings
       local map = nvchad.map
       map("n", "<leader>ts", "<cmd> :Telescope themes <CR>")
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
   ["akinsho/bufferline.nvim"] = {
     disable = true,
   },
   ["jose-elias-alvarez/null-ls.nvim"] = {
     after = "nvim-lspconfig",
     config = function()
       require("null-ls").setup({
         sources = {
           require("null-ls").builtins.formatting.stylua,
           require("null-ls").builtins.diagnostics.eslint,
           require("null-ls").builtins.completion.spell,
         },
         on_attach = function(client)
           if client.server_capabilities.document_formatting then
             vim.cmd "autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()"
           end
         end,
       })
     end,
   },
 }
