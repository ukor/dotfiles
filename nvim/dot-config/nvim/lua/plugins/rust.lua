return {
	"mrcjkb/rustaceanvim",
	version = "^6", -- Recommended
	lazy = false, -- This plugin is already lazy
	ft = { "rust" },

	opts = {
		server = {
			on_attach = function(_, bufnr)
				require("core.lsp_attach")

				vim.keymap.set("n", "<leader>cR", function()
					vim.cmd.RustLsp("codeAction")
				end, { desc = "Code Action", buffer = bufnr })
				vim.keymap.set("n", "<leader>dr", function()
					vim.cmd.RustLsp("debuggables")
				end, { desc = "Rust Debuggables", buffer = bufnr })
			end,
			default_settings = {
				-- rust-analyzer language server configuration
				["rust-analyzer"] = {
					cargo = {
						allFeatures = true,
						loadOutDirsFromCheck = true,
						buildScripts = {
							enable = true,
						},
					},
					-- Add clippy lints for Rust if using rust-analyzer
					checkOnSave = diagnostics == "rust-analyzer",
					-- Enable diagnostics if using rust-analyzer
					diagnostics = {
						enable = diagnostics == "rust-analyzer",
					},
					procMacro = {
						enable = true,
						ignored = {
							["async-trait"] = { "async_trait" },
							["napi-derive"] = { "napi" },
							["async-recursion"] = { "async_recursion" },
						},
					},
					files = {
						excludeDirs = {
							".direnv",
							".git",
							".github",
							".gitlab",
							"bin",
							"node_modules",
							"target",
							"venv",
							".venv",
						},
					},
				},
			},
		},
	},

	config = function(_, opts)
		local package_path = vim.fn.exepath("codelldb")

		-- print(package_path)
		-- vim.notify(package_path, vim.log.levels.INFO)
		--
		local codelldb = package_path .. "/extension/adapter/codelldb"
		local library_path = package_path .. "/extension/lldb/lib/liblldb.dylib"
		local uname = io.popen("uname"):read("*l")
		if uname == "Linux" then
			library_path = package_path .. "/extension/lldb/lib/liblldb.so"
		end
		opts.dap = {
			adapter = require("rustaceanvim.config").get_codelldb_adapter(codelldb, library_path),
		}

		vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts or {})
		if vim.fn.executable("rust-analyzer") == 0 then
			vim.notify(
				"**rust-analyzer** not found in PATH, please install it.\nhttps://rust-analyzer.github.io/",
				vim.log.levels.ERROR
			)
			vim.health.error(
				"**rust-analyzer** not found in PATH, please install it.\nhttps://rust-analyzer.github.io/",
				{ title = "rustaceanvim" }
			)
		end
	end,
}
