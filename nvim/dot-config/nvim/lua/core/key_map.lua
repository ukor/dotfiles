-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`

-----------
-- Setup --
-----------

local opts = {
	noremap = true, -- https://stackoverflow.com/questions/3776117/what-is-the-difference-between-the-remap-noremap-nnoremap-and-vnoremap-mapping
	-- silent = true, -- To define a mapping which will not be echoed on the command line (ref :h map-silent)
}

local keymap = vim.keymap.set

-- Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Maps ; key to command mode
keymap("n", ";", ":")

-- disable arrow keys for normal mode and insert mode
-- keymap("n", "<Up>", "<NOP>", opts)
-- keymap("n", "<Down>", "<NOP>", opts)
-- keymap("n", "<Left>", "<NOP>", opts)
-- keymap("n", "<Right>", "<NOP>", opts)
-- keymap("i", "<Up>", "<NOP>", opts)
-- keymap("i", "<Down>", "<NOP>", opts)
-- keymap("i", "<Left>", "<NOP>", opts)
-- keymap("i", "<Right>", "<NOP>", opts)

------------
-- Normal --
------------

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<A-Up>", ":resize -2<CR>", opts)
keymap("n", "<A-Down>", ":resize +2<CR>", opts)
keymap("n", "<A-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<A-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Move text up and down
keymap("n", "˚", ":m-2<CR>==", opts) -- on Mac <A-k> is ˚
keymap("n", "∆", ":m+1<CR>==", opts) -- on Mac <A-j> is ∆

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "<leader>di", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })

vim.keymap.set("n", "<cmd>vs", "<cmd>vsplit<cr>", { desc = "Split screen vertically" })
vim.keymap.set("n", "<cmd>hs", "<cmd>hsplit<cr>", { desc = "Split screen horizontally" })

-- Overides opening defination list in Quick fix list --
vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<cr>", { desc = "Open defination list in telescope" })

-- vim.keymap.set("i", "<leader><C>", "<Esc>")

vim.keymap.set("i", "kj", "<Esc>")

vim.keymap.set("i", "<cmd>cc", "<Esc>o", { desc = "Carriage, go to next line" })

vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver15,r-cr-o:hor20"

vim.o.cursorlineopt = "both"

---

-- note: diagnostics are not exclusive to lsp servers
-- so these can be global keybindings
vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>")
vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>")
vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>")

---
