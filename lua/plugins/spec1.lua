return {
  -- The ColorScheme should be available when starting Neovim
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "storm",  -- Light theme (options: storm, moon, night, day)
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd("colorscheme tokyonight")
    end,
  },
}
