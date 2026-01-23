return {
  "echasnovski/mini.comment",
  version = false, -- Use latest version
  config = function()
    require("mini.comment").setup({
      -- Options with defaults
      options = {
        -- Whether to ignore blank lines
        ignore_blank_line = false,
        -- Whether to recognize as comment only lines without indent
        start_of_line = false,
        -- Whether to ensure single space pad for comment parts
        pad_comment_parts = true,
      },
      -- Module mappings. Use `''` (empty string) to disable one.
      mappings = {
        -- Toggle comment (like `gcip` - comment inner paragraph)
        comment = "gc",
        -- Toggle comment on current line
        comment_line = "gcc",
        -- Define 'comment' textobject (like `dgc` - delete comment)
        textobject = "gc",
      },
    })
  end,
}
