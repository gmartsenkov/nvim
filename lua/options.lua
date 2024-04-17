require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

vim.g.snipmate_snippets_path = "/Users/gogo/.config/nvim/lua/lua_snippets"
vim.o.clipboard = "unnamedplus"
vim.o.inccommand = "nosplit"
vim.o.laststatus = 2
vim.o.pumheight = 10
vim.o.scrolloff = 10
vim.o.updatetime = 250
vim.wo.number = true
vim.g.vscode_snippets_exclude = { "ruby", "elixir", "rust" }
vim.g.snipmate_snippets_path = "~/.config/nvim/snippets"

if vim.g.neovide then
  vim.g.neovide_cursor_animation_length = 0
  vim.g.neovide_cursor_trail_size = 0
  vim.g.neovide_cursor_antialiasing = true
  vim.g.neovide_scroll_animation_length = 0.3
  vim.g.neovide_refresh_rate = 100
  vim.g.neovide_refresh_rate_idle = 5
  vim.opt.guifont = "JetBrainsMono Nerd Font:h14:#e-subpixelantialias:#h-full"
end

local autocmd = vim.api.nvim_create_autocmd

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
