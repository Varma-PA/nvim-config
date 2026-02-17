return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    options = {
      theme = "auto",  -- Follow your colorscheme
      component_separators = { left = "", right = "" },  -- Thin dividers (Nerd Font)
      section_separators = { left = "", right = "" },   -- Angled blocks (p10k-style)
      disabled_filetypes = { statusline = { "NvimTree", "dashboard" } },
      always_divide_middle = true,
      globalstatus = true,
    },
    sections = {
      lualine_a = {
        {
          "mode",
          fmt = function(s)
            return " " .. s:sub(1, 1):upper() .. " "
          end,
          separator = { left = "", right = "" },
          padding = { left = 0, right = 0 },
        },
      },
      lualine_b = {
        {
          "branch",
          icon = "",
          separator = { left = "", right = "" },
        },
      },
      lualine_c = {
        {
          "filename",
          path = 1,  -- 0 = just name, 1 = relative path, 2 = absolute path
          shorting_target = 40,
          symbols = {
            modified = " ",
            readonly = " ",
            unnamed = " ",
            newfile = " ",
          },
        },
      },
      lualine_x = {
        {
          "diagnostics",
          symbols = { error = " ", warn = " ", info = " ", hint = " " },
          colored = true,
        },
        "filetype",
      },
      lualine_y = {
        {
          "progress",
          fmt = function()
            return "%p%%"
          end,
        },
      },
      lualine_z = {
        {
          "location",
          fmt = function()
            return "%l:%c"
          end,
        },
      },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { "filename" },
      lualine_x = {},
      lualine_y = {},
      lualine_z = { "location" },
    },
    tabline = {},
    extensions = {},
  },
}
