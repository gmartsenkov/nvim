local M = {}

M.neogit = {
  n = {
    ["<leader>gg"] = {"<cmd> Neogit <CR>", "neogit"}
  }
}

M.telescope = {
  n = {
    ["<leader><leader>"] = {"<cmd> Telescope find_files <CR>", "find files"},
    ["<leader>x"] = {"<cmd> Telescope commands <CR>", "commands"},
    ["<leader>bb"] = {"<cmd> Telescope buffers <CR>", "find buffers"},
    ["<leader>bd"] = {"<cmd> bdelete <CR>", "delete buffer"},
    ["<leader>bn"] = {"<cmd> enew <CR>", "new buffer"},
    ["<leader>pp"] = {"<cmd> Telescope projects <CR>", "switch project"},
    ["<leader>/"] = {"<cmd> Telescope live_grep <CR>", "grep project"}
  }
}

M.tests = {
  n = {
    ["<leader>tt"] = {"<cmd> Other <CR>", "test file"},
    ["<leader>tv"] = {"<cmd> TestFile <CR>", "test file"},
    ["<leader>ta"] = {"<cmd> TestSuite <CR>", "test project"},
    ["<leader>ts"] = {"<cmd> TestNearest <CR>", "test nearest"},
  }
}

M.lsp = {
  n = {
    ["<leader>cd"] = {"<cmd> Telescope lsp_definitions <CR>", "lsp definition"},
    ["<leader>cr"] = {"<cmd> Telescope lsp_references <CR>", "lsp references"},
    ["<leader>cs"] = {"<cmd> Telescope lsp_document_symbols <CR>", "lsp document symbols"},
    ["<leader>cw"] = {"<cmd> Telescope lsp_workspace_symbols <CR>", "lsp workspace symbols"},
    ["<leader>ca"] = {
      function()
        vim.lsp.buf.code_action()
      end,
      "lsp action",
    },
  }
}

M.nav = {
  n = {
    ["<C-a>"] = {"<cmd> bprevious <CR>", "previous buffer"},
    ["<C-d>"] = {"<cmd> bnext <CR>", "next buffer"},
    ["<leader>wv"] = {"<cmd> vsplit <CR>", "split vertical"},
    ["<leader>wh"] = {"<cmd> split <CR>", "split horizontal"},
    ["<leader>wd"] = {"<cmd> close <CR>", "close window"},
    ["<leader>gb"] = {"<cmd> Telescope git_branches <CR>", "git branches"},
  },
}

return M
