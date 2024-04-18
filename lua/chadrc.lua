-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

local literalize = function(str)
  return str:gsub("[%(%)%.%%%+%-%*%?%[%]%^%$]", function(c)
    return "%" .. c
  end)
end

M.ui = {
	theme = "onedark",
  tabufline = {
    enabled = false
  },
  statusline = {
    modules = {
      cwd = function ()
        return ""
      end,
      cursor = function ()
        return ""
      end,
      file = function ()
        local fn = vim.fn
        local icon = " 󰈚 "
        local buf = "#" ..  vim.api.nvim_win_get_buf(vim.g.statusline_winid)

        local org_filename = (fn.expand(buf) == "" and "Empty") or fn.expand(buf .. ":p")
        local filename = (fn.expand(buf) == "" and "Empty") or fn.expand(buf .. ":p")

        if filename ~= "Empty " then
          local devicons_present, devicons = pcall(require, "nvim-web-devicons")

          if devicons_present then
            local ft_icon = devicons.get_icon(filename)
            icon = (ft_icon ~= nil and " " .. ft_icon) or ""
          end

          filename = " " .. filename .. " "
        end

        if require("root").find(org_filename) ~= nil then
          local root = literalize((require("root").find(org_filename) .. "/"))
          local relative_filename = filename:gsub(root, "")
          return "%#StText# " .. icon .. relative_filename
        end

        return "%#StText# " .. icon .. filename
      end,
      lsp = function ()
        return ""
      end
    },
  }

  -- hl_override = {
  -- 	Comment = { italic = true },
  -- 	["@comment"] = { italic = true },
  -- },
}

return M
