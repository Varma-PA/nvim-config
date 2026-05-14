return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- Load web-devicons for file icons
    require("nvim-web-devicons").setup()

    local function on_attach(bufnr)
      local api = require("nvim-tree.api")
      local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end
      api.config.mappings.default_on_attach(bufnr)
      -- Remap live filter so Space (leader) isn't triggered: F = start filter, f = clear filter
      vim.keymap.set("n", "F", api.filter.live.start, opts("Live Filter: Start"))
      vim.keymap.set("n", "f", api.filter.live.clear, opts("Live Filter: Clear"))
    end

    require("nvim-tree").setup({
      on_attach = on_attach,
      sync_root_with_cwd = true,
      filters = {
        dotfiles = false,
        git_ignored = false,
      },
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
        icons = { hint = "◆", info = "ℹ", warning = "⚠", error = "✖" },
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
            modified = true,
          },
          glyphs = {
            modified = "●",   -- Unsaved buffer changes
            git = {
              unstaged = "✎",   -- Modified, not staged (pencil)
              staged = "✓",     -- Staged for commit (check)
              unmerged = "⚠",  -- Merge conflict (warning)
              renamed = "➜",   -- Renamed (arrow)
              untracked = "★", -- New, not in git (star)
              deleted = "−",   -- Deleted (minus)
              ignored = "◌",   -- In .gitignore (dotted circle)
            },
          },
        },
      },
      actions = {
        open_file = {
          quit_on_open = true, -- hide tree after open / vsplit (Ctrl+v) / split; use <leader>e to show again
          window_picker = {
            enable = false,  -- Open in last focused window
          },
        },
      },
    })

    -- Color filenames in tree by LSP diagnostic severity
    -- Modified (unsaved) icon in orange so it's distinct from error (red)
    local function set_diag_highlights()
      vim.api.nvim_set_hl(0, "NvimTreeDiagnosticErrorFileHL", { fg = "#ff6b6b", default = true })
      vim.api.nvim_set_hl(0, "NvimTreeDiagnosticWarnFileHL", { fg = "#ffd93d", default = true })
      vim.api.nvim_set_hl(0, "NvimTreeDiagnosticInfoFileHL", { fg = "#6bcb77", default = true })
      vim.api.nvim_set_hl(0, "NvimTreeDiagnosticHintFileHL", { fg = "#4d96ff", default = true })
      vim.api.nvim_set_hl(0, "NvimTreeModifiedIcon", { fg = "#f0a050", default = true })  -- Orange for modified
    end

    -- setup() only runs once; on ColorScheme nvim-web-devicons normally calls set_up_highlights()
    -- without allow_override, so linked/placeholder DevIcon* groups are never replaced (muted icons).
    -- Force true + schedule so we run after other ColorScheme handlers and after the tree buffer exists.
    local function devicons_and_tree_redraw()
      pcall(function()
        local web = require("nvim-web-devicons")
        if web.set_up_highlights then
          web.set_up_highlights(true)
        end
      end)
      pcall(function()
        local api = require("nvim-tree.api")
        if api.tree.is_visible() then
          api.tree.reload()
        end
      end)
    end

    local function schedule_devicons_and_tree()
      vim.schedule(devicons_and_tree_redraw)
    end

    local function after_colorscheme()
      set_diag_highlights()
      schedule_devicons_and_tree()
    end

    vim.api.nvim_create_autocmd("ColorScheme", { callback = after_colorscheme })
    set_diag_highlights()

    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyDone",
      once = true,
      callback = schedule_devicons_and_tree,
    })

    -- Exclude nvim-tree from jumplist
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "NvimTree",
      callback = function()
        vim.opt_local.buflisted = false
        vim.cmd("clearjumps")
      end,
    })

    -- Auto-open nvim-tree on startup; redraw after open so devicon highlights match final colorscheme.
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        require("nvim-tree.api").tree.open()
        schedule_devicons_and_tree()
      end,
    })
  end,
}
