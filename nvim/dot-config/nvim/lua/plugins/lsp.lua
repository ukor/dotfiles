return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },

		{ "williamboman/mason.nvim", opts = {} },
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",

		-- Useful status updates for LSP.
		{ "j-hui/fidget.nvim", opts = {} },
	},
	config = function()
		---

		local lspconfig = require("lspconfig")

		-- local mason_lspconfig = require("mason-lspconfig")

		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		-- local on_attach = require("on_attach")

		require("core.lsp_attach")

		require("core.lsp_diagnostic")

		-- Change the Diagnostic symbols in the sign column (gutter)
		-- (not in youtube nvim video)
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		-- used to enable autocompletion (assign to every lsp server config)
		-- LSP servers and clients are able to communicate to each other what features they support.
		-- By default, Neovim doesn't support everything that is in the LSP specification.
		-- When you add blink.cmp, luasnip, etc. Neovim now has *more* capabilities.
		-- So, we create new capabilities with cmp_nvim_lsp, and then broadcast that to the servers.

		local vim_lsp_capabilities = vim.lsp.protocol.make_client_capabilities()

		-- local blink_cmp_capabilities = require("blink.cmp").get_lsp_capabilities(vim_lsp_capabilities)

		local cmp_lsp_capabilities = cmp_nvim_lsp.default_capabilities()
		local capabilities = vim.tbl_deep_extend("force", vim_lsp_capabilities, cmp_lsp_capabilities)

		------------------------------------------------------------------
		------------------------------------------------------------------
		---- LSP installation is done on the Mason configuration side ----
		------------------------------------------------------------------
		------------------------------------------------------------------

		---- Server configuration are manual done by me,
		--- no need for mason_lspconfig

		-- local mason_lspconfig = require("mason-lspconfig")

		-- mason_lspconfig.setup({
		-- 	ensure_installed = {},
		-- 	automatic_installation = false,
		-- 	handlers = {
		-- 		function(server_name)
		-- 			require("lspconfig")[server_name].setup({
		-- 				capabilities = default_lsp_capabilities,
		-- 			})
		-- 		end,
		-- 	},
		-- })

		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			settings = {
				Lua = {
					runtime = {
						version = "LuaJIT",
					},
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						library = {
							vim.env.VIMRUNTIME,
						},
					},
				},
			},
		})

		local javascript_config =
			vim.tbl_deep_extend("force", { capabilities = capabilities }, require("configs.lsp.javascript"))
		vim.lsp.config("ts_ls", javascript_config)
		vim.lsp.enable("ts_ls")

		local go_config = vim.tbl_deep_extend("force", { capabilities = capabilities }, require("configs.lsp.go"))
		vim.lsp.config("gopls", go_config)
		vim.lsp.enable("gopls")

		lspconfig.biome.setup({

			cmd = { "biome" },
			filetypes = { "typescript", "typescriptreact", "typescript.tsx", "json" },
			root_dir = lspconfig.util.root_pattern(
				"biome.json",
				"tsconfig.json",
				"jsconfig.json",
				"package.json",
				".git"
			),
			single_file_support = false,
		})

		--
	end,
}
