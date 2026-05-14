return {
  { "rose-pine/neovim", name = "rose-pine", lazy = false },
  { "folke/tokyonight.nvim", lazy = false, priority = 1000 },
  { "catppuccin/nvim", name = "catppuccin", lazy = false },
  { "mhartington/oceanic-next", lazy = false },

  {
    "nvim-lua/plenary.nvim",
    lazy = false,
    priority = 10,
    config = function()
      local dark = {
        "rose-pine-main",
        "tokyonight",
        "tokyonight-storm",
        "tokyonight-night",
        "tokyonight-moon",
        "catppuccin-mocha",
        "catppuccin-macchiato",
        "catppuccin-frappe",
        "OceanicNext",
      }
      local light = {
        "rose-pine-dawn",
        "tokyonight-day",
        "catppuccin-latte",
        "OceanicNextLight",
        "morning",
        "shine",
        "peachpuff",
        "default",
        "zellner",
      }

      local cycle = { "default" }
      vim.list_extend(cycle, dark)
      for _, name in ipairs(light) do
        if name ~= "default" then
          cycle[#cycle + 1] = name
        end
      end

      local light_set = {}
      for _, name in ipairs(light) do
        light_set[name] = true
      end

      local idx = 1
      --- Until you use `<leader>tn`, OSC may adjust light/dark and swap OceanicNext vs OceanicNextLight.
      local auto_oceanic = true

      local function index_of(name)
        for i, n in ipairs(cycle) do
          if n == name then
            return i
          end
        end
        return 1
      end

      local function apply_oceanic_for_background()
        if vim.o.background == "light" then
          idx = index_of("OceanicNextLight")
          vim.cmd.colorscheme("OceanicNextLight")
        else
          idx = index_of("OceanicNext")
          vim.cmd.colorscheme("OceanicNext")
        end
      end

      local function macos_fallback_bg()
        if vim.fn.has("mac") ~= 1 then
          return "dark"
        end
        vim.fn.system({ "defaults", "read", "-g", "AppleInterfaceStyle" })
        if vim.v.shell_error ~= 0 then
          return "light"
        end
        return "dark"
      end

      local function parse_osc11_rgb(seq)
        if type(seq) ~= "string" or not seq:find("]11;", 1, true) then
          return nil
        end
        local rh, gh, bh = seq:match("rgb:([0-9a-fA-F]+)/([0-9a-fA-F]+)/([0-9a-fA-F]+)")
        if rh then
          local function chan(h)
            local n = assert(tonumber(h, 16))
            if #h <= 2 then
              return n / 255
            end
            return n / 65535
          end
          return chan(rh), chan(gh), chan(bh)
        end
        local hx = seq:match("#([0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F])")
        if hx then
          local n = assert(tonumber(hx, 16))
          local r = math.floor(n / 65536) % 256 / 255
          local g = math.floor(n / 256) % 256 / 255
          local b = n % 256 / 255
          return r, g, b
        end
        return nil
      end

      local function srgb_luminance(r, g, b)
        local function lin(c)
          return c <= 0.03928 and c / 12.92 or math.pow((c + 0.055) / 1.055, 2.4)
        end
        local R, G, B = lin(r), lin(g), lin(b)
        return 0.2126 * R + 0.7152 * G + 0.0722 * B
      end

      local osc_done = false
      local osc_group = vim.api.nvim_create_augroup("NvimTermBgOsc", { clear = true })

      local function apply_osc_bg(seq)
        if osc_done or not auto_oceanic then
          return
        end
        local r, g, b = parse_osc11_rgb(seq)
        if not r then
          return
        end
        osc_done = true
        pcall(vim.api.nvim_del_augroup_by_id, osc_group)
        local mode = srgb_luminance(r, g, b) > 0.45 and "light" or "dark"
        vim.o.background = mode
        apply_oceanic_for_background()
      end

      vim.api.nvim_create_autocmd("TermResponse", {
        group = osc_group,
        callback = function(args)
          local seq = args.data and args.data.sequence or ""
          apply_osc_bg(seq)
        end,
      })

      vim.defer_fn(function()
        if not osc_done then
          io.stdout:write("\027]11;?\027\\")
          if io.stdout.flush then
            io.stdout:flush()
          end
        end
      end, 0)

      vim.defer_fn(function()
        pcall(vim.api.nvim_del_augroup_by_id, osc_group)
      end, 400)

      local function apply(i)
        local name = cycle[i]
        idx = i
        if name == "default" then
          vim.cmd.colorscheme("default")
          return
        end
        vim.o.background = light_set[name] and "light" or "dark"
        vim.cmd.colorscheme(name)
      end

      vim.o.background = macos_fallback_bg()
      apply_oceanic_for_background()

      vim.keymap.set("n", "<leader>tt", function()
        vim.o.background = vim.o.background == "light" and "dark" or "light"
        local name = cycle[idx]
        if name == "OceanicNext" or name == "OceanicNextLight" then
          apply_oceanic_for_background()
        else
          vim.cmd.colorscheme(name)
        end
        print("Background: " .. vim.o.background)
      end, { desc = "Toggle light/dark (background)" })

      vim.keymap.set("n", "<leader>tn", function()
        auto_oceanic = false
        local next_i = idx % #cycle + 1
        apply(next_i)
        print(string.format("Theme [%d/%d]: %s", next_i, #cycle, cycle[next_i]))
      end, { desc = "Next colorscheme" })
    end,
  },
}
