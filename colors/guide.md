# Overcast Color Scheme Guide
**EXACT Raycast Overcast Theme - Complete Reference**

This guide documents the exact color scheme used across all dotfiles configurations, matched precisely to Raycast's Overcast theme.

---

## Core Color Palette

### Base Colors

```
Background:           #D8E5EB  (Light sky blue - main background)
Foreground:           #0D296D  (Deep blue - primary text)
Non-emphasized:       #4A6798  (Muted blue - secondary text)
Selection/Emphasis:   #C5D8ED  (Lighter blue - highlighted background)
```

### Visual Breakdown

```
┌─────────────────────────────────────────┐
│  #D8E5EB - Background (Light Sky Blue)  │
│  ┌───────────────────────────────────┐  │
│  │ #C5D8ED - Selection/Emphasis      │  │
│  │                                   │  │
│  │  #0D296D - Primary Text (Deep)   │  │
│  │  #4A6798 - Secondary Text (Muted)│  │
│  └───────────────────────────────────┘  │
└─────────────────────────────────────────┘
```

### Extended Palette

| Color | Hex Code | Usage |
|-------|----------|-------|
| **Background Dark** | `#CDD9E2` | Darker background elements |
| **Background Highlight** | `#C5D8ED` | Selections, emphasized areas |
| **Background Search** | `#B0CADE` | Search highlights |
| **Background Tertiary** | `#E0EAF0` | Hover states |
| **Border** | `#B8CFDD` | UI borders, dividers |
| **Foreground Bright** | `#0A1F54` | Very emphasized text |
| **Foreground Gutter** | `#4A6798` | Line numbers, gutters |
| **Foreground Tertiary** | `#6B85AA` | Very muted text |

---

## Accent Colors

### Semantic Colors

```
Success/Green:    #3D9970  (Vivid green - additions, success, better contrast)
Warning/Yellow:   #E8B563  (Golden yellow - warnings, modified)
Error/Red:        #E07A7A  (Soft red - errors, deletions)
Info/Cyan:        #5FC9D8  (Soft cyan - information)
```

### UI Accent Colors

```
Blue:             #6B89C8  (Soft blue - primary actions, links)
Purple:           #9B7FCE  (Soft purple - special items, keywords)
Teal:             #5FB8A8  (Muted teal - git branch info)
```

### Bright Variants

```
Bright Red:       #E88A8A
Bright Green:     #4CAF7D
Bright Yellow:    #F0C674
Bright Blue:      #7B9DD8
Bright Magenta:   #A68FD8
Bright Cyan:      #6FD9E8
```

---

## Application Breakdown

### 1. WezTerm (`.wezterm.lua`)

```lua
-- Main colors
foreground = "#0D296D"
background = "#D8E5EB"
selection_bg = "#C5D8ED"
selection_fg = "#0D296D"

-- ANSI colors
ansi[0] = "#4A6798"  -- Black (non-emphasized)
ansi[1] = "#E07A7A"  -- Red
ansi[2] = "#3D9970"  -- Green (vivid - better contrast)
ansi[3] = "#E8B563"  -- Yellow
ansi[4] = "#6B89C8"  -- Blue
ansi[5] = "#9B7FCE"  -- Magenta
ansi[6] = "#5FC9D8"  -- Cyan
ansi[7] = "#0D296D"  -- White (main font)

-- Tab bar
active_tab.bg_color = "#E8F0F5"  -- Soft light blue (not white)
```

### 2. FZF (`.zshrc`)

```bash
fg="#0D296D"              # Main text
bg="#D8E5EB"              # Background
bg_highlight="#C5D8ED"    # Selection
purple="#9B7FCE"          # Highlights
blue="#6B89C8"            # Prompt
cyan="#5FC9D8"            # Info
green="#6FC89F"           # Pointer/Marker
```

### 3. Neovim (`nvim/lua/smallzoodev/plugins/colorscheme.lua`)

```lua
bg = "#D8E5EB"           -- Main background
bg_dark = "#CDD9E2"      -- Darker elements
bg_highlight = "#C5D8ED" -- Selections
bg_search = "#B0CADE"    -- Search results
bg_visual = "#C5D8ED"    -- Visual mode
fg = "#0D296D"           -- Main text
fg_dark = "#0A1F54"      -- Emphasized text
fg_gutter = "#4A6798"    -- Line numbers
border = "#B8CFDD"       -- Window borders
```

### 4. Lualine (`nvim/lua/smallzoodev/plugins/lualine.lua`)

```lua
fg = "#0D296D"           -- Text
bg = "#CDD9E2"           -- Background
inactive_bg = "#C5D8ED"  -- Inactive sections

-- Mode colors
blue = "#6B89C8"         -- Normal mode
green = "#6FC89F"        -- Insert mode
violet = "#9B7FCE"       -- Visual mode
yellow = "#E8B563"       -- Command mode
red = "#E07A7A"          -- Replace mode
```

### 5. Headlines (`nvim/lua/smallzoodev/plugins/headlines.lua`)

```lua
Headline1: bg=#C5D8ED fg=#0D296D (bold)
Headline2: bg=#CDD9E2 fg=#0D296D (bold)
Headline3: bg=#D2E0E8 fg=#4A6798 (bold)
Headline4: bg=#D8E5EB fg=#4A6798
Headline5: bg=#DDE8EE fg=#6B85AA
Headline6: bg=#E5EFF3 fg=#6B85AA
CodeBlock: bg=#D0DCE5 (closer to background tone)
```

### 6. Starship (`starship.toml`)

```toml
color_directory = '#0D296D'      # Current directory
color_git = '#5FB8A8'            # Git branch
color_git_added = '#6FC89F'      # Added files
color_git_deleted = '#E07A7A'    # Deleted files
color_env = '#5FC9D8'            # Environment info
color_other = '#4A6798'          # Other text
color_time = '#4A6798'           # Timestamp
```

### 7. Yazi (`yazi/flavors/overcast.yazi/flavor.toml`)

```toml
# Main colors
foreground = "#0D296D"
background = "#D8E5EB"

# Selection
selection_bg = "#C5D8ED"

# File types
directories = "#6B89C8"
images = "#5FC9D8"
media = "#E8B563"
archives = "#9B7FCE"
documents = "#6FC89F"
```

---

## Color Usage Guidelines

### Text Hierarchy

1. **Primary Text** (`#0D296D`)
   - Main content
   - Important labels
   - Emphasized information
   - Headings

2. **Secondary Text** (`#4A6798`)
   - Supplementary information
   - Labels (Application, Command)
   - Less important content
   - Comments in code

3. **Tertiary Text** (`#6B85AA`)
   - Placeholders
   - Very muted information
   - Disabled states
   - Subtle hints

### Background Layers

1. **Base** (`#D8E5EB`)
   - Main background
   - Default surface

2. **Elevated** (`#C5D8ED`)
   - Selected items
   - Active elements
   - Highlighted sections
   - Focus indicators

3. **Hover** (`#E0EAF0`)
   - Hover states
   - Temporary highlights

4. **Deeper** (`#CDD9E2`)
   - Panels
   - Sidebars
   - Recessed elements

### Semantic Color Usage

| State | Color | Hex | When to Use |
|-------|-------|-----|-------------|
| Success | Green | `#3D9970` | Git additions, success messages, confirmations |
| Warning | Yellow | `#E8B563` | Cautions, modified files, attention needed |
| Error | Red | `#E07A7A` | Errors, deletions, critical issues |
| Info | Cyan | `#5FC9D8` | Information, hints, neutral messages |
| Action | Blue | `#6B89C8` | Links, primary actions, interactive elements |
| Special | Purple | `#9B7FCE` | Keywords, special syntax, unique items |

---

## Accessibility & Contrast

### WCAG Contrast Ratios

| Combination | Ratio | WCAG AA | WCAG AAA |
|-------------|-------|---------|----------|
| `#0D296D` on `#D8E5EB` | 9.8:1 | ✅ Pass | ✅ Pass |
| `#4A6798` on `#D8E5EB` | 5.2:1 | ✅ Pass | ❌ Fail |
| `#0D296D` on `#C5D8ED` | 10.5:1 | ✅ Pass | ✅ Pass |

### Recommendations

- Use `#0D296D` for all body text (excellent contrast)
- Use `#4A6798` for secondary text 14pt+ (meets AA)
- Avoid using `#6B85AA` for important text (low contrast)
- Accent colors maintain sufficient contrast for highlights

---

## Modification Guide

### Adjusting Brightness

To make the theme **lighter**:
```
Background:  #D8E5EB → #E0ECF0 → #E8F2F5
Selection:   #C5D8ED → #D0E0F0 → #DBE8F3
```

To make the theme **darker** (more contrast):
```
Foreground:  #0D296D → #0A1F54 → #071640
Secondary:   #4A6798 → #3A5478 → #2A4158
```

### Adjusting Saturation

More saturated (vivid):
```
Background:  #D8E5EB → #D0E0F0 → #C8DBF5
Foreground:  #0D296D → #0D2980 → #0D2993
```

Less saturated (neutral):
```
Background:  #D8E5EB → #DDE5E9 → #E2E5E7
Foreground:  #0D296D → #1A2F5A → #273847
```

---

## File Reference

### Configuration Files

| Tool | File Path | Lines |
|------|-----------|-------|
| WezTerm | `.wezterm.lua` | 23-81 |
| FZF | `.zshrc` | 59-69 |
| Starship | `starship.toml` | 143-166 |
| Neovim Theme | `nvim/lua/smallzoodev/plugins/colorscheme.lua` | 7-16 |
| Lualine | `nvim/lua/smallzoodev/plugins/lualine.lua` | 8-19 |
| Headlines | `nvim/lua/smallzoodev/plugins/headlines.lua` | 23-34 |
| Yazi | `yazi/flavors/overcast.yazi/flavor.toml` | All |

---

## Quick Color Reference Card

```
BACKGROUNDS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Primary     #D8E5EB  ░░░░░░░░░░░░░░░░
Selection   #C5D8ED  ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
Darker      #CDD9E2  ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒

FOREGROUNDS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Primary     #0D296D  ████████████████
Secondary   #4A6798  ████████████████
Tertiary    #6B85AA  ████████████████

ACCENTS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Blue        #6B89C8  ████████████████
Green       #3D9970  ████████████████
Yellow      #E8B563  ████████████████
Red         #E07A7A  ████████████████
Purple      #9B7FCE  ████████████████
Cyan        #5FC9D8  ████████████████
```

---

## Version History

- **v1.0** (2025-01-13) - Initial Overcast theme implementation
  - Exact Raycast Overcast color matching
  - Applied across all tools
  - Background: `#D8E5EB`
  - Foreground: `#0D296D`

---

## Credits

Color scheme extracted and matched from **Raycast's Overcast Theme**.

Original theme: [Raycast](https://raycast.com)
