# Neovim Keyboard Shortcuts Reference

> **Leader Key:** `Space`  
> **Note:** On Mac, `Ctrl` = `⌃`, `Option/Alt` = `⌥`, `Shift` = `⇧`, `Cmd` = `⌘`

---

## 📁 File Operations

| Shortcut | Mac | Windows/Linux | Description | Source |
|----------|-----|---------------|-------------|--------|
| `Space w` | `Space w` | `Space w` | Save file | `keymaps.lua:4` |
| `Ctrl+s` | `⌃ s` | `Ctrl+s` | Save file | `keymaps.lua:5` |
| `Ctrl+s` (insert) | `⌃ s` | `Ctrl+s` | Save file (from insert mode) | `keymaps.lua:6` |
| `Space q` | `Space q` | `Space q` | Quit window | `keymaps.lua:9` |
| `Space Q` | `Space ⇧Q` | `Space Shift+Q` | Quit all (force, no save) | `keymaps.lua:10` |

---

## 🪟 Window Management

| Shortcut | Mac | Windows/Linux | Description | Source |
|----------|-----|---------------|-------------|--------|
| `Ctrl+h` | `⌃ h` | `Ctrl+h` | Move to left window | `keymaps.lua:13` |
| `Ctrl+j` | `⌃ j` | `Ctrl+j` | Move to bottom window | `keymaps.lua:14` |
| `Ctrl+k` | `⌃ k` | `Ctrl+k` | Move to top window | `keymaps.lua:15` |
| `Ctrl+l` | `⌃ l` | `Ctrl+l` | Move to right window | `keymaps.lua:16` |
| `Space sv` | `Space sv` | `Space sv` | Vertical split | `keymaps.lua:19` |
| `Space sh` | `Space sh` | `Space sh` | Horizontal split | `keymaps.lua:20` |
| `Space sx` | `Space sx` | `Space sx` | Close split | `keymaps.lua:21` |

---

## 📐 Resize Splits

> **Note:** Requires iTerm Option key set to "Esc+" on Mac

| Shortcut | Mac | Windows/Linux | Description | Source |
|----------|-----|---------------|-------------|--------|
| `Option+↑` | `⌥ ↑` | `Alt+↑` | Increase height | `keymaps.lua:48` |
| `Option+↓` | `⌥ ↓` | `Alt+↓` | Decrease height | `keymaps.lua:49` |
| `Option+←` | `⌥ ←` | `Alt+←` | Decrease width | `keymaps.lua:50` |
| `Option+→` | `⌥ →` | `Alt+→` | Increase width | `keymaps.lua:51` |

---

## 📑 Tabs (Bufferline)

| Shortcut | Mac | Windows/Linux | Description | Source |
|----------|-----|---------------|-------------|--------|
| `Shift+l` | `⇧ l` | `Shift+l` | Next tab | `keymaps.lua:68` |
| `Shift+h` | `⇧ h` | `Shift+h` | Previous tab | `keymaps.lua:69` |
| `Space x` | `Space x` | `Space x` | Close current tab | `keymaps.lua:92` |

---

## 🔍 Telescope (Search)

| Shortcut | Mac | Windows/Linux | Description | Source |
|----------|-----|---------------|-------------|--------|
| `Space ff` | `Space ff` | `Space ff` | Find files | `keymaps.lua:103` |
| `Space fg` | `Space fg` | `Space fg` | Live grep (search in files) | `keymaps.lua:104` |
| `Space fw` | `Space fw` | `Space fw` | Grep whole word only | `keymaps.lua:105` |
| `Space fb` | `Space fb` | `Space fb` | Browse open buffers | `keymaps.lua:110` |
| `Space /` | `Space /` | `Space /` | Find in current file | `keymaps.lua:111` |

---

## 🌲 File Tree (NvimTree)

| Shortcut | Mac | Windows/Linux | Description | Source |
|----------|-----|---------------|-------------|--------|
| `Space e` | `Space e` | `Space e` | Toggle file tree | `keymaps.lua:56` |
| `Enter` | `Enter` | `Enter` | Open file | (nvim-tree default) |
| `Ctrl+v` | `⌃ v` | `Ctrl+v` | Open in vertical split | (nvim-tree default) |
| `Ctrl+x` | `⌃ x` | `Ctrl+x` | Open in horizontal split | (nvim-tree default) |
| `y` | `y` | `y` | Copy file name | (nvim-tree default) |
| `Y` | `⇧ y` | `Shift+y` | Copy relative path | (nvim-tree default) |
| `gy` | `gy` | `gy` | Copy absolute path | (nvim-tree default) |

---

## 💻 Terminal

| Shortcut | Mac | Windows/Linux | Description | Source |
|----------|-----|---------------|-------------|--------|
| `` Ctrl+` `` | `` ⌃ ` `` | `` Ctrl+` `` | Open terminal below | `keymaps.lua:61` |
| `` Ctrl+` `` (in terminal) | `` ⌃ ` `` | `` Ctrl+` `` | Close terminal | `keymaps.lua:62` |
| `Esc` (in terminal) | `Esc` | `Esc` | Exit terminal mode | `keymaps.lua:63` |

---

## 🧠 LSP (Code Intelligence)

| Shortcut | Mac | Windows/Linux | Description | Source |
|----------|-----|---------------|-------------|--------|
| `gd` | `gd` | `gd` | Go to definition | `lsp.lua:57` |
| `K` | `⇧ k` | `Shift+k` | Hover documentation | `lsp.lua:58` |
| `Space rn` | `Space rn` | `Space rn` | Rename symbol | `lsp.lua:59` |
| `Space ca` | `Space ca` | `Space ca` | Code actions (fixes) | `lsp.lua:60` |
| `Space d` | `Space d` | `Space d` | Show error message | `lsp.lua:61` |
| `[d` | `[d` | `[d` | Previous error | `lsp.lua:62` |
| `]d` | `]d` | `]d` | Next error | `lsp.lua:63` |

---

## 📝 Autocomplete (nvim-cmp)

| Shortcut | Mac | Windows/Linux | Description | Source |
|----------|-----|---------------|-------------|--------|
| `Ctrl+Space` | `⌃ Space` | `Ctrl+Space` | Trigger completion | `lsp.lua:89` |
| `Enter` | `Enter` | `Enter` | Confirm selection | `lsp.lua:90` |
| `Tab` | `Tab` | `Tab` | Next suggestion | `lsp.lua:95` |
| `Shift+Tab` | `⇧ Tab` | `Shift+Tab` | Previous suggestion | `lsp.lua:102` |
| `↓` / `↑` | `↓` / `↑` | `↓` / `↑` | Navigate suggestions | `lsp.lua:91-92` |
| `Ctrl+d` | `⌃ d` | `Ctrl+d` | Scroll docs down | `lsp.lua:93` |
| `Ctrl+u` | `⌃ u` | `Ctrl+u` | Scroll docs up | `lsp.lua:94` |

---

## 🔀 Git (Gitsigns)

| Shortcut | Mac | Windows/Linux | Description | Source |
|----------|-----|---------------|-------------|--------|
| `Space ga` | `Space ga` | `Space ga` | Toggle blame annotation | `gitsigns.lua:22` |
| `Space gb` | `Space gb` | `Space gb` | Full blame popup | `gitsigns.lua:23` |
| `Space gp` | `Space gp` | `Space gp` | Preview hunk (diff) | `gitsigns.lua:24` |
| `Space gr` | `Space gr` | `Space gr` | Reset hunk | `gitsigns.lua:25` |
| `]g` | `]g` | `]g` | Next git change | `gitsigns.lua:26` |
| `[g` | `[g` | `[g` | Previous git change | `gitsigns.lua:27` |

---

## 🎨 Themes

| Shortcut | Mac | Windows/Linux | Description | Source |
|----------|-----|---------------|-------------|--------|
| `Space tt` | `Space tt` | `Space tt` | Toggle light/dark theme | `spec1.lua:52` |
| `Space tn` | `Space tn` | `Space tn` | Cycle to next theme | `spec1.lua:61` |

---

## ✏️ Editing

| Shortcut | Mac | Windows/Linux | Description | Source |
|----------|-----|---------------|-------------|--------|
| `jk` | `jk` | `jk` | Exit insert mode | `keymaps.lua:35` |
| `<` (visual) | `<` | `<` | Indent left (keep selection) | `keymaps.lua:31` |
| `>` (visual) | `>` | `>` | Indent right (keep selection) | `keymaps.lua:32` |
| `Space h` | `Space h` | `Space h` | Clear search highlight | `keymaps.lua:24` |
| `Option+j` | `⌥ j` | `Alt+j` | Move line down | `keymaps.lua:116` |
| `Option+k` | `⌥ k` | `Alt+k` | Move line up | `keymaps.lua:117` |

---

## 🚫 Disabled Keys

| Key | Reason |
|-----|--------|
| `↑` `↓` `←` `→` | Arrow keys disabled in normal mode (use `hjkl`) |

---

## 📌 Vim Essentials (Built-in)

| Shortcut | Description |
|----------|-------------|
| `/` | Search forward |
| `?` | Search backward |
| `n` / `N` | Next / previous search result |
| `Ctrl+o` | Jump back |
| `Ctrl+i` | Jump forward |
| `u` | Undo |
| `Ctrl+r` | Redo |
| `dd` | Delete line |
| `yy` | Copy line |
| `p` | Paste |
| `:%bd` | Close all buffers |
| `:%bd\|e#` | Close all except current |

---

## 🛠️ Useful Commands

| Command | Description |
|---------|-------------|
| `:Lazy` | Open plugin manager |
| `:Lazy sync` | Install/update plugins |
| `:Mason` | Open LSP installer |
| `:ConformInfo` | Check formatter status |
| `:Telescope live_grep glob_pattern=*.tsx` | Search in specific file type |
| `:source $MYVIMRC` | Reload config |
