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
        ensure_installed = { "ts_ls" },  -- Add "eslint" when you have ESLint installed in your project
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

      -- ESLint (uncomment when you have ESLint in your project)
      -- vim.lsp.config.eslint = { capabilities = capabilities }
      -- vim.lsp.enable("eslint")

      -- Keymaps (only active when LSP attaches)
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local opts = { buffer = args.buf }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts) -- Go to definition
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
