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

local config = function()
	local cmp = require("cmp")
	local lspkind = require("lspkind")
	local item_highlights = {
		"CmpItemKindModule",
		"CmpItemKindClass",
		"CmpItemKindFunction",
		"CmpItemKindSnippet",
		"CmpItemKindVariable",
		"CmpItemKindText",
		"CmpItemKindStruct",
		"CmpItemKindInterface",
		"CmpItemKindMethod",
		"CmpItemKindConstant",
		"CmpItemKindConstant",
	}

	for _, name in pairs(item_highlights) do
		vim.api.nvim_set_hl(0, name, { ctermbg = 0, bg = LightGrey })
	end

	return {
		completion = {
			completeopt = "menu,menuone,noinsert",
		},
		formatting = {
			format = lspkind.cmp_format({
				mode = "symbol_text", -- show only symbol annotations
				maxwidth = 30, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
				ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

				-- The function below will be called before any actual modifications from lspkind
				-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
				before = function(entry, vim_item)
					vim_item.abr = string.sub(vim_item.abr or "", 1, 10)
					vim_item.menu = string.sub(vim_item.menu or "", 1, 30)

					return vim_item
				end,
			}),
		},
		window = {
			documentation = {
				border = border("CmpDocBorder"),
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
			-- ["<S-CR>"] = cmp.mapping.abort(),
			["<Tab>"] = cmp.mapping(function(callback)
				if require("luasnip").expand_or_jumpable() then
					vim.fn.feedkeys(
						vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true),
						""
					)
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
			["<CR>"] = cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Insert,
				select = true,
			}),
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

return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		{ "onsails/lspkind.nvim", lazy = false },
		{
			-- snippet plugin
			"L3MON4D3/LuaSnip",
			dependencies = "rafamadriz/friendly-snippets",
			opts = { history = true, updateevents = "TextChanged,TextChangedI" },
			config = function()
				require("luasnip.loaders.from_snipmate").lazy_load({ paths = vim.fn.stdpath("config") .. "/snippets" })
			end,
		},
		"saadparwaiz1/cmp_luasnip",
		"hrsh7th/cmp-nvim-lua",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
	},
	opts = config,
	config = function(_, opts)
		require("cmp").setup(opts)
	end,
}
