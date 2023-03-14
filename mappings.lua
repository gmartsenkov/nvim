local M = {}

M.neogit = {
  n = {
    ["<leader>gg"] = {"<cmd> Neogit <CR>", "neogit"}
  }
}

M.telescope = {
  n = {
    ["<leader><leader>"] = {"<cmd> Telescope find_files hidden=true<CR>", "find files"},
    ["<leader>x"] = {"<cmd> Telescope commands <CR>", "commands"},
    ["<leader>bb"] = {"<cmd> Telescope buffers <CR>", "find buffers"},
    ["<leader>bd"] = {"<cmd> bdelete <CR>", "delete buffer"},
    ["<leader>bn"] = {"<cmd> enew <CR>", "new buffer"},
    ["<leader>pp"] = {"<cmd> Telescope projects <CR>", "switch project"},
    ["<leader>ff"] = {"<cmd> Telescope file_browser path=%:p:h <CR>", "file browser"},
    ["<leader>/"] = {"<cmd> Telescope live_grep <CR>", "grep project"}
  }
}

M.tests = {
  n = {
    ["<leader>tt"] = {"<cmd> A<CR>", "test file"},
    ["<leader>tT"] = {"<cmd> AV<CR>", "test file"},
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
    ["<leader>cR"] = {
      function()
        vim.lsp.buf.rename()
      end,
      "lsp rename",
    },
    ["<C-d>"] = {"<cmd> TroubleToggle <CR>", "toggle diagnostics"}
  }
}

M.eval = {
  n = {
    ["<leader>eb"] = {"<cmd> ConjureEvalBuf <CR>", "eval buffer"},
    ["<leader>ef"] = {"<cmd> ConjureEvalCurrentForm <CR>", "eval current form"},
    ["<leader>er"] = {"<cmd> ConjureEvalRootForm <CR>", "eval root form"},
    ["<leader>ev"] = {"<cmd> ConjureEvalVisual <CR>", "eval visual"},
    ["<leader>ew"] = {"<cmd> ConjureEvalWord <CR>", "eval word"},
    ["<leader>e!"] = {"<cmd> ConjureEvalReplaceForm <CR>", "eval and replace form"},
    ["<leader>et"] = {"<cmd> ConjureCljRunCurrentNsTests <CR>", "Run NS tests"},
    ["<leader>eT"] = {"<cmd> ConjureCljRunAllTests <CR>", "Run all tests"},
  }
}

M.nav = {
  n = {
    ["<leader>wv"] = {"<cmd> vsplit <CR>", "split vertical"},
    ["<leader>wh"] = {"<cmd> split <CR>", "split horizontal"},
    ["<leader>wd"] = {"<cmd> close <CR>", "close window"},
    ["<leader>gb"] = {"<cmd> Telescope git_branches <CR>", "git branches"},
    ["<leader>o"] = {"<cmd> Other<CR>", "other file"},
    ["<C-t>"] = {"<cmd> Ttoggle <CR>", "toggle terminal"},
    ["<C-Tab>"] = {
      function()
        require("core.utils").tabuflinePrev()
      end,
      "goto prev buffer",
    },
  },
}

M.disabled = {
   n = {
      ["<leader>e"] = ""
   }
}

return M
