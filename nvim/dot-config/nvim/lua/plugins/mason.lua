return {
	"mason-org/mason.nvim",
	dependencies = {
		{ "mason-org/mason-lspconfig.nvim" },
		{ "WhoIsSethDaniel/mason-tool-installer.nvim" },
		{ "j-hui/fidget.nvim", tag = "v1.6.1" },
	},
	config = function(_, opts)
		local mason = require("mason")

		opts.ensure_installed = opts.ensure_installed or {}

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

		local mason_tool_installer = require("mason-tool-installer")

		local ensure_installed = vim.list_extend(opts.ensure_installed, {
			{ "bash-language-server", auto_update = true },
			"shellcheck",
			"lua_ls",
			"stylua",
			{ "ts_ls", auto_update = true },
			"bashls",
			{ "gopls", auto_update = true },
			"ansiblels",
			"jsonls",
			"jsonlint",
			"yamlls",
			"ruff",
			"sqls",
			"prettier",
			"biome",
			"prettierd",
			"editorconfig-checker",
			"gofumpt",
			"golines",
			"gomodifytags",
			"gotests",
			"rust-analyzer",
			"codelldb",
		})

		mason_tool_installer.setup({
			ensure_installed = ensure_installed,
			auto_update = false,
			run_on_start = true,
			start_delay = 3000, -- 3 second delay
			debounce_hours = 1, -- at least 1 hours between attempts to install/update
		})
	end,
}
