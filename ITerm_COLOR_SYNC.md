# iTerm Color Sync Guide

## Automatic Color Syncing

The Neovim configuration now automatically syncs iTerm tab colors with light themes. When you switch to a light theme using `<leader>tt` or `<leader>tn`, the iTerm tab bar and status bar should automatically change to match.

## Manual Configuration (If Automatic Doesn't Work)

If the automatic syncing doesn't work, you can manually configure iTerm to match your Neovim themes:

### Method 1: Create iTerm Color Schemes

1. **Download matching iTerm color schemes:**
   - For **rose-pine-dawn**: Search for "rose-pine" iTerm color scheme
   - For **tokyonight-day**: Search for "tokyonight" iTerm color scheme
   - For **catppuccin-latte**: Search for "catppuccin" iTerm color scheme
   - For **gruvbox**: Search for "gruvbox" iTerm color scheme

2. **Import the color scheme:**
   - Open iTerm2 → Preferences → Profiles → Colors
   - Click "Color Presets" → "Import..."
   - Select the downloaded `.itermcolors` file
   - Select it from the "Color Presets" dropdown

3. **Switch profiles when changing themes:**
   - Create separate iTerm profiles for each light theme
   - Switch profiles manually when you change Neovim themes

### Method 2: Use iTerm Dynamic Profile Colors

1. **Enable dynamic colors in iTerm:**
   - iTerm2 → Preferences → Profiles → Colors
   - Check "Use background color for tab bar" (if available)

2. **Set background color manually:**
   - For each light theme, note the background color:
     - **rose-pine-dawn**: `#faf4ed`
     - **tokyonight-day**: `#e1e2e7`
     - **catppuccin-latte**: `#eff1f5`
     - **gruvbox**: `#fbf1c7`
     - **github_light**: `#ffffff`
     - **PaperColor**: `#eeeeee`
     - **ayu-light**: `#fafafa`

3. **Create separate profiles:**
   - Duplicate your current profile for each theme
   - Set the background color in each profile
   - Name them appropriately (e.g., "Neovim - Rose Pine Dawn")

### Method 3: Use Shell Script (Advanced)

Create a script that changes iTerm colors based on the current theme:

```bash
#!/bin/bash
# Save as ~/.local/bin/iterm-theme-sync.sh

THEME=$1
case $THEME in
  "rose-pine-dawn")
    osascript -e 'tell application "iTerm2" to tell current window to tell current tab to set background color to {64250, 62780, 60652}'
    ;;
  "tokyonight-day")
    osascript -e 'tell application "iTerm2" to tell current window to tell current tab to set background color to {57669, 57890, 59175}'
    ;;
  "catppuccin-latte")
    osascript -e 'tell application "iTerm2" to tell current window to tell current tab to set background color to {61423, 61681, 62965}'
    ;;
  # Add more themes as needed
esac
```

Then call it from Neovim when switching themes.

## Troubleshooting

### iTerm tabs still dark after switching themes

1. **Check if you're using iTerm2** (not iTerm)
2. **Verify AppleScript permissions:**
   - System Preferences → Security & Privacy → Privacy → Automation
   - Make sure Terminal/Neovim has permission to control iTerm2

3. **Try manual escape sequences:**
   - The configuration uses iTerm escape sequences which should work automatically
   - If not, you may need to enable "Allow escape sequences" in iTerm preferences

4. **Restart iTerm** after making changes

### Colors don't match exactly

- The automatic syncing uses approximate colors
- For exact matching, use Method 1 (import color schemes)
- Some themes may need manual adjustment

## Quick Reference: Theme Background Colors

| Theme | Hex Color | RGB (0-65535) |
|-------|-----------|---------------|
| rose-pine-dawn | `#faf4ed` | 64250, 62780, 60652 |
| tokyonight-day | `#e1e2e7` | 57669, 57890, 59175 |
| catppuccin-latte | `#eff1f5` | 61423, 61681, 62965 |
| gruvbox | `#fbf1c7` | 64507, 61903, 51143 |
| github_light | `#ffffff` | 65535, 65535, 65535 |
| PaperColor | `#eeeeee` | 61166, 61166, 61166 |
| ayu-light | `#fafafa` | 64250, 64250, 64250 |
