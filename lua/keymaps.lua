local keymap = vim.keymap.set

-----------------------------------------------------------
-- Opencode (nickjvandyke/opencode.nvim)
-- Leader prefix `<leader>o…` — also `<leader>ca` + explain/fix on a diagnostic line (see lua/plugins/lsp.lua).
--
-- | Key | Mode | Action |
-- |-----|------|--------|
-- | `<leader>oa` | n, x | Ask / prompt (`@this`) |
-- | `<leader>os` | n, x | Command palette (prompts, session, commands) |
-- | `<leader>ot` | n, t | Toggle Opencode panel |
-- | `<leader>ox` | n, t | Interrupt session |
-- | `<leader>on` | n | New session |
-- | `<leader>ou` | n | Undo last action in session |
-- | `<leader>oR` | n | Redo last undone action |
-- | `<leader>oS` | n | Select session |
-- | `<leader>oc` | n | Compact session (shrink context) |
-- | `<leader>od` | n, x | Ask about diagnostics (`@diagnostics` + `@this`) |
-- | `<leader>ob` | n, x | Ask with full file + cursor (`@buffer` + `@this`) |
-- | `go` | n, x | Operator: range → opencode prompt |
-- | `goo` | n | Operator: current line → prompt |
-- | `<S-C-u>` / `<S-C-d>` | n | Scroll Opencode messages half page |
-- | `<C-a>` | n, x | Ask (same as `<leader>oa`; steals increment — use `+`) |
-- | `<C-x>` | n, x | Palette (same as `<leader>os`; use `-` for decrement) |
-- | `<C-.>` | n, t | Toggle panel (same as `<leader>ot`) |
-- | `+` / `-` | n | Increment / decrement number (unmap bypass for stolen `<C-a>`/`<C-x>`) |
-- | Snacks picker input | i | `<a-a>` (Alt-a) send to Opencode — see `lua/plugins/opencode.lua` |
-- | Permission diff tab | n | `da` accept edit · `dr` reject · `q` close (buffer-local) |
-----------------------------------------------------------

--- opencode.nvim uses promises; cancelling ask/select or dismissing server pick calls `reject()` with no
--- payload, which can still trip "unhandled promise rejection: {}". Terminal `.catch` fixes that.
local function oc_swallow(promise)
  if not (promise and type(promise.catch) == "function") then
    return
  end
  promise:catch(function(err)
    if err == nil or err == "" then
      return
    end
    if type(err) == "table" and next(err) == nil then
      return
    end
    vim.notify(vim.inspect(err), vim.log.levels.WARN, { title = "opencode" })
  end)
end

local function setup_opencode_keymaps()
  local ok, opencode = pcall(require, "opencode")
  if not ok then
    return
  end
  local oc_cmd = require("opencode.api.command").command

  keymap({ "n", "x" }, "<leader>oa", function()
    oc_swallow(opencode.ask("@this: ", { submit = true }))
  end, { desc = "Opencode: ask (prompt)" })
  keymap({ "n", "x" }, "<leader>os", function()
    oc_swallow(opencode.select())
  end, { desc = "Opencode: palette (prompts & commands)" })
  keymap({ "n", "t" }, "<leader>ot", function() opencode.toggle() end, { desc = "Opencode: toggle panel" })
  keymap({ "n", "t" }, "<leader>ox", function()
    oc_swallow(oc_cmd("session.interrupt"))
  end, { desc = "Opencode: stop / interrupt" })
  keymap("n", "<leader>on", function()
    oc_swallow(oc_cmd("session.new"))
  end, { desc = "Opencode: new session" })
  keymap("n", "<leader>ou", function()
    oc_swallow(oc_cmd("session.undo"))
  end, { desc = "Opencode: undo last action" })
  keymap("n", "<leader>oR", function()
    oc_swallow(oc_cmd("session.redo"))
  end, { desc = "Opencode: redo" })
  keymap("n", "<leader>oS", function()
    oc_swallow(oc_cmd("session.select"))
  end, { desc = "Opencode: select session" })
  keymap("n", "<leader>oc", function()
    oc_swallow(oc_cmd("session.compact"))
  end, { desc = "Opencode: compact session" })
  keymap({ "n", "x" }, "<leader>od", function()
    oc_swallow(opencode.ask(
      "Explain the diagnostics below and suggest a minimal fix. Prefer the issue at the cursor.\n@diagnostics\n\n@this",
      { submit = true }
    ))
  end, { desc = "Opencode: ask about diagnostics" })
  -- `@buffer` expands to the current file path; OpenCode loads the whole file from disk (save unsaved edits first).
  keymap({ "n", "x" }, "<leader>ob", function()
    oc_swallow(opencode.ask(
      "Review this file using the full contents plus the cursor/selection as the focal point. Note bugs, edge cases, and clarity issues.\n@buffer\n\n@this",
      { submit = true }
    ))
  end, { desc = "Opencode: full file + cursor (@buffer + @this)" })

  keymap({ "n", "x" }, "go", function() return opencode.operator("@this ") end, { desc = "Opencode: operator (range → prompt)", expr = true })
  keymap("n", "goo", function() return opencode.operator("@this ") .. "_" end, { desc = "Opencode: operator (line)", expr = true })

  keymap("n", "<S-C-u>", function()
    oc_swallow(oc_cmd("session.half.page.up"))
  end, { desc = "Opencode: scroll messages up" })
  keymap("n", "<S-C-d>", function()
    oc_swallow(oc_cmd("session.half.page.down"))
  end, { desc = "Opencode: scroll messages down" })

  keymap({ "n", "x" }, "<C-a>", function()
    oc_swallow(opencode.ask("@this: ", { submit = true }))
  end, { desc = "Opencode: ask (same as <leader>oa)" })
  keymap({ "n", "x" }, "<C-x>", function()
    oc_swallow(opencode.select())
  end, { desc = "Opencode: palette (same as <leader>os)" })
  keymap({ "n", "t" }, "<C-.>", function() opencode.toggle() end, { desc = "Opencode: toggle (same as <leader>ot)" })
  keymap("n", "+", "<C-a>", { desc = "Increment number", noremap = true })
  keymap("n", "-", "<C-x>", { desc = "Decrement number", noremap = true })
end

vim.api.nvim_create_autocmd("User", {
  pattern = "LazyDone",
  once = true,
  callback = setup_opencode_keymaps,
})

-- Save file
keymap("n", "<leader>w", ":w<CR>")
keymap("n", "<C-s>", ":w<CR>")
keymap("i", "<C-s>", "<Esc>:w<CR>")  -- Also works in insert mode

-- Quit
keymap("n", "<leader>q", ":q<CR>")
keymap("n", "<leader>Q", ":qa!<CR>")  -- Quit all without saving

-- Window navigation: handled by vim-tmux-navigator (Ctrl-h/j/k/l)

-- Window splits
keymap("n", "<leader>sv", "<cmd>vsplit<CR>")  -- Vertical split
keymap("n", "<leader>sh", "<cmd>split<CR>")   -- Horizontal split
keymap("n", "<leader>sx", "<cmd>close<CR>")   -- Close split

-- Clear search highlight
keymap("n", "<leader>h", ":nohlsearch<CR>")

-----------------------------------------------------------
-- Session restore (persistence.nvim)
-----------------------------------------------------------
keymap("n", "<leader>sl", function() require("persistence").load() end, { desc = "Restore session for current dir" })
keymap("n", "<leader>sL", function() require("persistence").load({ last = true }) end, { desc = "Restore last session" })
keymap("n", "<leader>sS", function() require("persistence").select() end, { desc = "Select session to restore" })
keymap("n", "<leader>sd", function() require("persistence").stop() end, { desc = "Don't save session on exit" })


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
keymap("n", "<C-`>", "<cmd>belowright split | terminal<CR>")  -- Terminal below
keymap("n", "<leader>tv", "<cmd>vertical rightbelow terminal<CR>", { desc = "Terminal right (full height)" })  -- Terminal right pane
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
vim.api.nvim_create_autocmd("User", {
  pattern = "LazyDone",
  once = true,
  callback = function()
    local ok, actions = pcall(require, "telescope.actions")
    if not ok then
      return
    end
    require("telescope").setup({
      defaults = {
        mappings = {
          i = {
            ["<C-d>"] = actions.delete_buffer,
          },
          n = {
            ["dd"] = actions.delete_buffer,
          },
        },
      },
    })
  end,
})

keymap("n", "<leader>ff", "<cmd>Telescope find_files<CR>")
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<CR>")
keymap("n", "<leader>fw", function()
  require("telescope.builtin").live_grep({
    additional_args = function()
      return { "--hidden", "--word-regexp" } -- hidden + whole word (foo won't match foobar)
    end,
  })
end)
keymap("n", "<leader>fb", "<cmd>Telescope buffers<CR>")
keymap("n", "<leader>fd", "<cmd>Telescope diagnostics<CR>", { desc = "List diagnostics, Enter to jump to line" })
keymap("n", "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<CR>")  -- Find in current file

-----------------------------------------------------------
-- Surround / wrap in brackets
-----------------------------------------------------------
keymap("n", "<leader>b", "ysiw)", { desc = "Wrap word in ()" })
keymap("n", "<leader>B", "ysiw]", { desc = "Wrap word in []" })
keymap("v", "<leader>b", "S)", { desc = "Wrap selection in ()" })
keymap("v", "<leader>B", "S]", { desc = "Wrap selection in []" })

-----------------------------------------------------------
-- Move lines
-----------------------------------------------------------
keymap("n", "<A-j>", ":m .+1<CR>==") -- move line up(n)
keymap("n", "<A-k>", ":m .-2<CR>==") -- move line down(n)
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv") -- move line up(v)
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv") -- move line down(v)

-----------------------------------------------------------
-- Buffer Management 
-----------------------------------------------------------
keymap("n", "<leader>bb", "<cmd>b#<CR>")
-----------------------------------------------------------
-- Markdown Preview
-----------------------------------------------------------
keymap("n", "<leader>mp", function()
  -- Ensure plugin is loaded before calling command
  pcall(vim.cmd, "MarkdownPreviewToggle")
end, { desc = "Toggle markdown preview" })