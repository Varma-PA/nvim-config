# How to Add a Plugin to This Neovim Config

This config uses **[lazy.nvim](https://github.com/folke/lazy.nvim)** as the plugin manager. Plugins are declared as **specs** (Lua tables) and are loaded from the `lua/plugins/` directory.

---

## 1. Where Plugins Live

- **Plugin specs:** `lua/plugins/*.lua`  
  Every `.lua` file in `lua/plugins/` is automatically loaded by lazy.nvim (via `{ import = "plugins" }` in `lua/config/lazy.lua`).
- **Keymaps:** `lua/keymaps.lua`  
  Add keybindings for your plugin here so they stay in one place.

You can either **add a new file** for a plugin or **add a spec to an existing file** that returns a list of plugins (e.g. `spec1.lua`, `lsp.lua`).

---

## 2. Add a New Plugin (New File)

### Step 1: Create a spec file

Create a new file under `lua/plugins/` named after the plugin (e.g. `my-plugin.lua`). The file must **return a single plugin spec** (a table) or **a list of specs** (a table of tables).

**Minimal example (no config):**

```lua
-- lua/plugins/my-plugin.lua
return {
  "author/repo-name",
  -- optional: lazy = false, dependencies = { ... }, etc.
}
```

**Example with a short comment:**

```lua
-- lua/plugins/vim-surround.lua (example)
return {
  "tpope/vim-surround",
  -- No config needed; keybindings work out of the box.
}
```

Use the **GitHub repo** in the form `"owner/repo"`. Lazy will clone it into its data directory and load it.

### Step 2: Install the plugin

- Restart Neovim, or  
- Run **`:Lazy sync`** (or **`:Lazy`** and use the UI to install/sync).

New plugins are installed automatically when Neovim starts or when you sync.

### Step 3: Add keymaps (if needed)

If the plugin has commands or functions you want to trigger with keys, add them in **`lua/keymaps.lua`**:

```lua
-- Example: open MyPlugin
keymap("n", "<leader>mp", "<cmd>MyPluginOpen<CR>", { desc = "Open MyPlugin" })
```

Reload config (`:source $MYVIMRC`) or restart to pick up keymap changes.

---

## 3. Plugin Spec Options You’ll Use

A **spec** is a Lua table. The first element is the plugin identifier `"owner/repo"`. The rest are optional keys.

### Basic

| Key           | Type    | Description |
|---------------|---------|-------------|
| `"owner/repo"` | string  | **Required.** GitHub repository. |
| `lazy`       | boolean | If `true`, plugin loads only when needed (e.g. command/event). Default can be lazy. |
| `priority`   | number  | Higher = load earlier. Useful for themes (e.g. `1000`). |
| `version`    | string  | Pin to a branch/tag, e.g. `"v1.0"` or `"main"`. |

### Dependencies

| Key             | Type  | Description |
|-----------------|-------|-------------|
| `dependencies` | table | List of `"owner/repo"` or spec tables. Lazy installs and loads them first. |

Example:

```lua
return {
  "user/plugin",
  dependencies = {
    "user/other-plugin",
    { "user/optional-plugin", optional = true },
  },
}
```

### Loading and build

| Key     | Type   | Description |
|---------|--------|-------------|
| `build` | string | Run once after install (e.g. `":TSUpdate"`, `"make"`). |
| `ft`    | string or table | Load only for these file types (e.g. `"python"` or `{ "rust", "toml" }`). |
| `cmd`   | string or table | Load when one of these commands is run. |
| `keys`  | table | Load when one of these key sequences is pressed. |
| `event` | string or table | Load on events (e.g. `"BufReadPre"`). |

### Configuration

| Key      | Type     | Description |
|----------|----------|-------------|
| `config` | function | Run after the plugin is loaded. Use to call `setup()` or set options. |
| `opts`   | table    | Options passed to the plugin’s `setup(opts)` if it supports it (many do). |
| `init`   | function | Run before the plugin is loaded (rare). |

---

## 4. Examples From This Config

### No config (just the repo)

```lua
-- lua/plugins/surround.lua
return {
  "tpope/vim-surround",
}
```

### With dependencies and build

```lua
-- lua/plugins/telescope.lua
return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
}
```

### With `config` (custom setup)

```lua
-- lua/plugins/tree-view.lua (simplified)
return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("nvim-web-devicons").setup()
    require("nvim-tree").setup({
      -- your options here
    })
  end,
}
```

### With `opts` (plugin calls `setup(opts)`)

```lua
-- lua/plugins/lualine.lua (simplified)
return {
  "nvim-lualine/lualine.nvim",
  opts = {
    options = { theme = "auto" },
    sections = { ... },
  },
}
```

### Multiple plugins in one file

Return a **list** of specs (used in this config in `lsp.lua` and `spec1.lua`):

```lua
-- lua/plugins/my-plugins.lua
return {
  { "user/plugin-a", config = function() ... end },
  { "user/plugin-b", dependencies = { "user/plugin-a" } },
}
```

---

## 5. Checklist When Adding a Plugin

1. **Create** `lua/plugins/<name>.lua` (or add a spec to an existing file that returns a list).
2. **Return** a single spec table or a table of spec tables.
3. **Set** `dependencies` if the plugin’s README or docs list any.
4. **Set** `config` or `opts` if the plugin has a `setup()` or needs configuration.
5. **Set** `build` if the plugin’s README says to run a command after install (e.g. `make`, `:TSUpdate`).
6. **Run** `:Lazy sync` (or restart Neovim) to install.
7. **Add** any keybindings in `lua/keymaps.lua`.

---

## 6. Useful Commands

| Command        | Description |
|----------------|-------------|
| `:Lazy`        | Open the lazy.nvim UI (browse, install, update, clean). |
| `:Lazy sync`   | Install missing plugins and update lockfile. |
| `:Lazy update` | Update all plugins. |
| `:Lazy clean`  | Remove plugins no longer in your spec. |
| `:source $MYVIMRC` | Reload init and config (keymaps, etc.). |

---

## 7. Finding the Repo and Options

- **Repo:** Search “plugin name nvim” or “plugin name vim” on GitHub; use `owner/repo` (e.g. `folke/tokyonight.nvim`).
- **Options:** In the repo, check the README and the `lua/` folder for `setup()` or `config` examples; match keys to `opts` or use a `config` function that calls `setup(...)`.

---

## 8. Quick Reference: One File Per Plugin

```lua
-- lua/plugins/example.lua
return {
  "owner/repo",
  lazy = false,           -- load at startup (optional)
  priority = 100,         -- load order (optional)
  dependencies = { "other/plugin" },
  build = "make",        -- run after install (optional)
  config = function()
    require("repo").setup({ ... })
  end,
  -- OR use opts if the plugin supports it:
  -- opts = { option = value },
}
```

After editing, run **`:Lazy sync`** and add keymaps in **`lua/keymaps.lua`** if needed.
