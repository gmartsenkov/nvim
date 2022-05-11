-- example file i.e lua/custom/init.lua

-- MAPPINGS
local map = nvchad.map

map("n", "<leader>cc", ":Telescope <CR>")
map("n", "<leader>q", ":q <CR>")
map("n", "<leader>bb", ":Telescope buffers <CR>")
map("n", "<leader>x", ":Telescope commands <CR>")

-- require("my autocmds file") or just declare them here
