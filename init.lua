-- example file i.e lua/custom/init.lua

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

vim.g.neovide_cursor_animation_length = 0
vim.g.neovide_cursor_trail_length = 0
vim.g.snipmate_snippets_path = "/Users/gogo/.config/nvim/lua/custom/lua_snippets"
vim.o.clipboard = "unnamedplus"
vim.o.inccommand = "nosplit"
vim.o.pumheight = 10
vim.o.scrolloff = 2
vim.o.updatetime = 250

if vim.g.neovide then
  vim.g.neovide_cursor_animation_length = 0
  vim.g.neovide_cursor_trail_size = 0
  vim.opt.guifont = { "JetBrainsMono Nerd Font", "h9" }
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
