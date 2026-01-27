return {
  "lukas-reineke/headlines.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  ft = { "markdown", "norg", "org" }, -- Only load for markdown and org files
  config = function()
    -- Setup treesitter for markdown if not already configured
    local ok, ts_configs = pcall(require, "nvim-treesitter.configs")
    if ok then
      ts_configs.setup({
        ensure_installed = { "markdown", "markdown_inline" },
        highlight = {
          enable = true,
        },
      })
    end

    require("headlines").setup({
      markdown = {
        fat_headlines = true, -- Make headlines stand out more
      },
    })
  end,
}
