return {
	"stevearc/conform.nvim",
	lazy = false,
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			ruby = { "rubocop" },
			rust = { "rustfmt" },
			javascript = { { "prettierd", "prettier" } },
		},
	},
	config = function(_, opts)
		require("conform").setup(opts)
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = { "*.lua", "*.rs" },
			callback = function(args)
				require("conform").format({ bufnr = args.buf, quiet = true })
			end,
		})
	end,
}
