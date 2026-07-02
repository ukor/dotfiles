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

		keymap.set("n", "<leader>fb", builtin.buffers, { desc = "[F]ind opened [B]uffers - Same as <leader-fr>" })
		keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[F]ind [H]elp - Telescope Help" })

		keymap.set(
			"n",
			"<leader>ff",
			"<cmd>Telescope find_files<cr>",
			{ desc = "[S]earch for files in CWD - Fuzzy find files in cwd" }
		)
		keymap.set(
			"n",
			"<leader>fr",
			"<cmd>Telescope oldfiles<cr>",
			{ desc = "Find opened buffer - Fuzzy find recent files" }
		)

		keymap.set("n", "<leader>fw", "<cmd>Telescope live_grep<cr>", { desc = "[F]ind for [W]ord in CWD" })

		keymap.set(
			"n",
			"<leader>fs",
			"<cmd>Telescope grep_string<cr>",
			{ desc = "[S]earch for [S]tring user in the cursor in CWD" }
		)
	end,
}
