return {
	"lukas-reineke/indent-blankline.nvim",
	version = "2.20.7",
	lazy = false,
	opts = function()
		return {
			scope = { enabled = true },
			indentLine_enabled = 1,
			filetype_exclude = {
				"help",
				"terminal",
				"lazy",
				"lspinfo",
				"TelescopePrompt",
				"TelescopeResults",
				"mason",
				"nvdash",
				"nvcheatsheet",
				"",
			},
			buftype_exclude = { "terminal" },
			show_trailing_blankline_indent = false,
			show_first_indent_level = false,
			show_current_context = true,
			show_current_context_start = true,
		}
	end,
	config = function(_, opts)
		require("indent_blankline").setup(opts)
		vim.api.nvim_set_hl(0, "IndentBlanklineChar", { fg = "#333333" })
		vim.api.nvim_set_hl(0, "IndentBlanklineSpaceChar", { fg = "#333333" })
		vim.api.nvim_set_hl(0, "IndentBlanklineContextChar", { fg = "#404040" })
		vim.api.nvim_set_hl(0, "IndentBlanklineContextStart", { bg = "#404040" })
	end,
}
