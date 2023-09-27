local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Bootstap hotpot into lazy plugin dir if it does not exist yet.
local hotpotpath = vim.fn.stdpath("data") .. "/lazy/hotpot.nvim"
if not vim.loop.fs_stat(hotpotpath) then
  vim.notify("Bootstrapping hotpot.nvim...", vim.log.levels.INFO)
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    -- You may with to pin a known version tag with `--branch=vX.Y.Z`
    "--branch=v0.9.6",
    "https://github.com/rktjmp/hotpot.nvim.git",
    hotpotpath,
  })
end

-- As per lazy's install instructions, but insert hotpots path at the front
vim.opt.runtimepath:prepend({hotpotpath, lazypath})

vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

require("lazy").setup({
  "rktjmp/hotpot.nvim",
  {
    "gmartsenkov/root.nvim",
    lazy = false,
    config = true,
    build = "make",
  },
  {
    "nyoom-engineering/oxocarbon.nvim",
    lazy = false
  },
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = { { "RRethy/nvim-treesitter-endwise", lazy = false } },
    opts = {
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
  },
}, {
    root = "/Users/gogo/.config2/lazy"
  })

vim.opt.background = "dark" -- set this to dark or light
vim.cmd.colorscheme "oxocarbon"

require("defaults")
require("mappings")
