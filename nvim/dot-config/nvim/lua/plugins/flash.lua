return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {},
	keys = {
		{
			"<leader>jj",
			mode = { "n", "x", "o" },
			function()
				require("flash").jump()
			end,
			desc = "Flash [J]ump",
		},
		{
			"<leader>jt",
			mode = { "n", "x", "o" },
			function()
				require("flash").treesitter()
			end,
			desc = "[F]lash [T]reesitter",
		},
		{
			"<leader>jr",
			mode = "o",
			function()
				require("flash").remote()
			end,
			desc = "Remote Flash",
		},
		{
			"<leader>s",
			mode = { "o", "x" },
			function()
				require("flash").treesitter_search()
			end,
			desc = "Treesitter Search",
		},
		{
			"<c-s>",
			mode = { "c" },
			function()
				require("flash").toggle()
			end,
			desc = "Toggle Flash Search",
		},
	},
}
