return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
		"folke/todo-comments.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		local builtin = require("telescope.builtin")

		telescope.setup({
			defaults = {
				vimgrep_arguments = {
					"rg",
					"-L",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
				},
				path_display = { "smart" },
				prompt_prefix = "   ",
				file_ignore_patterns = { "node_modules" },

				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					},
				},
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
					},
				},
			},
		})

		telescope.load_extension("fzf")

		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "<leader>sb", builtin.buffers, { desc = "[S]earch for opened [B]uffers - Same as <leader-sr>" })
		keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp - Telescope Help" })

		keymap.set(
			"n",
			"<leader>sf",
			"<cmd>Telescope find_files<cr>",
			{ desc = "[S]earch for files in CWD - Fuzzy find files in cwd" }
		)
		keymap.set(
			"n",
			"<leader>sr",
			"<cmd>Telescope oldfiles<cr>",
			{ desc = "Search for opened buffer - Fuzzy find recent files" }
		)

		keymap.set("n", "<leader>sw", "<cmd>Telescope live_grep<cr>", { desc = "[S]earch for [W]ord in CWD" })

		keymap.set(
			"n",
			"<leader>ss",
			"<cmd>Telescope grep_string<cr>",
			{ desc = "[S]earch for [S]tring user in the cursor in CWD" }
		)
	end,
}
