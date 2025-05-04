--

vim.cmd([[
  augroup _general_settings
    autocmd!

    " Maps 'q' to close quickfix, help, man-page and trouble
    autocmd FileType qf,help,man,lspinfo,trouble nnoremap <silent> <buffer> q :close<CR> 

    " Highlights search when copy/yanked
    " autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Search', timeout = 200}) 

    " Gives more manual control over comment 
    " It prevents start a new line with comment when the previous line is a comment
    " autocmd BufWinEnter * :set formatoptions-=cro

    " Hides quickfix buffers from the buffer list
    autocmd BufWinEnter *.* normal zR

  augroup end

  augroup _language_settings

    " since there is no formatter for svg, we map svg to html
    au BufReadPost *.svg set filetype=html
    au BufReadPost *.json set filetype=jsonc
    au BufReadPost package.json set filetype=json
    au BufReadPost */php/*.conf set filetype=dosini
    au BufReadPost *.env* set filetype=sh
    au BufReadPost *.hurl set filetype=hurl
  augroup end
]])

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd("BufEnter", {
	desc = "On enter buffer",
	group = vim.api.nvim_create_augroup("enter-buffer", { clear = true }),
	callback = function()
		local bufs = #vim.api.nvim_list_bufs()
		-- vim.print(bufs)
		-- vim.print("Number of open buffers from e:", bufs)
		local current_buf_number = vim.api.nvim_get_current_buf()
		-- vim.print(current_buf_number)
		-- vim.print(vim.api.nvim_buf_get_name(current_buf_number), " from e:", bufs)

		vim.keymap.set("n", "<leader>x", function()
			vim.cmd("bd")
			vim.cmd("bprevious")
		end, { desc = "[C]lose [B]uffer" })

		vim.keymap.set("n", "<Tab>", function()
			vim.cmd("bnext")
		end, { desc = "Next Buffer" })

		vim.keymap.set("n", "<S-Tab>", function()
			vim.cmd("bprevious")
		end, { desc = "Next Buffer" })
	end,
})

-- Open dashboard when all buffer has been closed
vim.api.nvim_create_autocmd("BufDelete", {
	callback = function()
		local bufs = vim.api.nvim_list_bufs()
		-- local current_buf_number = vim.api.nvim_get_current_buf()
		-- vim.print(current_buf_number)
		-- vim.print(vim.api.nvim_buf_get_name(current_buf_number), " from d:", bufs)

		-- vim.print(bufs)
		if #bufs == 1 and vim.api.nvim_buf_get_name(bufs[1]) == "" then
			-- require("alpha").start()
		end
	end,
})
