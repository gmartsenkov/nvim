return {
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
}
