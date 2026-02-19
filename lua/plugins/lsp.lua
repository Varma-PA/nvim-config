return {
  -- Mason: installs LSP servers
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  -- Bridge between mason and lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "ts_ls", "dockerls" },
        -- Don't auto-setup ESLint (avoids "Unable to find ESLint library" when project has no eslint)
        handlers = {
          eslint = function() end,  -- Skip ESLint setup; enable in lsp.config when project has eslint
        },
      })
    end,
  },

  -- LSP config (using native Neovim 0.11+ API)
  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason-lspconfig.nvim", "hrsh7th/cmp-nvim-lsp" },
    config = function()
      -- Get capabilities from nvim-cmp for better completions
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- TypeScript with auto-import settings
      vim.lsp.config.ts_ls = {
        capabilities = capabilities,
        settings = {
          typescript = {
            suggest = {
              autoImports = true,
              includeCompletionsForModuleExports = true,
            },
          },
          javascript = {
            suggest = {
              autoImports = true,
              includeCompletionsForModuleExports = true,
            },
          },
        },
      }
      vim.lsp.enable("ts_ls")

      -- Dockerfile: syntax + completion
      vim.lsp.config.dockerls = { capabilities = capabilities }
      vim.lsp.enable("dockerls")

      -- ESLint (uncomment when you have ESLint in your project)
      -- vim.lsp.config.eslint = { capabilities = capabilities }
      -- vim.lsp.enable("eslint")

      -- Go to definition in a new vertical split (like Ctrl+click "open to the side")
      local function definition_in_vsplit()
        local params = vim.lsp.util.make_position_params()
        vim.lsp.buf_request(0, "textDocument/definition", params, function(err, result, _)
          if err or not result or not result[1] then return end
          local loc = result[1]
          local uri = loc.uri or loc.targetUri
          if not uri then return end
          local fname = vim.uri_to_fname(uri)
          local range = loc.range or loc.targetRange
          local start = range and range.start or { line = 0, character = 0 }
          vim.cmd("vsplit " .. vim.fn.fnameescape(fname))
          vim.api.nvim_win_set_cursor(0, { start.line + 1, start.character })
        end)
      end

      -- Keymaps (only active when LSP attaches)
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local opts = { buffer = args.buf }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts) -- Go to definition (current window)
          vim.keymap.set("n", "gD", definition_in_vsplit, opts)    -- Go to definition in vertical split
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts) -- Hover over symbol
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- Rename symbol
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts) -- Code action
          vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- Show error message
          vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- Previous error
          vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- Next error
        end,
      })
    end,
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Down>"] = cmp.mapping.select_next_item(), -- Next item
          ["<Up>"] = cmp.mapping.select_prev_item(), -- Previous item
          ["<C-d>"] = cmp.mapping.scroll_docs(4),  -- Scroll docs down
          ["<C-u>"] = cmp.mapping.scroll_docs(-4), -- Scroll docs up
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
        }),
      })
    end,
  },
}
