return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		-- This is also set on the lua/core/set_vim
		vim.o.timeoutlen = 500
	end,
	opts = {},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
	plugins = {
		marks = true,
		spelling = {
			enabled = true,
			suggestion = 20,
		},
	},
}
