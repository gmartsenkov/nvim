local autocmd = vim.api.nvim_create_autocmd
vim.api.nvim_exec([[ let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -l -g ""']], false)
-- vim.api.nvim_exec(
--   'autocmd BufEnter *.cljs let g:conjure#client#clojure#nrepl#connection#port_files = [".shadow-cljs/nrepl.port", ".nrepl-port"]',
--   false
-- )
-- vim.api.nvim_exec(
--   'autocmd BufEnter *.clj,*.cljc let g:conjure#client#clojure#nrepl#connection#port_files = [".nrepl-port", ".shadow-cljs/nrepl.port"]',
--   false
-- )

vim.g.snipmate_snippets_path = "/Users/gogo/.config2/nvim/lua_snippets"
vim.o.clipboard = "unnamedplus"
vim.o.inccommand = "nosplit"
vim.o.laststatus = 2
vim.o.pumheight = 10
vim.o.scrolloff = 10
vim.o.updatetime = 250
vim.wo.number = true
vim.opt.signcolumn = "yes"

-- vim.api.nvim_exec([[ let @/ = ""]], false)
if vim.g.neovide then
  vim.g.neovide_cursor_animation_length = 0
  vim.g.neovide_cursor_trail_size = 0
  vim.g.neovide_cursor_antialiasing = true
  vim.g.neovide_scroll_animation_length = 0.3
  vim.g.neovide_refresh_rate = 100
  vim.g.neovide_refresh_rate_idle = 5
  vim.opt.guifont = "JetBrainsMono Nerd Font:h14:#e-subpixelantialias:#h-full"
end

autocmd("BufEnter", {
  pattern = { "*.go" },
  command = "setlocal shiftwidth=8 softtabstop=8 expandtab",
})
autocmd("BufWritePre", {
  pattern = "",
  command = ":%s/\\s\\+$//e",
})
autocmd("BufEnter", {
  pattern = { "*.cljs" },
  command = 'let g:conjure#client#clojure#nrepl#connection#port_files = [".shadow-cljs/nrepl.port", ".nrepl-port"]',
})
autocmd("BufEnter", {
  pattern = { "*.clj", "*.cljc" },
  command = 'let g:conjure#client#clojure#nrepl#connection#port_files = [".nrepl-port", ".shadow-cljs/nrepl.port"]',
})
