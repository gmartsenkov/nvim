return {
	"akinsho/toggleterm.nvim",
	version = "*",
	lazy = false,
	opts = {
		close_on_exit = true,
		direction = "horizontal",
		shade_terminals = false,
		open_mapping = [[<C-t>]],
		size = function(term)
			if term.direction == "horizontal" then
				return vim.o.lines * 0.4
			elseif term.direction == "vertical" then
				return vim.o.columns * 0.4
			end
		end,
	},
}
