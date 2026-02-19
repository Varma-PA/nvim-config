# Neovim Keyboard Shortcuts Reference

> **Leader key:** `Space`  
> **Note:** On Mac, `Ctrl` = `⌃`, `Option/Alt` = `⌥`, `Shift` = `⇧`

---

## 📁 File & quit

| Shortcut | Description |
|----------|-------------|
| `Space w` | Save file |
| `Ctrl+s` | Save file (normal mode) |
| `Ctrl+s` (insert) | Save file and stay in insert |
| `Space q` | Quit window |
| `Space Q` | Quit all (no save) |

---

## 🪟 Window & splits

| Shortcut | Description |
|----------|-------------|
| `Ctrl+h` / `Ctrl+j` / `Ctrl+k` / `Ctrl+l` | Move focus between windows (vim-tmux-navigator) |
| `Space sv` | Vertical split |
| `Space sh` | Horizontal split |
| `Space sx` | Close current split |
| `Option+↑` / `Option+↓` | Resize split height |
| `Option+←` / `Option+→` | Resize split width |

---

## 📑 Buffers

| Shortcut | Description |
|----------|-------------|
| `Space x` | Close current buffer (smart: focus tree if last) |
| `Space bb` | Switch to previous buffer (`b#`) |

---

## 🌲 File tree (NvimTree)

| Shortcut | Description |
|----------|-------------|
| `Space e` | Toggle file tree |
| `Enter` | Open file |
| `Ctrl+v` | Open in vertical split |
| `Ctrl+x` | Open in horizontal split |
| `F` | **Start live filter** (type to filter tree) |
| `f` | **Clear live filter** |
| `g?` | Show all tree keymaps |
| `y` | Copy file name |
| `Y` | Copy relative path |
| `gy` | Copy absolute path |

---

## 🔍 Telescope

| Shortcut | Description |
|----------|-------------|
| `Space ff` | Find files |
| `Space fg` | Live grep (search in files) |
| `Space fw` | Live grep whole word only |
| `Space fb` | List buffers |
| `Space fd` | List diagnostics (Enter to jump to line) |
| `Space /` | Find in current buffer (fuzzy) |

---

## 🧠 LSP (when attached)

| Shortcut | Description |
|----------|-------------|
| `gd` | Go to definition (current window) |
| `gD` | Go to definition in **vertical split** |
| `K` | Hover / documentation |
| `Space rn` | Rename symbol |
| `Space ca` | Code action (quick fix, etc.) |
| `Space d` | Show diagnostic under cursor |
| `[d` | Previous diagnostic |
| `]d` | Next diagnostic |

---

## ✏️ Editing & quality of life

| Shortcut | Description |
|----------|-------------|
| `jk` (insert) | Exit insert mode |
| `Space h` | Clear search highlight |
| `v` then `<` / `>` | Indent selection (keeps selection) |
| `Space b` (normal) | Wrap word in `()` |
| `Space B` (normal) | Wrap word in `[]` |
| `Space b` (visual) | Wrap selection in `()` |
| `Space B` (visual) | Wrap selection in `[]` |
| `Option+j` | Move line down |
| `Option+k` | Move line up |
| `Option+j` / `Option+k` (visual) | Move selection down / up |

---

## 💻 Terminal

| Shortcut | Description |
|----------|-------------|
| `` Ctrl+` `` | Open terminal below |
| `Space tv` | Open terminal in vertical split (right) |
| `` Ctrl+` `` (in terminal) | Close terminal |
| `Esc` (in terminal) | Exit terminal mode |

---

## 🎨 Themes

| Shortcut | Description |
|----------|-------------|
| `Space tt` | Toggle light / dark theme |
| `Space tn` | Cycle to next theme in current mode |

---

## 🔀 Git (Gitsigns)

| Shortcut | Description |
|----------|-------------|
| `Space ga` | Toggle line blame |
| `Space gb` | Blame line (popup) |
| `Space gp` | Preview hunk |
| `Space gr` | Reset hunk |
| `]g` | Next change |
| `[g` | Previous change |

---

## 📝 Autocomplete (insert mode)

| Shortcut | Description |
|----------|-------------|
| `Ctrl+Space` | Open completion menu |
| `Enter` | Confirm selection |
| `Tab` / `Shift+Tab` | Next / previous item |
| `↑` / `↓` | Move in list |
| `Ctrl+d` / `Ctrl+u` | Scroll docs |

---

## 📝 Markdown

| Shortcut | Description |
|----------|-------------|
| `Space mp` | Toggle Markdown preview |

---

## 🚫 Disabled

| Key | Note |
|-----|------|
| `↑` `↓` `←` `→` | Arrow keys disabled in normal mode (use `hjkl`) |

---

## 📌 Vim basics

| Shortcut | Description |
|----------|-------------|
| `/` / `?` | Search forward / backward |
| `n` / `N` | Next / previous match |
| `Ctrl+o` / `Ctrl+i` | Jump back / forward |
| `u` / `Ctrl+r` | Undo / redo |
| `dd` / `yy` / `p` | Delete line / yank line / paste |

---

## 🛠️ Commands

| Command | Description |
|---------|-------------|
| `:Lazy` | Plugin manager |
| `:Lazy sync` | Install/update plugins |
| `:Mason` | LSP/formatter installer |
| `:source $MYVIMRC` | Reload config |
