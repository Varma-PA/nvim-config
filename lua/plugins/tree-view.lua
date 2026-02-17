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
      diagnostics = {
        enable = true,
        show_on_dirs = false,
        show_on_open_dirs = false,
        severity = {
          min = vim.diagnostic.severity.HINT,
          max = vim.diagnostic.severity.ERROR,
        },
        icons = { hint = "H", info = "I", warning = "W", error = "E" },
      },
      renderer = {
        highlight_diagnostics = "name",  -- Color filename by severity (red = error)
        icons = {
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
            diagnostics = true,
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

    -- Color filenames in tree by LSP diagnostic severity
    local function set_diag_highlights()
      vim.api.nvim_set_hl(0, "NvimTreeDiagnosticErrorFileHL", { fg = "#ff6b6b", default = true })
      vim.api.nvim_set_hl(0, "NvimTreeDiagnosticWarnFileHL", { fg = "#ffd93d", default = true })
      vim.api.nvim_set_hl(0, "NvimTreeDiagnosticInfoFileHL", { fg = "#6bcb77", default = true })
      vim.api.nvim_set_hl(0, "NvimTreeDiagnosticHintFileHL", { fg = "#4d96ff", default = true })
    end
    vim.api.nvim_create_autocmd("ColorScheme", { callback = set_diag_highlights })
    set_diag_highlights()

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
