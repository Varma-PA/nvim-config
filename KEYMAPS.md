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
| `Space ca` | Code action (quick fix, etc.). On a line with diagnostics: **Ask opencode to explain** / **Ask opencode to fix** when Opencode LSP is enabled |
| `Ctrl+q` | Same as `Space ca` (normal + visual when LSP attached) |
| `Space d` | Show diagnostic under cursor |
| `[d` | Previous diagnostic |
| `]d` | Next diagnostic |

---

## 🤖 Opencode (opencode.nvim)

Leader prefix **`Space o`** (`<leader>o`). Keymaps live in `lua/keymaps.lua` (registered on `LazyDone`). Snacks integration: `lua/plugins/opencode.lua`.

**Context in prompts:** Type placeholders in any ask prompt (`Space oa`, `Ctrl+a`), or use the shortcuts below. Each resolves to a **path or location** OpenCode can read — the **whole file** is included when you use **`@buffer`** (current buffer’s file on disk). **Save the buffer** before asking if you need unsaved changes in context. Other built-ins from opencode.nvim include `@buffers` (open listed buffers), `@visible` (visible lines in windows), `@diff` (git diff), `@diagnostics` (buffer diagnostics).

| Shortcut | Mode | Description |
|----------|------|-------------|
| `Space oa` | Normal, visual | Ask / prompt (uses `@this`) |
| `Space os` | Normal, visual | Opencode palette (prompts, session, commands) |
| `Space ot` | Normal, **terminal** | Toggle Opencode panel |
| `Space ox` | Normal, **terminal** | Interrupt current session |
| `Space on` | Normal | New session |
| `Space ou` | Normal | Undo last action in session |
| `Space oR` | Normal | Redo last undone action (`R` = Shift+r) |
| `Space oS` | Normal | Select session |
| `Space oc` | Normal | Compact session (shrink context) |
| `Space od` | Normal, visual | Ask about diagnostics (`@diagnostics` + `@this`) |
| `Space ob` | Normal, visual | Ask with **full file** + cursor/selection (`@buffer` + `@this`; canned “review” prompt) |
| `go` | Normal, visual | Operator: send range to Opencode prompt |
| `goo` | Normal | Operator: send current line to prompt |
| `Shift+Ctrl+u` / `Shift+Ctrl+d` | Normal | Scroll Opencode transcript half a page |
| `Ctrl+a` | Normal, visual | Same as `Space oa` (replaces default increment; use `+`) |
| `Ctrl+x` | Normal, visual | Same as `Space os` (replaces default decrement; use `-`) |
| `Ctrl+.` | Normal, **terminal** | Same as `Space ot` |
| `+` / `-` | Normal | Increment / decrement number (workaround while `Ctrl+a` / `Ctrl+x` are mapped) |
| `Alt+a` | Insert (Snacks picker input) | Send from picker to Opencode (`<a-a>` in config) |

**Permission diff** (when OpenCode asks to edit a file): buffer-local keys — `da` accept whole edit, `dr` reject, `q` close tab; see opencode.nvim README for hunk keys (`dp` / `do`).

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

## 💬 Comments (mini.comment)

| Shortcut | Description |
|----------|-------------|
| `gcc` | Toggle comment on **current line** |
| `gc` + motion | Toggle comment for **motion** (e.g. `gc3j` = 3 lines, `gcip` = inner paragraph) |
| `gc` (visual) | Toggle comment on **selection** |
| `gc` as textobject | Use with operators (e.g. `dgc` = delete comment, `vac` = select around comment) |

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

## 💾 Session restore (persistence.nvim)

| Shortcut | Description |
|----------|-------------|
| `Space sl` | Restore session for **current directory** (reopen last buffers/layout for this project) |
| `Space sL` | Restore **last session** (any directory) |
| `Space sS` | **Select** which saved session to restore |
| `Space sd` | **Don’t save** session on exit (for this session only) |

Sessions are saved automatically when you quit Neovim (per directory, and per git branch if `branch = true`).

---

## 🛠️ Commands

| Command | Description |
|---------|-------------|
| `:Lazy` | Plugin manager |
| `:Lazy sync` | Install/update plugins |
| `:Mason` | LSP/formatter installer |
| `:source $MYVIMRC` | Reload config |
