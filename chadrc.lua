---@type ChadrcConfig
local M = {}

local literalize = function(str)
  return str:gsub("[%(%)%.%%%+%-%*%?%[%]%^%$]", function(c)
    return "%" .. c
  end)
end

local short_git = function(str)
  if not vim.b.gitsigns_head or vim.b.gitsigns_git_status then
    return ""
  end

  return "%#StText#  " .. string.sub(vim.b.gitsigns_status_dict.head, 1, 30) .. " "
end

local relative_filename = function()
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

M.ui = {
  theme = "ayu_dark",
  theme_toggle = { "ayu_dark_light", "ayu_dark" },
  transparency = false,
  changed_themes = {},
  nvdash = {},
  cheatsheet = {},
  extended_integrations = {},
  lsp_semantic_tokens = false, -- needs nvim v0.9, just adds highlight groups for lsp semantic tokens
  statusline = {
    theme = "vscode_colored",
    separator_style = "default",
    lspprogress_len = 100,
    overriden_modules = function(modules)
      table.remove(modules, 2)
      table.remove(modules, 7)
      table.remove(modules, 7)
      table.remove(modules, 7)
      table.remove(modules, 2)
      table.insert(modules, 2, relative_filename())
      table.insert(modules, 4, "%=")
      table.insert(modules, 8, short_git())
    end,
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
  hl_add = {
    NeogitDiffDeleteHighlight = { fg = "#fa6b6b", bg = "#4f343a" },
    NeogitDiffDelete = { fg = "#fa6b6b", bg = "#4f343a" },
    NeogitDiffDeleteRegion = { fg = "#fa6b6b", bg = "#4f343a" },
  },
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

return M
