require("core")
require("lazy_init")

-- vim.opt.background = "dark"
vim.cmd.colorscheme("catppuccin")

vim.api.nvim_set_hl(0, "TermCursorNC", {})

local opt = vim.opt
local o = vim.o
o.expandtab = true
o.shiftwidth = 2
o.smartindent = true
o.tabstop = 2
o.softtabstop = 2

opt.whichwrap:append("<>[]hl")
opt.fillchars = { eob = " " }
o.ignorecase = true
o.smartcase = true
o.mouse = "a"
vim.cmd("set nomodeline")
vim.cmd("set nosmd")
local is_windows = vim.fn.has("win32") ~= 0
vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin" .. (is_windows and ";" or ":") .. vim.env.PATH
