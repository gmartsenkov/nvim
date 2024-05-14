return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = { { "RRethy/nvim-treesitter-endwise", lazy = false } },
	cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
	event = { "BufReadPost", "BufNewFile" },
	build = ":TSUpdate",
	opts = {
		highlight = {
			enable = true,
			use_languagetree = true,
		},
		ensure_installed = {
			"eex",
			"surface",
			"heex",
			"html",
			"erlang",
			"lua",
			"vim",
			"ruby",
			"rust",
			"elixir",
			"c",
			"javascript",
			"markdown",
		},
		endwise = {
			enable = true,
		},
		indent = {
			enable = true,
			disable = { "ruby" },
		},
	},
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end,
}
