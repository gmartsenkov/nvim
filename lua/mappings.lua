local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map("n", "<leader><leader>", function ()
--   local cwd = require("root").find() or vim.fn.expand "%:p:h"
--   vim.cmd("Telescope find_files previewer=false hidden=true cwd=" .. cwd)
-- end)

map("n", "<C-h>", "<C-w>h", { desc = "Switch Window left" })
map("n", "<C-l>", "<C-w>l", { desc = "Switch Window right" })
map("n", "<C-j>", "<C-w>j", { desc = "Switch Window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Switch Window up" })
map("t", "<C-x>", "<C-\\><C-N>", { desc = "Terminal Escape terminal mode" })

map("n", "<leader><leader>", function ()
  -- local cwd = require("root").find() or vim.fn.expand "%:p:h"
  -- vim.cmd("Telescope frecency hidden=true workspace=CWD cwd=" .. cwd)
  vim.cmd("Telescope frecency hidden=true previewer=false workspace=CWD")
end)

map("n", "<leader>bb", "<cmd> Telescope buffers <CR>")
map("n", "<leader>bd", "<cmd> Bdelete <CR>")
map("n", "<leader>bn", "<cmd> enew <CR>")
map("n", "<leader>pp", "<cmd> Telescope project <CR>")
map("n", "<leader>ff", "<cmd> Telescope file_browser path=%:p:h <CR>")
map("n", "<leader>/", "<cmd> Telescope live_grep <CR>")

-- Testing
map("n", "<leader>tt",
  function()
    require("gotospec").jump(require("root").find())
  end
)
map("n", "<leader>tv", "<cmd> TestFile <CR>")
map("n", "<leader>tf", "<cmd> TestLast --only-failures<CR>")
map("n", "<leader>tF", "<cmd> TestSuite --only-failures<CR>")
map("n", "<leader>ta", "<cmd> TestSuite <CR>")
map("n", "<leader>tc", "<cmd> TestNearest <CR>")
map("n", "<leader>tl", "<cmd> TestLast <CR>")
map("n", "<leader>tg", "<cmd> TestVisit <CR>")
--


map("n", "<Esc>", function()
  if string.len(vim.api.nvim_command_output "echo @/") > 0 then
    vim.cmd 'let @/ = ""'
    return
  end
  local terminals = require("toggleterm.terminal").get_all()
  for _, term in ipairs(terminals) do
    require("toggleterm.ui").close(term)
  end
end)
map("n", "<leader>mp", function()
  local terminals = require("toggleterm.terminal").get_all()
  for _, term in ipairs(terminals) do
    vim.cmd(term.bufnr .. "bdelete!")
  end
  vim.cmd "TermExec cmd='bundle exec rubocop'"
end)


-- LSP
map("n", "gd", "<cmd> Telescope lsp_definitions <CR>", { silent=true })
map("n", "gr", "<cmd> Telescope lsp_references <CR>", { silent=true })
map("n", "<leader>cd", "<cmd> Telescope lsp_definitions <CR>")
map("n", "<leader>cD", "<cmd> Telescope diagnostics <CR>")
map("n", "<leader>cr", "<cmd> Telescope lsp_references <CR>")
map("n", "<leader>cs", "<cmd> Telescope lsp_document_symbols <CR>")
map("n", "<leader>cw", "<cmd> Telescope lsp_workspace_symbols <CR>")
map("n", "<leader>cc", "<cmd> LspRestart <CR>")
map("n", "<leader>ca", function()
    vim.lsp.buf.code_action()
  end
)
map("n", "<leader>cR", function()
    vim.lsp.buf.rename()
  end
)
map("n", "<leader>ch", function()
    vim.lsp.buf.hover()
  end
)
map("n", "<C-d>", "<cmd> TroubleToggle <CR>")


-- Git
map("n", "<leader>gg", "<cmd> Neogit <CR>")
map("n", "<leader>gb", "<cmd> Telescope git_branches <CR>")
map("n", "<leader>gc", "<cmd> Telescope git_commits <CR>")
map("n", "<leader>gp", "<cmd> Git pull <CR>")
map("n", "<leader>gP", "<cmd> Git push <CR>")

-- Navigation
map("n", "<C-s>", "<cmd> HopChar2 <CR>")
map("n", "gw", "<cmd> HopChar2 <CR>")
map("n", "gl", "<cmd> HopLine <CR>")
map("n", "<leader>wv", "<cmd> vsplit <CR>")
map("n", "<leader>wh", "<cmd> split <CR>")
map("n", "<leader>wd", "<cmd> close <CR>")
map("n", "<leader>wo", "<cmd> only <CR>")
map("n", "<leader>o", "<cmd> Other<CR>")
map("n", "<leader>qq", "<cmd> qa <CR>")
map("n", "<C-Tab>", function()
    require("core.utils").tabuflinePrev()
  end
)
map("n", "<C-[>", "<cmd> bprevious <CR>")
map("n", "<C-]>", "<cmd> bnext <CR>")
map("n", "]d", function ()
    vim.diagnostic.goto_next()
  end
)
map("n", "[d", function ()
    vim.diagnostic.goto_prev()
  end
)

-- Tabs
map("n", "<leader><tab>1", "<cmd> tabnext 1 <CR>")
map("n", "<leader><tab>2", "<cmd> tabnext 2 <CR>")
map("n", "<leader><tab>3", "<cmd> tabnext 3 <CR>")
map("n", "<leader><tab>4", "<cmd> tabnext 4 <CR>")
map("n", "<leader><tab>5", "<cmd> tabnext 5 <CR>")
map("n", "<leader><tab>n", "<cmd> tabnew <CR>")
map("n", "<leader><tab>d", "<cmd> tabclose <CR>")
