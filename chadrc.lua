---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

M.ui = {
  theme = "gruvchad",
  theme_toggle = { "gruvchad_light", "gruvchad" },
  statusline = {
    overriden_modules = function()
      local fn = vim.fn
      local config = require("core.utils").load_config().ui.statusline
      local sep_style = config.separator_style

      local default_sep_icons = {
        default = { left = "", right = " " },
        round = { left = "", right = "" },
        block = { left = "█", right = "█" },
        arrow = { left = "", right = "" },
      }

      local separators = (type(sep_style) == "table" and sep_style) or default_sep_icons[sep_style]

      local sep_l = separators["left"]
      local sep_r = separators["right"]

      return {
        fileInfo = function()
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

          return "%#St_file_info#" .. icon .. filename .. "%#St_file_sep#" .. sep_r
        end,
      }
    end,
  },
  tabufline = {
    enabled = false,
  },
  -- hl_override = highlights.override,
  -- hl_add = highlights.add,
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

return M
