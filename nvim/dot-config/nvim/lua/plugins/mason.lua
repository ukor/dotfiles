return {
	"mason-org/mason.nvim",
	dependencies = {
		{ "mason-org/mason-lspconfig.nvim" },
		{ "WhoIsSethDaniel/mason-tool-installer.nvim" },
		{ "j-hui/fidget.nvim", tag = "v1.6.1" },
	},
	opts = {
		ensure_installed = {}, -- You can add "base" tools here if you like
	},
	config = function(_, opts)
		require("configs.mason").setup(opts)
	end,
}
