return {
	"numToStr/Comment.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	config = function()
		-- import comment plugin safely
		local comment = require("Comment")

		local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")

		-- enable comment
		comment.setup({
			padding = true,
			sticky = true,
			ignore = function()
				-- Only ignore empty lines for lua files
				if vim.bo.filetype == "lua" then
					return "^$"
				end
			end,
			toggler = {
				block = "gbc",
				line = "gcc",
			},
			opleader = {
				line = "gc",
				block = "gb",
			},
			extra = {
				---Add comment on the line above
				above = "gcO",
				---Add comment on the line below
				below = "gco",
				---Add comment at the end of line
				eol = "gcA",
			},
			mappings = {
				---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
				basic = true,
				---Extra mapping; `gco`, `gcO`, `gcA`
				extra = true,
			},
			---Function to call before (un)comment
			-- pre_hook = nil,
			---Function to call after (un)comment
			post_hook = function(ctx)
				if ctx.range.srow == ctx.range.erow then
				-- do something with the current line
				else
					-- do something with lines range
				end
			end,
			-- for commenting tsx, jsx, svelte, html files
			pre_hook = ts_context_commentstring.create_pre_hook(),
		})
	end,
}
