return {
	"gmartsenkov/root.nvim",
	lazy = false,
	config = true,
	opts = { patterns = { ".git", "Gemfile", "Cargo.toml" } },
	build = "make",
}
