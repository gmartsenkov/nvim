local M = {}

M.neogit = {
  n = {
    ["<leader>gg"] = {"<cmd> Neogit <CR>", "neogit"}
  }
}

M.telescope = {
  n = {
    ["<leader><leader>"] = {"<cmd> Telescope find_files <CR>", "find files"},
    ["<leader>bb"] = {"<cmd> Telescope buffers <CR>", "find buffers"},
    ["<leader>bd"] = {"<cmd> bdelete <CR>", "delete buffer"},
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
    ["<leader>cd"] = {
      function()
        vim.lsp.buf.definition()
      end,
      "lsp definition",
    },
    ["<leader>cr"] = {
      function()
        vim.lsp.buf.references()
      end,
      "lsp references",
    },
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
    ["<C-[>"] = {"<cmd> bprevious <CR>", "previous buffer"},
    ["<C-]>"] = {"<cmd> bnext <CR>", "next buffer"},
    ["<leader>wv"] = {"<cmd> vsplit <CR>", "split vertical"},
    ["<leader>wh"] = {"<cmd> split <CR>", "split horizontal"},
    ["<C-t>"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "   toggle floating term",
    },
  },
  t = {
    ["<C-t>"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "   toggle floating term",
    },
  }
}

return M
