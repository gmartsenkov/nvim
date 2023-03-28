-- example file i.e lua/custom/init.lua

vim.api.nvim_exec([[ autocmd FileType go setlocal shiftwidth=8 softtabstop=8 expandtab ]], false)
vim.api.nvim_exec([[ autocmd TermOpen * setlocal nonumber norelativenumber ]], false)
vim.api.nvim_exec([[ let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -l -g ""']], false)
vim.api.nvim_exec([[ set clipboard+=unnamedplus ]], false)
vim.api.nvim_exec([[ set inccommand=nosplit ]], false)
vim.cmd([[ autocmd FileType ruby,elixir,go,rust,clojure autocmd BufWritePre <buffer> %s/\s\+$//e ]])
-- vim.cmd([[autoread | au CursorHold * checktime | call feedkeys("lh")]])
vim.api.nvim_exec([[let g:neovide_cursor_animation_length=0]], false)
vim.api.nvim_exec([[let g:neovide_cursor_trail_length=0]], false)
if vim.g.neovide then
  vim.opt.guifont = { "JetBrainsMono Nerd Font", "h9" }
  vim.g.neovide_cursor_animation_length = 0
  vim.g.neovide_cursor_trail_size = 0
end
vim.wo.relativenumber = true
-- vim.o.updatetime = 250
-- vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
