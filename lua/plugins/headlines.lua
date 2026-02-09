return {
  "lukas-reineke/headlines.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  ft = { "markdown", "norg", "org" }, -- Only load for markdown and org files
  config = function()
    -- Treesitter is set up in treesitter.lua (includes markdown, dockerfile)
    require("headlines").setup({
      markdown = {
        fat_headlines = true, -- Make headlines stand out more
      },
    })
  end,
}
