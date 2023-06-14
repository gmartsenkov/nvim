---@type ChadrcConfig
local M = {}

function literalize(str)
    return str:gsub("[%(%)%.%%%+%-%*%?%[%]%^%$]", function(c) return "%" .. c end)
end

M.ui = {
  theme = "gruvchad",
  theme_toggle = { "gruvchad_light", "gruvchad" },
  transparency = false,
  lsp_semantic_tokens = false, -- needs nvim v0.9, just adds highlight groups for lsp semantic tokens
  statusline = {
    theme = 'vscode_colored',
    overriden_modules = function()
      return {
        file_encoding = function ()
          return ""
        end,
        cursor_position = function ()
          return ""
        end,
        git = function()
          return ""
        end,
        gitchanges = function()
          if not vim.b.gitsigns_head or vim.b.gitsigns_git_status then
            return ""
          end

          return "%#StText#  " .. string.sub(vim.b.gitsigns_status_dict.head, 1, 20) .. "  "
        end,
        fileInfo = function()
          local fn = vim.fn
          local icon = " 󰈚 "
          local filename = (fn.expand "%" == "" and "Empty ") or fn.expand "%"

          if filename ~= "Empty " then
            local devicons_present, devicons = pcall(require, "nvim-web-devicons")

            if devicons_present then
              local ft_icon = devicons.get_icon(filename)
              icon = (ft_icon ~= nil and " " .. ft_icon) or ""
            end

            filename = " " .. filename .. " "
          end

          if require("root").find() ~= nil then
            local root = literalize((require("root").find() .. "/"))
            local relative_filename = filename:gsub(root, "")
            return "%#StText# " .. icon .. relative_filename
          end

          return "%#StText# " .. icon .. filename
        end
      }
    end
  },
  tabufline = {
    enabled = false,
  },
  cmp = {
    icons = true,
    lspkind_text = true,
    style = "default", -- default/flat_light/flat_dark/atom/atom_colored
    border_color = "grey_fg", -- only applicable for "default" style, use color names from base30 variables
    selected_item_bg = "colored", -- colored / simple
  },
  lsp = {
    -- show function signatures i.e args as you type
    signature = {
      disabled = false,
      silent = true, -- silences 'no signature help available' message from appearing
    },
  },
  telescope = { style = "borderless" }, -- borderless / bordered
  nvdash = {
    load_on_startup = true,

    header = {
      "           ▄ ▄                   ",
      "       ▄   ▄▄▄     ▄ ▄▄▄ ▄ ▄     ",
      "       █ ▄ █▄█ ▄▄▄ █ █▄█ █ █     ",
      "    ▄▄ █▄█▄▄▄█ █▄█▄█▄▄█▄▄█ █     ",
      "  ▄ █▄▄█ ▄ ▄▄ ▄█ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄  ",
      "  █▄▄▄▄ ▄▄▄ █ ▄ ▄▄▄ ▄ ▄▄▄ ▄ ▄ █ ▄",
      "▄ █ █▄█ █▄█ █ █ █▄█ █ █▄█ ▄▄▄ █ █",
      "█▄█ ▄ █▄▄█▄▄█ █ ▄▄█ █ ▄ █ █▄█▄█ █",
      "    █▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█ █▄█▄▄▄█    ",
    },

    buttons = {
      { "  Find Project", "Spc p p", "Telescope project" },
      { "󰈚  Recent Files", "Spc f o", "Telescope oldfiles" },
      { "󰈭  Find Word", "Spc f w", "Telescope live_grep" },
      { "  Bookmarks", "Spc m a", "Telescope marks" },
      { "  Themes", "Spc t h", "Telescope themes" },
      { "  Mappings", "Spc c h", "NvCheatsheet" },
    },
  },
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

return M
