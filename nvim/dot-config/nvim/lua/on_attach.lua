-- [[ Custom LSP configuration ]]
--

-- This function gets run when an LSP connects to a particular buffer.
-- It allows easily mappings for LSP related items.
-- It sets the mode, buffer and description for us each time.

local on_attach = function(client, bufnr)
	--

	client.server_capabilities.documentFormattingProvider = false
	client.server_capabilities.documentRangeFormattingProvider = false

	require("core.lsp_key_map").map_keys(bufnr)

	-- Create a command `:Format` local to the LSP buffer
	vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
		vlb.format()
	end, { desc = "Format current buffer with LSP" })

	--
	-- Formating on save
	-- [See Documentation](https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Formatting-on-save)
	--
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format({
					bufnr = bufnr,
					-- end,
				})
			end,
		})
	end
	--
	--
end

return on_attach
