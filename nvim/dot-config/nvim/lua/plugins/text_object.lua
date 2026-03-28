return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
	},
	init = function()
		local config = require("nvim-treesitter.configs")
		config.setup({
			textobjects = require("configs.treesitter_textobject"),
		})
	end,
}
