return {
  {
    "nickjvandyke/opencode.nvim",
    version = "*", -- Latest stable release
    lazy = false, -- load at startup so keymaps always exist (not only after `VeryLazy`)
    dependencies = {
      {
        -- `snacks.nvim` integration is recommended, but optional
        ---@module "snacks" <- Loads `snacks.nvim` types for configuration intellisense
        "folke/snacks.nvim",
        -- optional = true,
        opts = {
          input = {}, -- Enhances `ask()`
          picker = { -- Enhances `select()`
            actions = {
              opencode_send = function(...) return require("opencode").snacks_picker_send(...) end,
            },
            win = {
              input = {
                keys = {
                  ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
                },
              },
            },
          },
        },
      },
    },
    config = function()
      vim.o.autoread = true -- Required for `opts.events.reload`

      -- `vim.g.opencode_opts` is merged only on first `require("opencode.config")`; patch the live
      -- table so edits/permissions settings always apply (see opencode.nvim README / config.lua).
      local oc_cfg = require("opencode.config")
      -- Neovim can only show approve/reject UI when OpenCode emits `permission.asked` over SSE.
      -- OpenCode defaults are permissive (`edit` is effectively allow) unless you set `permission.edit`
      -- to `ask` — see ~/.config/opencode/config.json and https://opencode.ai/docs/permissions/
      oc_cfg.opts.events = vim.tbl_deep_extend("force", oc_cfg.opts.events or {}, {
        enabled = true,
        reload = true,
        permissions = {
          enabled = true,
          edits = { enabled = true },
          -- Permission UI waits for this many ms of no keys after `permission.asked` (then diff / vim.ui.select).
          idle_delay_ms = 400,
        },
      })

      vim.g.opencode_opts = vim.tbl_deep_extend("force", vim.g.opencode_opts or {}, {
        events = {
          enabled = true,
          reload = true,
          permissions = {
            enabled = true,
            idle_delay_ms = 400,
            edits = { enabled = true },
          },
        },
        -- Experimental: in-process LSP adds code actions on a diagnostic line:
        -- "Ask opencode to explain/fix: …" (same idea as Cursor quick fixes → chat).
        lsp = { enabled = true },
      })

      oc_cfg.opts.lsp = vim.tbl_deep_extend("force", oc_cfg.opts.lsp or {}, {
        enabled = true,
      })

      -- Replace bundled permission-diff autocmds (path escaping, promise :catch, pcall around diffpatch).
      require("opencode_edits_fix").apply()

      -- Keymaps: lua/keymaps.lua (`LazyDone` → `setup_opencode_keymaps`)
    end,
  },
}
