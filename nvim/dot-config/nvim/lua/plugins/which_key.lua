return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    -- This is also set on the lua/core/set_vim
    vim.o.timeoutlen = 500
  end,
  opts = {},
}
