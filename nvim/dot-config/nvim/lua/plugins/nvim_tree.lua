--

return {
	"nvim-tree/nvim-tree.lua",
	dependencies = "nvim-tree/nvim-web-devicons",
	lazy = false,
	config = function()
		local nvimtree = require("nvim-tree")

		-- recommended settings from nvim-tree documentation
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		vim.keymap.set("n", "<Right>", "<Down>")

		nvimtree.setup({
			disable_netrw = true,
			hijack_netrw = true,
			hijack_cursor = true,
			hijack_unnamed_buffer_when_opening = false,
			sync_root_with_cwd = true,
			-- on_attach = require('on_attach'),
			update_focused_file = {
				enable = true,
				update_root = false,
			},
			view = {
				width = 30,
				relativenumber = false,
				number = false,
				adaptive_size = false,
				side = "left",
				preserve_window_proportions = true,
			},
			-- change folder arrow icons
			renderer = {
				root_folder_label = false,
				highlight_git = false,
				highlight_opened_files = "none",

				indent_markers = {
					enable = true,
				},
				icons = {
					glyphs = {
						default = "󰈚",
						symlink = "",
						folder = {
							default = "",
							empty = "",
							empty_open = "",
							open = "",
							symlink = "",
							symlink_open = "",

							-- arrow_closed = "", -- arrow when folder is closed
							-- arrow_open = "", -- arrow when folder is open

							arrow_open = "",
							arrow_closed = "",
						},

						git = {
							unstaged = "✗",
							staged = "✓",
							unmerged = "",
							renamed = "➜",
							untracked = "★",
							deleted = "",
							ignored = "◌",
						},
					},
				},
			},
			-- disable window_picker for
			-- explorer to work well with
			-- window splits
			actions = {
				open_file = {
					window_picker = {
						enable = false,
					},
				},
			},
			filters = {
				custom = { ".DS_Store" },
			},
			git = {
				enable = true,
				ignore = false,
			},
		})

		-- set keymaps
		local keymap = vim.keymap

		keymap.set("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
		keymap.set("n", "<leader>et", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
		keymap.set("n", "<leader>ee", function()
			if vim.fn.bufname():match("NvimTree_") then
				vim.cmd("wincmd p")
			else
				vim.cmd("NvimTreeFocus")
				-- vim.cmd("NvimTreeFindFileToggle")
			end
		end, { desc = "Focus on file explorer" }) -- toggle file explorer
		keymap.set(
			"n",
			"<leader>ef",
			"<cmd>NvimTreeFindFileToggle<CR>",
			{ desc = "Toggle file explorer on current file" }
		) -- toggle file explorer on current file
		keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
		keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) -- refresh file explorer
		keymap.set("n", "<leader><Right>", "<cmd>wincmd w<CR>", { desc = "Move focus to buffer" }) -- refresh file explorer
		keymap.set("n", "<leader>eu", "<cmd>wincmd w<CR>", { desc = "[M]ove [F]ocus to buffer" }) -- refresh file explorer
	end,
}
