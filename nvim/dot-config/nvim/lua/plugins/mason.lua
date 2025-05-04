return {
	"williamboman/mason.nvim",
	dependencies = {
		{ "williamboman/mason-lspconfig.nvim" },
	},
	config = function()
		local mason = require("mason")

		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},

				keymaps = {
					toggle_server_expand = "<CR>",
					install_server = "i",
					update_server = "u",
					check_server_version = "c",
					update_all_servers = "U",
					check_outdated_servers = "C",
					uninstall_server = "X",
					cancel_installation = "<C-c>",
				},
			},
		})

		local mason_lspconfig = require("mason-lspconfig")

		local default_lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

		mason_lspconfig.setup({
			-- Replace the language servers listed here
			-- with the ones you want to install
			ensure_installed = { "lua_ls", "ts_ls", "gopls", "ansiblels", "yamlls", "ruff", "sqls", "grammarly" },
			automatic_installation = true,
			-- default handler
			-- it applies to every language server without a custom handler
			handlers = {
				function(server_name)
					require("lspconfig")[server_name].setup({
						capabilities = default_lsp_capabilities,
					})
				end,
			},
		})
	end,
}
