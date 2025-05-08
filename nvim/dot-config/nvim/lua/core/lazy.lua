---
--- See - https://lazy.folke.io/
--- https://github.com/folke/lazy.nvim
---

local plugins = require("plugins")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

local opts = {
	install = {
		missing = true,
		colorscheme = { "catppuccin" },
	},
	checker = {
		enabled = true,
		notify = false,
		cocurrency = 1, -- check for update very slowly
		frequency = 3600 * 24 * 10, -- check for update every 10 days
	},
	change_detection = {
		enabled = true,
		notify = true,
	},
}

require("lazy").setup(plugins, opts)
