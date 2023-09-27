local opts = { noremap = true, silent = true }
local map = vim.keymap.set

map(
  "n",
  "<leader><leader>",
  function()
    local cwd = require("root").find() or vim.fn.expand "%:p:h"
    vim.cmd("Telescope find_files theme=ivy previewer=false hidden=true cwd=" .. cwd)
  end,
  opts
)
