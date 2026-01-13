-----------------------------------------------------------
-- BASIC NEOVIM CONFIG (NO PLUGINS)
-----------------------------------------------------------

-- Leader key
vim.g.mapleader = " "

-----------------------------------------------------------
-- Editor behavior
-----------------------------------------------------------
vim.opt.number = true              -- Show line numbers
vim.opt.relativenumber = true      -- Relative line numbers
vim.opt.cursorline = true          -- Highlight current line

vim.opt.tabstop = 2                -- Tabs = 2 spaces
vim.opt.shiftwidth = 2
vim.opt.expandtab = true           -- Use spaces instead of tabs
vim.opt.smartindent = true

vim.opt.wrap = false               -- No line wrapping
vim.opt.scrolloff = 8              -- Keep cursor centered
vim.opt.sidescrolloff = 8

-----------------------------------------------------------
-- Searching
-----------------------------------------------------------
vim.opt.ignorecase = true          -- Case-insensitive search
vim.opt.smartcase = true           -- Case-sensitive if uppercase
vim.opt.hlsearch = true            -- Highlight matches
vim.opt.incsearch = true           -- Incremental search

-----------------------------------------------------------
-- UI / UX
-----------------------------------------------------------
vim.opt.termguicolors = true       -- Better colors
vim.opt.signcolumn = "yes"         -- Always show sign column
vim.opt.showmode = false           -- Don't show mode (NORMAL, INSERT)

-----------------------------------------------------------
-- Undo / Backup
-----------------------------------------------------------
vim.opt.undofile = true            -- Persistent undo
vim.opt.swapfile = false
vim.opt.backup = false

vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function()
    vim.opt.relativenumber = false
  end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function()
    vim.opt.relativenumber = true
  end,
})

-----------------------------------------------------------
-- Importing stuff
-----------------------------------------------------------

require("keymaps")
require("config.lazy")


-----------------------------------------------------------
-- Disable Mouse 
-----------------------------------------------------------

vim.opt.mouse = ""
