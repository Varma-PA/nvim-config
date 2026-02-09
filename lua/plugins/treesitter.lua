return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  lazy = false,
  config = function()
    local ok, configs = pcall(require, "nvim-treesitter.configs")
    if not ok or not configs then
      vim.notify(
        "nvim-treesitter not found. Run :Lazy sync to install plugins, then restart Neovim.",
        vim.log.levels.WARN
      )
      return
    end
    configs.setup({
      ensure_installed = {
        "markdown",
        "markdown_inline",
        "dockerfile",
      },
      highlight = {
        enable = true,
      },
    })
  end,
}
