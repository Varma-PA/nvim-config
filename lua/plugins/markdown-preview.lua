return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  ft = { "markdown" },
  build = "cd app && npm install",
  init = function()
    vim.g.mkdp_auto_start = 0  -- Don't auto-start preview
    vim.g.mkdp_auto_close = 1  -- Auto-close preview when leaving markdown buffer
    vim.g.mkdp_refresh_slow = 0  -- Fast refresh
    vim.g.mkdp_command_for_global = 0  -- Only preview markdown files
    vim.g.mkdp_open_to_the_world = 0  -- Only allow localhost access
    vim.g.mkdp_open_ip = ""  -- Use default IP
    vim.g.mkdp_port = ""  -- Use random port
    vim.g.mkdp_browser = ""  -- Use default browser
    vim.g.mkdp_echo_preview_url = 1  -- Echo preview URL in command line
    vim.g.mkdp_page_title = "${name}"  -- Page title format
    vim.g.mkdp_filetypes = { "markdown" }  -- Only for markdown files
    vim.g.mkdp_theme = "dark"  -- Dark theme (or "light")
  end,
}
