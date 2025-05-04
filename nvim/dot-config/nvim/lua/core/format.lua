vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(event)
		local opts = { buffer = event.buf }

		vim.keymap.set({ "n", "x" }, "gq", function()
			vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
		end, opts)
	end,
})
