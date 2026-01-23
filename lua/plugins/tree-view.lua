return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- Load web-devicons for file icons
    require("nvim-web-devicons").setup()
    
    require("nvim-tree").setup({
      sync_root_with_cwd = true,
      update_focused_file = {
        enable = true,  -- Highlight current file in tree
      },
      renderer = {
        icons = {
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
          },
        },
      },
      actions = {
        open_file = {
          window_picker = {
            enable = false,  -- Open in last focused window
          },
        },
      },
    })

    -- Exclude nvim-tree from jumplist
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "NvimTree",
      callback = function()
        vim.opt_local.buflisted = false
        vim.cmd("clearjumps")
      end,
    })

    -- Auto-open nvim-tree on startup
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        require("nvim-tree.api").tree.open()
      end,
    })
  end,
}
