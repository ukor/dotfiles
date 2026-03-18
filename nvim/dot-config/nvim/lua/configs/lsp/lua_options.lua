return function(capabilities)
	return {
		capabilities = capabilities,
		on_init = function(client)
			if client.workspace_folders then
				local path = client.workspace_folders[1].name
				if
					path ~= vim.fn.stdpath("config")
					and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
				then
					return
				end
			end

			client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
				diagnostics = {
					globals = { "vim" },
				},
				runtime = {
					version = "LuaJIT",
					path = {
						"lua/?.lua",
						"lua/?/init.lua",
					},
				},
				-- Make the server aware of Neovim runtime files
				workspace = {
					checkThirdParty = false,
					preloadFileSize = 10000,
					library = {
						vim.env.VIMRUNTIME,
					},
				},
			})
		end,
		settings = {
			Lua = {},
		},
	}
end
