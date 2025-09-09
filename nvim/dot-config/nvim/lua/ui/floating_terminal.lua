-- floating_window.lua

local state = {

	floating = {
		buf = -1,
		win = -1,
	},
}

-- A function to create a floating terminal
--
-- @param opts table A table of options to configure the window.
--   - opts.height (number, optional): The height of the window.
--   - opts.width (number, optional): The width of the window.
--
-- The function will default to 80% of the current window's size if
-- height or width are not provided. The window is always centered.

local function create_floating_terminal(opts)
	opts = opts or {}

	-- Get the current window dimensions.
	local win_height = vim.api.nvim_win_get_height(0)
	local win_width = vim.api.nvim_win_get_width(0)

	-- Calculate the height and width of the floating window.
	-- Default to 80% of the current window's dimensions if not provided.
	local float_height = opts.height or math.floor(win_height * 0.8)
	local float_width = opts.width or math.floor(win_width * 0.8)

	-- Calculate the row and column to center the floating window.
	local float_row = math.floor((win_height - float_height) / 2)
	local float_col = math.floor((win_width - float_width) / 2)

	-- Create a new scratch buffer for the window content.
	local buf = nil
	if vim.api.nvim_buf_is_valid(opts.buf) then
		buf = opts.buf
	else
		buf = vim.api.nvim_create_buf(false, true)
	end

	-- Define the options for the floating window.
	local win_options = {
		relative = "editor",
		row = float_row,
		col = float_col,
		width = float_width,
		height = float_height,
		style = "minimal",
		border = "rounded",
		-- This ensures the floating window can be closed by pressing 'q'.
		focusable = true,
		noautocmd = true,
		zindex = 100,
	}

	-- Open the floating window.
	local win = vim.api.nvim_open_win(buf, true, win_options)

	-- Set keymaps for closing the window.
	vim.api.nvim_buf_set_keymap(buf, "n", "q", ":close<CR>", { noremap = true, silent = true })
	vim.api.nvim_buf_set_keymap(buf, "i", "<esc>", "<C-o>:close<CR>", { noremap = true, silent = true })

	return { buf = buf, win = win }
end

-- Create a command to open the window
vim.api.nvim_create_user_command("OpenFloatingTerminal", function()
	if not vim.api.nvim_win_is_valid(state.floating.win) then
		--
		state.floating = create_floating_terminal({ buf = state.floating.buf })

		if vim.bo[state.floating.buf].buftype ~= "terminal" then
			vim.cmd.terminal()
		end
	else
		vim.api.nvim_win_hide(state.floating.win)
	end
	print(vim.inspect(state.floating))
end, {})

-- Create a keymap to open the terminal
vim.keymap.set("n", "<leader>wf", ":OpenFloatingTerminal<CR>", { desc = "Open floating window" })
vim.keymap.set("n", "<leader>tf", ":OpenFloatingTerminal<CR>", { desc = "Open floating window" })
