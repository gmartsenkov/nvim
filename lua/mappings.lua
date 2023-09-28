local opts = { noremap = true, silent = true }
local map = vim.keymap.set

local M = {}

M.telescope = {
  n = {
    ["<leader><leader>"] = {
      function()
        local cwd = require("root").find() or vim.fn.expand "%:p:h"
        vim.cmd("Telescope find_files theme=ivy previewer=false hidden=true cwd=" .. cwd)
      end,
      "find files",
    },
    ["<C-x>"] = { "<cmd> Telescope commands <CR>", "commands" },
    ["<leader>bb"] = { "<cmd> Telescope buffers <CR>", "find buffers" },
    ["<leader>bd"] = { "<cmd> Bdelete <CR>", "delete buffer" },
    ["<leader>bn"] = { "<cmd> enew <CR>", "new buffer" },
    ["<leader>pp"] = { "<cmd> Telescope project <CR>", "switch project" },
    ["<leader>ff"] = { "<cmd> Telescope file_browser path=%:p:h <CR>", "file browser" },
    ["<leader>/"] = { "<cmd> Telescope live_grep <CR>", "grep project" },
  },
}

M.tests = {
  n = {
    ["<leader>tt"] = {
      function()
        require("gotospec").jump(require("root").find())
      end,
      "switch between test/implementation",
    },
    ["<leader>tv"] = { "<cmd> TestFile <CR>", "test file" },
    ["<leader>tf"] = { "<cmd> TestLast --only-failures<CR>", "test failures" },
    ["<leader>tF"] = { "<cmd> TestSuite --only-failures<CR>", "test all failures" },
    ["<leader>ta"] = { "<cmd> TestSuite <CR>", "test project" },
    ["<leader>ts"] = { "<cmd> TestNearest <CR>", "test nearest" },
    ["<leader>tl"] = { "<cmd> TestLast <CR>", "test last" },
    ["<leader>tg"] = { "<cmd> TestVisit <CR>", "test visit last" },
  },
}

M.utils = {
  n = {
    ["<Esc>"] = {
      function()
        if string.len(vim.api.nvim_command_output "echo @/") > 0 then
          vim.cmd 'let @/ = ""'
          return
        end
        local terminals = require("toggleterm.terminal").get_all()
        for _, term in ipairs(terminals) do
          require("toggleterm.ui").close(term)
        end
      end,
    },
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

M.conjure = {
  v = {
    ["<leader>ev"] = { "<ESC><cmd> ConjureEvalVisual <CR>", "eval visual" },
  },
  n = {
    ["<leader>eb"] = { "<cmd> ConjureEvalBuf <CR>", "eval buffer" },
    ["<leader>ef"] = { "<cmd> ConjureEvalCurrentForm <CR>", "eval current form" },
    ["<leader>eF"] = { "<cmd> ConjureEvalCommentCurrentForm <CR>", "eval current form" },
    ["<leader>er"] = { "<cmd> ConjureEvalRootForm <CR>", "eval root form" },
    ["<leader>eR"] = { "<cmd> ConjureEvalCommentRootForm <CR>", "eval root form" },
    ["<leader>ew"] = { "<cmd> ConjureEvalWord <CR>", "eval word" },
    ["<leader>eW"] = { "<cmd> ConjureEvalCommentWord <CR>", "eval word" },
  },
}

M.lsp = {
  n = {
    ["gd"] = { "<cmd> Telescope lsp_definitions <CR>", "lsp definition" },
    ["<leader>cd"] = { "<cmd> Telescope lsp_definitions <CR>", "lsp definition" },
    ["<leader>cD"] = { "<cmd> Telescope diagnostics <CR>", "lsp diagnostics" },
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
  i = {
    ["<C-s>"] = { "<cmd> HopChar2 <CR>", "hop char 2" },
  },
  t = {
    ["<C-x>"] = { vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true), "Escape terminal mode" },
  },
  n = {
    ["<C-h>"] = { "<C-w>h", "Window left" },
    ["<C-l>"] = { "<C-w>l", "Window right" },
    ["<C-j>"] = { "<C-w>j", "Window down" },
    ["<C-k>"] = { "<C-w>k", "Window up" },
    ["<C-s>"] = { "<cmd> HopChar2 <CR>", "hop char 2" },
    ["gw"] = { "<cmd> HopChar2 <CR>", "hop char 2" },
    ["gl"] = { "<cmd> HopLine <CR>", "hop line" },
    ["<leader>wv"] = { "<cmd> vsplit <CR>", "split vertical" },
    ["<leader>wh"] = { "<cmd> split <CR>", "split horizontal" },
    ["<leader>wd"] = { "<cmd> close <CR>", "close window" },
    ["<leader>wo"] = { "<cmd> only <CR>", "focus window" },
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
    ["]d"] = {
      function ()
        vim.diagnostic.goto_next()
      end,
      "next diagnostic"
    },
    ["[d"] = {
      function ()
        vim.diagnostic.goto_prev()
      end,
      "next diagnostic"
    },
    ["]h"] = {
      function ()
        require("gitsigns").next_hunk()
      end,
      "next git change"
    },
    ["[h"] = {
      function ()
        require("gitsigns").prev_hunk()
      end,
      "previous git change"
    }
  },
}

M.git = {
  n = {
    ["<leader>gg"] = { "<cmd> Neogit <CR>", "neogit" },
    ["<leader>gb"] = { "<cmd> Telescope git_branches <CR>", "git branches" },
    ["<leader>gc"] = { "<cmd> Telescope git_commits <CR>", "git commits" },
    ["<leader>gp"] = { "<cmd> Git pull <CR>", "git pull" },
    ["<leader>gP"] = { "<cmd> Git push <CR>", "git push" },
  },
}

M.notes = {
  n = {
    ["<leader>nd"] = { "<cmd> ScribeOpen <CR>", "open default note" },
    ["<leader>nn"] = { "<cmd> ScribeNew <CR>", "new note" },
    ["<leader>nf"] = { "<cmd> ScribeFind <CR>", "new note" },
  },
}

M.tabs = {
  n = {
    ["<leader><tab>1"] = { "<cmd> tabnext 1 <CR>", "tab 1" },
    ["<leader><tab>2"] = { "<cmd> tabnext 2 <CR>", "tab 2" },
    ["<leader><tab>3"] = { "<cmd> tabnext 3 <CR>", "tab 3" },
    ["<leader><tab>4"] = { "<cmd> tabnext 4 <CR>", "tab 4" },
    ["<leader><tab>5"] = { "<cmd> tabnext 5 <CR>", "tab 5" },
    ["<leader><tab>n"] = { "<cmd> tabnew <CR>", "create tab" },
    ["<leader><tab>d"] = { "<cmd> tabclose <CR>", "close current tab" },
  },
}

--
-- map(
--   "n",
--   "<leader><leader>",
--   function()
--     local cwd = require("root").find() or vim.fn.expand "%:p:h"
--     vim.cmd("Telescope find_files theme=ivy previewer=false hidden=true cwd=" .. cwd)
--   end,
--   opts
-- )



for _, v in pairs(M) do
	for mode, x in pairs(v) do
	  for key, cmd in pairs(x) do
      map(mode, key, cmd[1])
	  end
	end
end
