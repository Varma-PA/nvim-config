return {
  -- Themes
  { "rose-pine/neovim", name = "rose-pine", lazy = false },
  { "folke/tokyonight.nvim", lazy = false, priority = 1000 },
  { "catppuccin/nvim", name = "catppuccin", lazy = false },

  -- Theme setup and toggle
  {
    "nvim-lua/plenary.nvim",  -- Just using this as a hook to run config
    lazy = false,
    priority = 999,
    config = function()
      -- Available themes (dark, light)
      local themes = {
        dark = {
          "rose-pine-main",       -- Warm dark
          "tokyonight",           -- Default Tokyo Night
          "tokyonight-storm",     -- Storm variant
          "tokyonight-night",     -- Night variant
          "tokyonight-moon",      -- Moon variant
          "catppuccin-mocha",     -- Catppuccin dark
          "catppuccin-macchiato", -- Macchiato variant
          "catppuccin-frappe",    -- Frappe variant
        },
        light = {
          "rose-pine-dawn",      -- Creamy beige (your favorite)
          "tokyonight-day",      -- Light blue-gray
          "catppuccin-latte",    -- Warm light theme
          "morning",             -- Bright white (built-in)
          "shine",               -- Light gray (built-in)
          "peachpuff",           -- Peach tinted (built-in)
          "default",             -- Pure white (built-in)
          "zellner",             -- Light gray (built-in)
        },
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
        -- Ensure index is within bounds for the current mode
        if current_mode == "dark" or current_mode == "light" then
          local max_index = #themes[current_mode]
          if current_index < 1 or current_index > max_index then
            current_index = 1
          end
        end
      end

      -- Save theme preference
      local function save_theme()
        local file = io.open(theme_file, "w")
        if file then
          file:write(string.format('return { mode = "%s", index = %d }', current_mode, current_index))
          file:close()
        end
      end

      -- Theme-specific configurations
      local theme_configs = {}

      -- Fix cursor line for light/dark
      local function fix_cursorline()
        if current_mode == "light" then
          vim.api.nvim_set_hl(0, "CursorLine", { bg = "#e0e0e0" })
        end
      end

      -- Sync iTerm colors with Neovim theme
      local function sync_iterm_colors(theme_name)
        -- Only sync for light themes
        if current_mode ~= "light" then
          return
        end

        -- Map of theme names to background colors for iTerm (RGB values 0-65535)
        local theme_colors = {
          ["rose-pine-dawn"] = { 64250, 62780, 60652 },  -- #faf4ed (creamy)
          ["tokyonight-day"] = { 57669, 57890, 59175 },  -- #e1e2e7 (light blue-gray)
          ["catppuccin-latte"] = { 61423, 61681, 62965 }, -- #eff1f5 (warm light)
          ["morning"] = { 65535, 65535, 65535 },         -- #ffffff (bright white)
          ["shine"] = { 61166, 61166, 61166 },           -- #eeeeee (light gray)
          ["peachpuff"] = { 65535, 62965, 59110 },       -- #ffdab9 (peach)
          ["default"] = { 65535, 65535, 65535 },         -- #ffffff (pure white)
          ["zellner"] = { 61166, 61166, 61166 },         -- #eeeeee (light gray)
        }

        local rgb = theme_colors[theme_name]
        if rgb and vim.fn.has("mac") == 1 then
          -- Use AppleScript to set iTerm tab color
          local script = string.format(
            [[tell application "iTerm2"
              tell current window
                tell current tab
                  set background color to {%d, %d, %d}
                end tell
              end tell
            end tell]],
            rgb[1], rgb[2], rgb[3]
          )

          -- Execute in background to avoid blocking
          vim.fn.jobstart({ "osascript", "-e", script }, {
            detach = true,
          })

          -- Also set tab color using iTerm escape sequences (more reliable)
          local r = math.floor(rgb[1] / 256)
          local g = math.floor(rgb[2] / 256)
          local b = math.floor(rgb[3] / 256)
          -- iTerm tab color escape sequence
          vim.api.nvim_out_write(string.format("\027]6;1;bg;red;brightness;%d\a", r))
          vim.api.nvim_out_write(string.format("\027]6;1;bg;green;brightness;%d\a", g))
          vim.api.nvim_out_write(string.format("\027]6;1;bg;blue;brightness;%d\a", b))
        end
      end

      -- Apply theme with configuration
      local function apply_theme(theme_name)
        -- Run theme-specific config if exists
        if theme_configs[theme_name] then
          theme_configs[theme_name]()
        end

        -- Set background for light themes
        if current_mode == "light" then
          vim.o.background = "light"
        else
          vim.o.background = "dark"
        end

        -- Apply colorscheme
        vim.cmd("colorscheme " .. theme_name)
        fix_cursorline()

        -- Sync iTerm colors
        sync_iterm_colors(theme_name)
      end

      -- Set initial theme
      apply_theme(themes[current_mode][current_index])

      -- Toggle light/dark
      vim.keymap.set("n", "<leader>tt", function()
        current_mode = current_mode == "dark" and "light" or "dark"
        current_index = 1  -- Reset to first theme when switching modes
        apply_theme(themes[current_mode][current_index])
        save_theme()
        print("Theme: " .. themes[current_mode][current_index])
      end, { desc = "Toggle light/dark theme" })

      -- Cycle through themes (only useful if there are multiple themes per mode)
      vim.keymap.set("n", "<leader>tn", function()
        local max_themes = #themes[current_mode]
        if max_themes > 1 then
          current_index = current_index % max_themes + 1
          apply_theme(themes[current_mode][current_index])
          save_theme()
          print(string.format("Theme [%d/%d]: %s", current_index, max_themes, themes[current_mode][current_index]))
        else
          print("Only one theme available in " .. current_mode .. " mode: " .. themes[current_mode][1])
        end
      end, { desc = "Next theme" })
    end,
  },
}
