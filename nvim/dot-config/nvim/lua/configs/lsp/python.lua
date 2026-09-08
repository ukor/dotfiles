local function set_python_path(command)
	local path = command.args
	local clients = vim.lsp.get_clients({
		bufnr = vim.api.nvim_get_current_buf(),
		name = "pyright",
	})
	for _, client in ipairs(clients) do
		if client.settings then
			client.settings.python =
				vim.tbl_deep_extend("force", client.settings.python --[[@as table]], { pythonPath = path })
		else
			client.config.settings =
				vim.tbl_deep_extend("force", client.config.settings, { python = { pythonPath = path } })
		end
		client:notify("workspace/didChangeConfiguration", { settings = client.config.settings })
	end
end

return function(capabilities)
	-- Detect active virtual environment or fallback to system python
	local venv = os.getenv("VIRTUAL_ENV")
	local python_path = venv and venv .. "/bin/python" or vim.fn.exepath("python")

	return {
		capabilities = capabilities, -- Injected from the main lsp.lua
		init_options = {
			hostInfo = "neovim",
		},
		cmd = { "pyright-langserver", "--stdio" },
		filetypes = {
			"python",
			"python.py",
		},
		root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "Pipfile", "pyrightconfig.json", ".git" },

		on_attach = function(client, bufnr)
			--
			require("core.lsp_attach")

			vim.api.nvim_buf_create_user_command(bufnr, "LspPyrightOrganizeImports", function()
				local params = {
					command = "pyright.organizeimports",
					arguments = { vim.uri_from_bufnr(bufnr) },
				}

				-- Using client.request() directly because "pyright.organizeimports" is private
				-- (not advertised via capabilities), which client:exec_cmd() refuses to call.
				-- https://github.com/neovim/neovim/blob/c333d64663d3b6e0dd9aa440e433d346af4a3d81/runtime/lua/vim/lsp/client.lua#L1024-L1030
				---@diagnostic disable-next-line: param-type-mismatch
				client.request("workspace/executeCommand", params, nil, bufnr)
			end, {
				desc = "Organize Imports",
			})
			vim.api.nvim_buf_create_user_command(bufnr, "LspPyrightSetPythonPath", set_python_path, {
				desc = "Reconfigure pyright with the provided python path",
				nargs = 1,
				complete = "file",
			})
		end,
		settings = {
			pyright = {
				disableTaggedHints = true,
			},
			python = {
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				diagnosticMode = "openFilesOnly",
				typeCheckingMode = "standard",
			},
		},
		docs = {
			description = [[ https://github.com/microsoft/pyright ]],
		},
	}
end
