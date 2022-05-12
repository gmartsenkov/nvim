-- example file i.e lua/custom/init.lua

-- MAPPINGS
local map = nvchad.map

map("n", "<leader>gg", ":Neogit <CR>")
map("n", "<leader>cc", ":Telescope <CR>")
map("n", "<leader>q", ":q <CR>")
map("n", "<leader>bb", ":Telescope buffers <CR>")
map("n", "<leader>x", ":Telescope commands <CR>")
map("n", "<leader>pp", ":Telescope projects <CR>")
map("n", "<leader><leader>", ":Telescope find_files <CR>")

map("n", "<leader>tv", ":TestFile <CR>")
map("n", "<leader>ta", ":TestSuite <CR>")
map("n", "<leader>ts", ":TestNearest <CR>")
-- require("my autocmds file") or just declare them here
