return {
  "lewis6991/gitsigns.nvim",
  config = function()
    require("gitsigns").setup({
      current_line_blame = true,  -- Show blame on current line
      current_line_blame_opts = {
        delay = 300,  -- Delay before showing blame (ms)
        virt_text_pos = "eol",  -- Show at end of line
      },
      current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
    })

    -- Keymaps
    local keymap = vim.keymap.set
    keymap("n", "<leader>ga", "<cmd>Gitsigns toggle_current_line_blame<CR>")  -- Toggle blame annotation
    keymap("n", "<leader>gb", "<cmd>Gitsigns blame_line<CR>")  -- Full blame popup
    keymap("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<CR>")  -- Preview change
    keymap("n", "<leader>gr", "<cmd>Gitsigns reset_hunk<CR>")  -- Reset hunk
    keymap("n", "]g", "<cmd>Gitsigns next_hunk<CR>")  -- Next change
    keymap("n", "[g", "<cmd>Gitsigns prev_hunk<CR>")  -- Previous change
  end,
}
