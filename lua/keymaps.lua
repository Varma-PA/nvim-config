local keymap = vim.keymap.set

-- Save file
keymap("n", "<leader>w", ":w<CR>")
keymap("n", "<C-s>", ":w<CR>")
keymap("i", "<C-s>", "<Esc>:w<CR>")  -- Also works in insert mode

-- Quit
keymap("n", "<leader>q", ":q<CR>")
keymap("n", "<leader>Q", ":qa!<CR>")  -- Quit all without saving

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h")
keymap("n", "<C-j>", "<C-w>j")
keymap("n", "<C-k>", "<C-w>k")
keymap("n", "<C-l>", "<C-w>l")

-- Window splits
keymap("n", "<leader>sv", "<cmd>vsplit<CR>")  -- Vertical split
keymap("n", "<leader>sh", "<cmd>split<CR>")   -- Horizontal split
keymap("n", "<leader>sx", "<cmd>close<CR>")   -- Close split

-- Clear search highlight
keymap("n", "<leader>h", ":nohlsearch<CR>")


-----------------------------------------------------------
-- Quality of life
-----------------------------------------------------------
-- Keep selection when indenting
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- Exit insert mode with jk
keymap("i", "jk", "<Esc>")

-----------------------------------------------------------
-- Disabling the keys
-----------------------------------------------------------
keymap("n", "<Up>", "<cmd>echo 'Hey no arrow keys allowed!'<CR>")
keymap("n", "<Down>", "<cmd>echo 'Hey no arrow keys allowed!'<CR>")
keymap("n", "<Left>", "<cmd>echo 'Hey no arrow keys allowed!'<CR>")
keymap("n", "<Right>", "<cmd>echo 'Hey no arrow keys allowed!'<CR>")

-----------------------------------------------------------
-- Resize splits with Option + Arrow keys
-----------------------------------------------------------
keymap("n", "<A-Up>", "<cmd>resize +2<CR>")
keymap("n", "<A-Down>", "<cmd>resize -2<CR>")
keymap("n", "<A-Left>", "<cmd>vertical resize -2<CR>")
keymap("n", "<A-Right>", "<cmd>vertical resize +2<CR>")

-----------------------------------------------------------
-- NvimTree
-----------------------------------------------------------
keymap("n", "<leader>e", "<cmd>NvimTreeToggle<CR>")

-----------------------------------------------------------
-- Terminal
-----------------------------------------------------------
keymap("n", "<C-`>", "<cmd>belowright split | terminal<CR>")
keymap("t", "<C-`>", "<cmd>close<CR>")  -- Close terminal with same key
keymap("t", "<Esc>", "<C-\\><C-n>")     -- Exit terminal mode with Esc

-----------------------------------------------------------
-- Buffer management
-----------------------------------------------------------
-- Close buffer and go to next buffer (or nvim-tree if no buffers left)
-- Smart close function (used by keymap and commands)
local function smart_close(save, force)
  local buf = vim.api.nvim_get_current_buf()
  local buffers = vim.fn.getbufinfo({ buflisted = 1 })

  -- Save if requested
  if save then
    vim.cmd("write")
  end

  -- If this is the last real buffer, focus nvim-tree first then wipe buffer
  if #buffers <= 1 then
    require("nvim-tree.api").tree.focus()
    vim.cmd("bwipeout" .. (force and "!" or "") .. " " .. buf)
  else
    -- Go to previous buffer, then close current
    vim.cmd("bprev")
    vim.cmd("bwipeout" .. (force and "!" or "") .. " " .. buf)
  end
end

keymap("n", "<leader>x", function() smart_close(false, false) end)

-- Override :q, :q!, :wq, :wq! commands
-- vim.api.nvim_create_user_command("Q", function(opts) smart_close(false, opts.bang) end, { bang = true })
-- vim.api.nvim_create_user_command("Wq", function(opts) smart_close(true, opts.bang) end, { bang = true })
-- vim.cmd("cabbrev q Q")
-- vim.cmd("cabbrev wq Wq")

-----------------------------------------------------------
-- Telescope
-----------------------------------------------------------
keymap("n", "<leader>ff", "<cmd>Telescope find_files<CR>")
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<CR>")
keymap("n", "<leader>fw", function()
  require("telescope.builtin").live_grep({
    additional_args = { "--word-regexp" }  -- Whole word match only
  })
end)  -- Search whole word only (foo won't match foobar)
keymap("n", "<leader>fb", "<cmd>Telescope buffers<CR>")
keymap("n", "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<CR>")  -- Find in current file

-----------------------------------------------------------
-- Move lines
-----------------------------------------------------------
keymap("n", "<A-j>", ":m .+1<CR>==") -- move line up(n)
keymap("n", "<A-k>", ":m .-2<CR>==") -- move line down(n)
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv") -- move line up(v)
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv") -- move line down(v)