return {
  "braxtons12/blame_line.nvim",
  lazy = false,
  config = function()
    require("blame_line").setup {
      show_in_visual = true,
      show_in_insert = true,
      template = "<author> • <author-time> • <summary>",
      delay = 0,
      date = {
        -- whether the date should be relative instead of precise
        -- (I.E. "3 days ago" instead of "09-06-2022".
        relative = true,

        -- `strftime` compatible format string.
        -- Only used if `date.relative == false`
        format = "%d-%m-%y",
      },
    }
  end,
}
