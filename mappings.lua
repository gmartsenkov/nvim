local M = {}

M.neogit = {
  n = {
    ["<leader>gg"] = { "<cmd> Neogit <CR>", "neogit" },
  },
}

M.telescope = {
  n = {
    ["<leader><leader>"] = { "<cmd> Telescope find_files hidden=true<CR>", "find files" },
    ["<C-x>"] = { "<cmd> Telescope commands <CR>", "commands" },
    ["<leader>bb"] = { "<cmd> Telescope buffers <CR>", "find buffers" },
    ["<leader>bd"] = { "<cmd> Bdelete <CR>", "delete buffer" },
    ["<leader>bn"] = { "<cmd> enew <CR>", "new buffer" },
    ["<leader>pp"] = { "<cmd> Telescope projects <CR>", "switch project" },
    ["<leader>ff"] = { "<cmd> Telescope file_browser path=%:p:h <CR>", "file browser" },
    ["<leader>/"] = { "<cmd> Telescope live_grep <CR>", "grep project" },
  },
}

M.tests = {
  n = {
    ["<leader>tt"] = {
      function()
        require("gotospec").jump()
      end,
      "switch between test/implementation",
    },
    ["<leader>tv"] = { "<cmd> TestFile <CR>", "test file" },
    ["<leader>ta"] = { "<cmd> TestSuite <CR>", "test project" },
    ["<leader>ts"] = { "<cmd> TestNearest <CR>", "test nearest" },
    ["<leader>tl"] = { "<cmd> TestLast <CR>", "test last" },
    ["<leader>tg"] = { "<cmd> TestVisit <CR>", "test visit last" },
  },
}

M.utils = {
  n = {

    ["<leader>mp"] = {
      function()
        local terminals = require("toggleterm.terminal").get_all()
        for _, term in ipairs(terminals) do
          vim.cmd(term.bufnr .. "bdelete!")
        end
        vim.cmd "TermExec cmd='bundle exec rubocop'"
      end,
    },
  },
}

M.lsp = {
  n = {
    ["<leader>cd"] = { "<cmd> Telescope lsp_definitions <CR>", "lsp definition" },
    ["<leader>cr"] = { "<cmd> Telescope lsp_references <CR>", "lsp references" },
    ["<leader>cs"] = { "<cmd> Telescope lsp_document_symbols <CR>", "lsp document symbols" },
    ["<leader>cw"] = { "<cmd> Telescope lsp_workspace_symbols <CR>", "lsp workspace symbols" },
    ["<leader>cc"] = { "<cmd> LspRestart <CR>", "lsp restart" },
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
    ["<leader>ch"] = {
      function()
        vim.lsp.buf.hover()
      end,
      "lsp hover",
    },
    ["<C-d>"] = { "<cmd> TroubleToggle <CR>", "toggle diagnostics" },
  },
}

M.nav = {
  n = {
    ["s"] = {
      function()
        require("leap").leap { opts = { labels = {} } }
      end,
    },
    ["S"] = {
      function()
        require("leap").leap { opts = { labels = {} }, backward = true }
      end,
    },
    ["<leader>wv"] = { "<cmd> vsplit <CR>", "split vertical" },
    ["<leader>wh"] = { "<cmd> split <CR>", "split horizontal" },
    ["<leader>wd"] = { "<cmd> close <CR>", "close window" },
    ["<leader>wo"] = { "<cmd> only <CR>", "focus window" },
    ["<leader>gb"] = { "<cmd> Telescope git_branches <CR>", "git branches" },
    ["<leader>gc"] = { "<cmd> Telescope git_commits <CR>", "git commits" },
    ["<leader>o"] = { "<cmd> Other<CR>", "other file" },
    ["<leader>qq"] = { "<cmd> qa <CR>", "quit neovim" },
    ["<C-Tab>"] = {
      function()
        require("core.utils").tabuflinePrev()
      end,
      "goto prev buffer",
    },
    ["<C-[>"] = { "<cmd> bprevious <CR>", "previous buffer" },
    ["<C-]>"] = { "<cmd> bnext <CR>", "next buffer" },
  },
}

M.tabs = {
  n = {
    ["<leader><tab>1"] = { "<cmd> tabnext 1 <CR>", "tab 1" },
    ["<leader><tab>2"] = { "<cmd> tabnext 2 <CR>", "tab 2" },
    ["<leader><tab>3"] = { "<cmd> tabnext 3 <CR>", "tab 3" },
    ["<leader><tab>4"] = { "<cmd> tabnext 4 <CR>", "tab 4" },
    ["<leader><tab>n"] = { "<cmd> tabnew <CR>", "create tab" },
    ["<leader><tab>d"] = { "<cmd> tabclose <CR>", "close current tab" },
  }
}

M.disabled = {
  n = {
    ["<leader>h"] = ""
  }
}

return M
