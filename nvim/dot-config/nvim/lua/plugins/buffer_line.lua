---
--- See - https://github.com/akinsho/bufferline.nvim/blob/main/doc/bufferline.txt

return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	version = "*",
	config = function()
		local status_ok, bufferline = pcall(require, "bufferline")
		if not status_ok then
			return
		end
		vim.opt.termguicolors = true

		function _G.bdel(num)
			bufferline.exec(num, function(buf, visible_buffers)
				vim.cmd("bdelete " .. buf.id)
			end)
		end

		bufferline.setup({
			options = {
				mode = "buffers",
				separator_style = "slant",
				themable = true,
				offsets = {
					{
						filetype = "NvimTree",
						text = function()
							return vim.fn.getcwd()
						end,
						highlight = "Directory",
						separator = true, -- use a "true" to enable the default, or set your own character
					},
				},
				diagnostics = "nvim_lsp",
				diagnostics_indicator = function(count, level)
					local icon = level:match("error") and " " or " "
					return " " .. icon .. count
				end,
			},
		})

		vim.keymap.set("n", "<Tab>bp", "<CMD>BufferLinePick<CR>")
		vim.keymap.set("n", "<leader>bx", "<CMD>BufferLinePickClose<CR>")
		vim.keymap.set("n", "<S-l>", "<CMD>BufferLineCycleNext<CR>")
		vim.keymap.set("n", "<S-h>", "<CMD>BufferLineCyclePrev<CR>")
		vim.keymap.set("n", "]b", "<CMD>BufferLineMoveNext<CR>", { desc = "Next Buffer" })
		vim.keymap.set("n", "[b", "<CMD>BufferLineMovePrev<CR>", { desc = "Previous Buffer" })
		vim.keymap.set("n", "gs", "<CMD>BufferLineSortByDirectory<CR>")
	end,
}
