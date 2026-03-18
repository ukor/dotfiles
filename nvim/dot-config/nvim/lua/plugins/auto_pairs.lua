return {
	"windwp/nvim-autopairs",
	event = { "InsertEnter" },
	dependencies = {
		"hrsh7th/nvim-cmp",
		"windwp/nvim-ts-autotag",
	},
	config = function()
		-- import nvim-autopairs
		local Rule = require("nvim-autopairs.rule")
		local autopairs = require("nvim-autopairs")
		local cond = require("nvim-autopairs.conds")

		-- configure autopairs
		autopairs.setup({
			check_ts = true, -- enable treesitter
			ts_config = {
				lua = { "string" }, -- don't add pairs in lua string treesitter nodes
				javascript = { "template_string" }, -- don't add pairs in javscript template_string treesitter nodes
				java = false, -- don't check treesitter on java
				go = { "string" },
			},
		})

		-- 1. Custom Rule for Go: Space after dynamic brackets
		-- Useful for: map[string]interface{ | }
		autopairs.add_rules({
			Rule(" ", " ")
				:with_pair(function(opts)
					local pair = opts.line:sub(opts.col - 1, opts.col)
					return vim.tbl_contains({ "{}", "[]", "()" }, pair)
				end)
				:with_move(cond.none())
				:with_cr(cond.none())
				:with_del(function(opts)
					local col = vim.api.nvim_win_get_cursor(0)[2]
					local context = opts.line:sub(col - 1, col + 2)
					return vim.tbl_contains({ "{  }", "[  ]", "(  )" }, context)
				end),
		})

		-- 2. Custom Rule for SQL: Disable pairs for backticks
		-- Since you use PostgreSQL, you likely use double quotes for identifiers
		autopairs.get_rules("`")[1].not_filetypes = { "sql", "mysql" }

		-- 3. Go: Backticks (for struct tags)
		-- This makes it easier to type: `json:"id"`
		autopairs.add_rules({
			Rule("`", "`", "go"),
		})

		-- import nvim-autopairs completion functionality
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")

		-- import nvim-cmp plugin (completions plugin)
		local cmp = require("cmp")

		-- make autopairs and completion work together
		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

		-- for react project
		require("nvim-ts-autotag").setup()
	end,
}
