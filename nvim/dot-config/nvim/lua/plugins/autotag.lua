return {

	"windwp/nvim-ts-autotag",
	dependencies = { "nvim-treesitter/nvim-treesitter" },

	version = "*",
	event = { "BufReadPre", "BufNewFile" },

	config = function()
		require("nvim-ts-autotag").setup({
			opts = {
				-- Defaults are usually fine, but you can override them here
				enable_close = true, -- Auto close tags
				enable_rename = true, -- Auto rename pairs of tags
				enable_close_on_slash = false, -- Auto close on trailing </
			},
			-- Also valid to add per-filetype overrides here if needed
			-- per_filetype = {
			--   ["html"] = { enable_close = false }
			-- }
		})
	end,
}
