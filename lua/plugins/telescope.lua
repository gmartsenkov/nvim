local opts = function()
	local actions = require("telescope.actions")
	local fb_actions = require("telescope._extensions.file_browser.actions")
	local layout_strategies = require("telescope.pickers.layout_strategies")
	local p_window = require("telescope.pickers.window")

	return {
		defaults = {
			mappings = {
				i = {
					["<esc>"] = require("telescope.actions").close,
					["<C-j>"] = require("telescope.actions").move_selection_next,
					["<C-k>"] = require("telescope.actions").move_selection_previous,
					["<C-n>"] = require("telescope.actions").cycle_history_next,
					["<C-p>"] = require("telescope.actions").cycle_history_prev,
					["<C-a>"] = { "<home>", type = "command" },
					["<C-e>"] = { "<end>", type = "command" },
				},
			},
			file_ignore_patterns = { "node_modules", "resources/public/js/", ".git/", ".shadow-cljs/" },
		},
		extensions = {
			file_browser = {
				mappings = {
					i = {
						["<Tab>"] = actions.select_default,
						["<C-CR>"] = fb_actions.create_from_prompt,
					},
				},
			},
			advanced_git_search = {
				-- fugitive or diffview
				diff_plugin = "fugitive",
				-- customize git in previewer
				-- e.g. flags such as { "--no-pager" }, or { "-c", "delta.side-by-side=false" }
				git_flags = {},
				-- customize git diff in previewer
				-- e.g. flags such as { "--raw" }
				git_diff_flags = {},
			},
		},
		extensions_list = { "themes", "terms", "file_browser", "frecency" },
	}
end

return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-telescope/telescope-file-browser.nvim",
		"nvim-telescope/telescope-frecency.nvim",
	},
	cmd = "Telescope",
	opts = opts,
}
