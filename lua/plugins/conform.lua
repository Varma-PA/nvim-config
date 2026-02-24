return {
  "stevearc/conform.nvim",
  config = function()
    local util = require("conform.util")
    -- Project root where Prettier config lives (same resolution as Cursor)
    local prettier_config_files = {
      ".prettierrc", ".prettierrc.json", ".prettierrc.yml", ".prettierrc.yaml",
      ".prettierrc.js", ".prettierrc.cjs", ".prettierrc.mjs", ".prettierrc.toml",
      "prettier.config.js", "prettier.config.cjs", "prettier.config.mjs",
      "package.json",
    }
    require("conform").setup({
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        json = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        markdown = { "prettier" },
      },
      formatters = {
        prettier = {
          command = "npx",
          args = { "prettier", "--stdin-filepath", "$FILENAME" },
          cwd = util.root_file(prettier_config_files),
          -- If no config found, still run from file's dir so npx finds project's Prettier
          require_cwd = false,
        },
      },
      format_on_save = {
        timeout_ms = 3000,
        lsp_fallback = false,
      },
      notify_on_error = true,
    })
  end,
}
