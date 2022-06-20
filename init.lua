-- example file i.e lua/custom/init.lua

vim.api.nvim_exec([[ autocmd FileType go setlocal shiftwidth=8 softtabstop=8 expandtab ]], false)
vim.api.nvim_exec([[ autocmd TermOpen * setlocal nonumber norelativenumber ]], false)
