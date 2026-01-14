return {
  -- Themes
  { "folke/tokyonight.nvim", lazy = false, priority = 1000 },
  { "catppuccin/nvim", name = "catppuccin", lazy = false },
  { "rose-pine/neovim", name = "rose-pine", lazy = false },

  -- Theme setup and toggle
  {
    "nvim-lua/plenary.nvim",  -- Just using this as a hook to run config
    lazy = false,
    priority = 999,
    config = function()
      -- Available themes (dark, light)
      local themes = {
        dark = { "tokyonight-storm", "catppuccin-mocha", "rose-pine-main" },
        light = { "tokyonight-day", "catppuccin-latte", "rose-pine-dawn" },
      }

      -- File to save theme preference
      local theme_file = vim.fn.stdpath("data") .. "/theme_preference.lua"

      -- Load saved preference or use defaults
      local current_mode = "dark"
      local current_index = 1
      local ok, saved = pcall(dofile, theme_file)
      if ok and saved then
        current_mode = saved.mode or "dark"
        current_index = saved.index or 1
      end

      -- Save theme preference
      local function save_theme()
        local file = io.open(theme_file, "w")
        if file then
          file:write(string.format('return { mode = "%s", index = %d }', current_mode, current_index))
          file:close()
        end
      end

      -- Fix cursor line for light/dark
      local function fix_cursorline()
        if current_mode == "light" then
          vim.api.nvim_set_hl(0, "CursorLine", { bg = "#e0e0e0" })
        end
      end

      -- Set initial theme
      vim.cmd("colorscheme " .. themes[current_mode][current_index])
      fix_cursorline()

      -- Toggle light/dark
      vim.keymap.set("n", "<leader>tt", function()
        current_mode = current_mode == "dark" and "light" or "dark"
        vim.cmd("colorscheme " .. themes[current_mode][current_index])
        fix_cursorline()
        save_theme()
        print("Theme: " .. themes[current_mode][current_index])
      end, { desc = "Toggle light/dark theme" })

      -- Cycle through themes
      vim.keymap.set("n", "<leader>tn", function()
        current_index = current_index % #themes[current_mode] + 1
        vim.cmd("colorscheme " .. themes[current_mode][current_index])
        fix_cursorline()
        save_theme()
        print("Theme: " .. themes[current_mode][current_index])
      end, { desc = "Next theme" })
    end,
  },
}
