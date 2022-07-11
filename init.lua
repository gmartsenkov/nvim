-- example file i.e lua/custom/init.lua

vim.api.nvim_exec([[ autocmd FileType go setlocal shiftwidth=8 softtabstop=8 expandtab ]], false)
vim.api.nvim_exec([[ autocmd TermOpen * setlocal nonumber norelativenumber ]], false)
vim.api.nvim_exec([[ let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -l -g ""']], false)
vim.api.nvim_exec([[ set clipboard+=unnamedplus ]], false)
vim.api.nvim_exec([[ set inccommand=nosplit ]], false)
vim.cmd([[ autocmd FileType ruby,elixir,go,rust,clojure autocmd BufWritePre <buffer> %s/\s\+$//e ]])
