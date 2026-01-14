return {
  "stevearc/conform.nvim",
  config = function()
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
