local function border(hl_name)
  return {
    { "╭", hl_name },
    { "─", hl_name },
    { "╮", hl_name },
    { "│", hl_name },
    { "╯", hl_name },
    { "─", hl_name },
    { "╰", hl_name },
    { "│", hl_name },
  }
end

return function ()
  local cmp = require("cmp")
  local lspkind = require('lspkind')

  vim.api.nvim_set_hl(0, "CmpItemKindModule", { ctermbg=0, bg=LightGrey })
  vim.api.nvim_set_hl(0, "CmpItemKindClass", { ctermbg=0, bg=LightGrey })
  vim.api.nvim_set_hl(0, "CmpItemKindFunction", { ctermbg=0, bg=LightGrey })
  vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { ctermbg=0, bg=LightGrey })
  vim.api.nvim_set_hl(0, "CmpItemKindVariable", { ctermbg=0, bg=LightGrey })
  vim.api.nvim_set_hl(0, "CmpItemKindText", { ctermbg=0, bg=LightGrey })
  vim.api.nvim_set_hl(0, "CmpItemKindStruct", { ctermbg=0, bg=LightGrey })
  vim.api.nvim_set_hl(0, "CmpItemKindInterface", { ctermbg=0, bg=LightGrey })
  vim.api.nvim_set_hl(0, "CmpItemKindMethod", { ctermbg=0, bg=LightGrey })
  vim.api.nvim_set_hl(0, "CmpItemKindConstant", { ctermbg=0, bg=LightGrey })
  vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { ctermbg=0, bg=LightGrey })

  return {
    completion = {
      completeopt = 'menu,menuone,noinsert',
    },
    formatting = {
      format = lspkind.cmp_format({
        mode = 'symbol_text', -- show only symbol annotations
        maxwidth = 30, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
        ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

        -- The function below will be called before any actual modifications from lspkind
        -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
        before = function (entry, vim_item)
          vim_item.abr = string.sub(vim_item.abr or "", 1, 10)
          vim_item.menu = string.sub(vim_item.menu or "", 1, 10)

          return vim_item
        end
      })
    },
    window = {
      documentation = {
        border = border "CmpDocBorder",
        winhighlight = "Normal:CmpDoc",
      },
    },
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },

    mapping = {
      ["<Down>"] = cmp.mapping.select_next_item(),
      ["<C-j>"] = cmp.mapping.select_next_item(),
      ["<C-k>"] = cmp.mapping.select_prev_item(),
      ["<Up>"] = cmp.mapping.select_prev_item(),
      ["<S-CR>"] = cmp.mapping.abort(),
      ["<Tab>"] = cmp.mapping(function(callback)
        if require("luasnip").expand_or_jumpable() then
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
        else
          callback()
        end
      end),
      ["<S-Tab>"] = cmp.mapping(function(callback)
        if require("luasnip").expand_or_jumpable() then
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
        else
          callback()
        end
      end),
      ["<C-p>"] = cmp.mapping.select_prev_item(),
      ["<C-n>"] = cmp.mapping.select_next_item(),
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.close(),
      ["<CR>"] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      },
    },
    sources = {
      { name = "luasnip" },
      { name = "nvim_lsp" },
      { name = "crates" },
      { name = "nvim_lua" },
      { name = "path" },
      { name = "buffer" },
    },
  }
end
