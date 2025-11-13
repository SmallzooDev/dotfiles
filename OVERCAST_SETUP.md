# Overcast Theme Setup Complete

Your dotfiles have been successfully redesigned with the Overcast theme, inspired by Raycast's beautiful light color scheme!

## What Changed

All your development tools now use a cohesive **light theme** with muted blue-gray tones instead of the previous dark "coolnight" theme.

### Files Updated

1. **WezTerm** (`.wezterm.lua`)
   - Main background: Light blue-gray (#DCE4ED)
   - Terminal colors: Soft, muted palette
   - Tab bar: Clean white active tabs with gray inactive tabs

2. **FZF** (`.zshrc`)
   - Background: #DCE4ED
   - Foreground: #2C3E50
   - Highlight colors: Purple, blue, cyan, green accents

3. **Tmux** (`.tmux.conf`)
   - Status bar colors updated
   - Pane borders: Light gray (#C5D1DD) with blue active borders (#6B89C8)
   - Messages and mode styles updated

4. **Starship** (`starship.toml`)
   - New `overcast` palette added
   - Active palette switched from `coolnight` to `overcast`
   - All prompt colors now use soft blues, purples, and greens

5. **Neovim** (`nvim/lua/smallzoodev/plugins/colorscheme.lua`)
   - Switched to Tokyo Night "day" style
   - Custom Overcast colors applied
   - Background: #DCE4ED, Foreground: #2C3E50

6. **Lualine** (`nvim/lua/smallzoodev/plugins/lualine.lua`)
   - Status line colors match Overcast theme
   - Mode indicators use blue, green, purple, yellow, red

7. **Yazi** (file manager)
   - Created new `overcast.yazi` flavor
   - Updated `theme.toml` to use Overcast

8. **Color Reference** (`OVERCAST_PALETTE.md`)
   - Complete color palette documentation
   - All color codes organized by category

## How to Apply Changes

### Terminal & Shell
```bash
# Reload WezTerm config
# Just restart WezTerm or reload config (Cmd+R if configured)

# Reload shell config
source ~/.zshrc
```

### Tmux
```bash
# In tmux, press prefix (Ctrl+F) then:
prefix + r
# Or restart tmux sessions
```

### Neovim
```bash
# Reopen Neovim, or inside Neovim:
:source $MYVIMRC
```

### Yazi
```bash
# Restart Yazi - the new flavor will be loaded automatically
```

## Color Palette Quick Reference (EXACT Raycast Overcast)

### Primary Colors
- **Background**: #D8E5EB (light sky blue)
- **Foreground**: #0D296D (deep blue)
- **Non-emphasized**: #4A6798 (muted blue)
- **Blue**: #6B89C8 (soft blue)
- **Purple**: #9B7FCE (soft purple)
- **Green**: #3D9970 (vivid green - better contrast)
- **Yellow**: #E8B563 (golden yellow)
- **Red**: #E07A7A (soft red)
- **Cyan**: #5FC9D8 (soft cyan)

### UI Elements
- **Border**: #B8CFDD
- **Selection**: #C5D8ED (emphasized background)
- **Cursor**: #6B89C8

## Switching Back to Coolnight (If Needed)

If you want to switch back to the dark coolnight theme:

1. **Starship**: Edit `starship.toml`, change `palette = 'overcast'` to `palette = 'coolnight'`
2. **Yazi**: Edit `yazi/theme.toml`, change flavors back to `catppuccin-mocha`
3. **Neovim, WezTerm, FZF, Tmux**: You can restore from git history or manually update colors

The old coolnight palette is preserved in `starship.toml` for reference.

## Tips

1. **Colors**: EXACT Raycast Overcast colors:
   - Background: `#D8E5EB`
   - Foreground: `#0D296D`
   - Non-emphasized: `#4A6798`
   - Selection: `#C5D8ED`

2. **Transparency**: WezTerm transparency is currently disabled. To enable:
   - Uncomment the opacity lines in `.wezterm.lua`

3. **Further Customization**:
   - All color values are clearly commented
   - Refer to `OVERCAST_PALETTE.md` for the complete palette
   - Colors can be tweaked to your preference

## Enjoy Your New Theme!

Your development environment now has a cohesive, professional light theme across all tools. The soft blue-gray tones are easy on the eyes while maintaining excellent readability.
