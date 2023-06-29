return {
  mapping = {
    ["<Down>"] = require("cmp").mapping.select_next_item(),
    ["<C-j>"] = require("cmp").mapping.select_next_item(),
    ["<C-k>"] = require("cmp").mapping.select_prev_item(),
    ["<Up>"] = require("cmp").mapping.select_prev_item(),
    ["<S-CR>"] = require("cmp").mapping.abort(),
    ["<Tab>"] = require("cmp").mapping(function(callback)
      if require("luasnip").expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
      else
        callback()
      end
    end),
    ["<S-Tab>"] = require("cmp").mapping(function(callback)
      if require("luasnip").expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
      else
        callback()
      end
    end),
  },
  sources = {
    { name = "luasnip", max_item_count = 5 },
    { name = "nvim_lsp", max_item_count = 5 },
    { name = "crates", max_items_count = 10 },
    { name = "nvim_lua", max_item_count = 5 },
    { name = "path", max_item_count = 5 },
    { name = "buffer", max_item_count = 5 },
  },
}
