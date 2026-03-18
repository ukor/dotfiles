return {
	"christoomey/vim-tmux-navigator",
	cmd = {
		"TmuxNavigateLeft",
		"TmuxNavigateDown",
		"TmuxNavigateUp",
		"TmuxNavigateRight",
		"TmuxNavigatePrevious",
	},
	keys = {

		-- How this works
		-- The Logic: When Ctrl-h is pressed, Neovim checks if there is a split to the left.

		-- If yes: It moves to that Neovim split.

		-- If no: It sends a command to tmux (using the script logic in your tmux.conf) to move to the tmux pane on the left.

		-- Helps navigate across multiple Neovim instances and tmux panes without thinking about which "layer" I am in.
		-- THIS IS EXPERIMENTAL and might be removed
		--
		{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
		{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
		{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
		{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
		{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
	},
}
