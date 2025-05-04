-- Key mappings for when LSP has been attached

local M = {}

M.map_keys = function(buf)
	---
	-- defines mappings specific for LSP related items.
	-- It sets the mode, buffer and description for us each time.
	local map = function(keys, func, desc, mode)
		mode = mode or "n"
		desc = desc or " "
		vim.keymap.set(mode, keys, func, { buffer = buf, desc = "LSP: " .. desc })
	end

	local telescope = require("telescope.builtin")

	map("K", "<cmd>lua vim.lsp.buf.hover()<cr>", "", "n")

	map("gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Signature", "n")

	map("<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", "format", "n")

	--- comment
	map(
		"<leader>/",
		"<ESC><cmd>lua require('Comment.api').toggle.linewise.current()<CR>",
		"Toggle comment in Normal mode"
	)

	map(
		"<leader>/",
		"<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
		"Toggle comment in visual mode",
		"v"
	)

	--- end comment

	--- Nvim tree

	map("<C-n>", "<cmd> NvimTreeToggle <CR>", "Toggle File exploral")

	--- End NvimTree

	-- Rename the variable under your cursor.
	--  Most Language Servers support renaming across files, etc.
	map("grn", vim.lsp.buf.rename, "[R]e[n]ame")
	map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame fields")
	map("<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename", "n")

	--------------------
	--- Code action ---
	--------------------
	-- Execute a code action, usually your cursor needs to be on top of an error
	-- or a suggestion from your LSP for this to activate.
	map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })
	map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction in visual mode", "v")

	map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
	map("<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", "[C]ode [A]ction", "n")

	--- End code action

	-- Find references for the word under your cursor.
	map("grr", telescope.lsp_references, "[G]oto [R]eferences")
	map("gr", "<cmd>lua vim.lsp.buf.references()<cr>", "Goto references", "n")

	-- Jump to the implementation of the word under your cursor.
	--  Useful when your language has ways of declaring types without an actual implementation.
	map("gri", telescope.lsp_implementations, "[G]oto [I]mplementation")
	map("gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", "goto implementation", "n")

	-- Jump to the definition of the word under your cursor.
	--  This is where a variable was first declared, or where a function is defined, etc.
	--  To jump back, press <C-t>.
	map("grd", telescope.lsp_definitions, "[G]oto [D]efinition")
	map("go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", "Goto type defination", "n")
	map("gd", "<cmd>lua vim.lsp.buf.definition()<cr>", "", "n")

	-- WARN: This is not Goto Definition, this is Goto Declaration.
	--  For example, in C this would take you to the header.
	map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

	-- Fuzzy find all the symbols in your current document.
	--  Symbols are things like variables, functions, types, etc.
	map("gO", telescope.lsp_document_symbols, "Open Document Symbols")

	-- Fuzzy find all the symbols in your current workspace.
	--  Similar to document symbols, except searches over your entire project.
	map("gW", telescope.lsp_dynamic_workspace_symbols, "Open Workspace Symbols")

	-- Jump to the type of the word under your cursor.
	--  Useful when you're not sure what type a variable is and you want to see
	--  the definition of its *type*, not where it was *defined*.
	map("grt", telescope.lsp_type_definitions, "[G]oto [T]ype Definition")

	-- Lesser used LSP functionality
	map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
	map("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
	map("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
	map("<leader>wl", function()
		print(vim.inspect(vlb.list_workspace_folders()))
	end, "[W]orkspace [L]ist Folders")

	--- Diagnostic
	map("<leader>dn", vim.diagnostic.goto_next, "Goto [D]iagnostic [N]ext message")
	map("<leader>dp", vim.diagnostic.goto_prev, "Goto [D]iagnostic [P]revious message")
	map("<leader>dl", "<cmd>Telescope diagnostics<cr>", "[D]iagnostic [L]ist message")

	--- utils mapping ---

	map("nj", "o<Esc>jk", "Create new line below current line without entering insert mode")

	map("nk", "O<Esc>kj", "Create new line above current line without entering insert mode")

	map("gd", "<cmd>Telescope lsp_definitions<cr>", "[G]oto [D]efinition")
	map("<leader>gd", "<cmd>Telescope lsp_definitions<cr>", "[G]oto [D]efinition Telescope")
	--

	map("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
	map("<leader>ds", telescope.lsp_document_symbols, "[D]ocument [S]ymbols")
	map("<leader>ws", telescope.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

	-- See `:help K` for why this keymap
	map("K", vim.lsp.buf.hover, "Hover Documentation")
	map("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
end

return M
