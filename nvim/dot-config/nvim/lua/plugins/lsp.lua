return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		---

		local lspconfig = require("lspconfig")

		-- local mason_lspconfig = require("mason-lspconfig")

		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local on_attach = require("on_attach")

		require("core.lsp_attach")

		require("core.lsp_diagnostic")

		-- used to enable autocompletion (assign to every lsp server config)
		-- LSP servers and clients are able to communicate to each other what features they support.
		--  By default, Neovim doesn't support everything that is in the LSP specification.
		--  When you add blink.cmp, luasnip, etc. Neovim now has *more* capabilities.
		--  So, we create new capabilities with cmp_nvim_lsp, and then broadcast that to the servers.
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Change the Diagnostic symbols in the sign column (gutter)
		-- (not in youtube nvim video)
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

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

		vim.lsp.config("ts_ls", require("configs.lsp.javascript"))
		vim.lsp.enable("ts_ls")

		-- See https://docs.deno.com/runtime/manual/getting_started/setup_your_environment
		-- lspconfig.denols.setup({
		-- 	on_attach = on_attach,
		-- 	root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
		-- })

		-- BiomeJs https://biomejs.dev
		-- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/biome.lua#L4
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

		-- mason_lspconfig.setup_handlers({
		-- 	-- default handler for installed servers
		-- 	function(server_name)
		-- 		lspconfig[server_name].setup({
		-- 			capabilities = capabilities,
		-- 			-- on_attach = on_attach,
		-- 		})
		-- 	end,
		-- 	["emmet_ls"] = function()
		-- 		-- configure emmet language server
		-- 		lspconfig["emmet_ls"].setup({
		-- 			capabilities = capabilities,
		-- 			filetypes = {
		-- 				"html",
		-- 				"typescriptreact",
		-- 				"javascriptreact",
		-- 				"css",
		-- 				"sass",
		-- 				"scss",
		-- 				"less",
		-- 				"svelte",
		-- 			},
		-- 		})
		-- 	end,
		-- })
	end,
}
