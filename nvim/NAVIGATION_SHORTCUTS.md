# Neovim Navigation Shortcuts Documentation

## Leader Key
- **Leader**: `<Space>`

## Git Navigation (Gitsigns)
| Shortcut | Description |
|----------|-------------|
| `]h` | Next git hunk (diff) |
| `[h` | Previous git hunk (diff) |
| `<leader>hp` | Preview hunk |
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |
| `<leader>hS` | Stage entire buffer |
| `<leader>hR` | Reset entire buffer |
| `<leader>hu` | Undo stage hunk |
| `<leader>hb` | Blame line (full) |
| `<leader>hB` | Toggle line blame |
| `<leader>hd` | Diff this file |
| `<leader>hD` | Diff this file against HEAD~ |
| `ih` | Select hunk (text object in visual/operator mode) |

## LSP Navigation
| Shortcut | Description |
|----------|-------------|
| `gR` | Show LSP references (Telescope) |
| `gD` | Go to declaration |
| `gd` | Show LSP definitions (Telescope) |
| `gi` | Show LSP implementations (Telescope) |
| `gt` | Show LSP type definitions (Telescope) |
| `K` | Show hover documentation |
| `[d` | Previous diagnostic |
| `]d` | Next diagnostic |
| `<leader>d` | Show line diagnostics |
| `<leader>D` | Show buffer diagnostics (Telescope) |
| `<leader>ca` | Code actions |
| `<leader>rn` | Smart rename |

## Code Navigation (Treesitter Text Objects)
### Jump to Next
| Shortcut | Description |
|----------|-------------|
| `]f` | Next function call start |
| `]F` | Next function call end |
| `]m` | Next method/function definition start |
| `]M` | Next method/function definition end |
| `]c` | Next class start |
| `]C` | Next class end |
| `]i` | Next conditional start |
| `]I` | Next conditional end |
| `]l` | Next loop start |
| `]L` | Next loop end |
| `]s` | Next scope |
| `]z` | Next fold |

### Jump to Previous
| Shortcut | Description |
|----------|-------------|
| `[f` | Previous function call start |
| `[F` | Previous function call end |
| `[m` | Previous method/function definition start |
| `[M` | Previous method/function definition end |
| `[c` | Previous class start |
| `[C` | Previous class end |
| `[i` | Previous conditional start |
| `[I` | Previous conditional end |
| `[l` | Previous loop start |
| `[L` | Previous loop end |

### Text Object Selection
| Shortcut | Description |
|----------|-------------|
| `af` | Select outer function call |
| `if` | Select inner function call |
| `am` | Select outer method/function |
| `im` | Select inner method/function |
| `ac` | Select outer class |
| `ic` | Select inner class |
| `ai` | Select outer conditional |
| `ii` | Select inner conditional |
| `al` | Select outer loop |
| `il` | Select inner loop |
| `aa` | Select outer parameter |
| `ia` | Select inner parameter |
| `a=` | Select outer assignment |
| `i=` | Select inner assignment |
| `l=` | Select left side of assignment |
| `r=` | Select right side of assignment |

### Swap Elements
| Shortcut | Description |
|----------|-------------|
| `<leader>na` | Swap parameter with next |
| `<leader>pa` | Swap parameter with previous |
| `<leader>nm` | Swap function with next |
| `<leader>pm` | Swap function with previous |
| `<leader>n:` | Swap object property with next |
| `<leader>p:` | Swap object property with previous |

## TODO Comments Navigation
| Shortcut | Description |
|----------|-------------|
| `]t` | Next TODO comment |
| `[t` | Previous TODO comment |
| `<leader>xt` | Open TODOs in Trouble |
| `<leader>ft` | Find TODOs (Telescope) |

## File & Search Navigation (Telescope)
| Shortcut | Description |
|----------|-------------|
| `<leader>ff` | Find files in current directory |
| `<leader>fr` | Find recent files |
| `<leader>fs` | Live grep (search text in files) |
| `<leader>fc` | Find string under cursor |
| `<leader>fk` | Find keymaps |
| **In Telescope:** | |
| `<C-j>` | Move to next result |
| `<C-k>` | Move to previous result |
| `<C-q>` | Send to quickfix list |
| `<C-t>` | Open in Trouble |

## Flash Navigation (Quick Jump)
| Shortcut | Description |
|----------|-------------|
| `s` | Flash jump to character |
| `S` | Flash treesitter jump |
| `r` | Remote flash (operator mode) |
| `R` | Treesitter search |
| `<C-s>` | Toggle flash search (command mode) |

## Diagnostics & Trouble
| Shortcut | Description |
|----------|-------------|
| `<leader>xw` | Toggle workspace diagnostics (Trouble) |
| `<leader>xd` | Toggle document diagnostics (Trouble) |
| `<leader>xq` | Toggle quickfix list (Trouble) |
| `<leader>xl` | Toggle location list (Trouble) |

## General Navigation
| Shortcut | Description |
|----------|-------------|
| `jk` | Exit insert mode |
| `;` | Repeat last move |
| `,` | Repeat last move in opposite direction |
| `f/F/t/T` | Standard vim character search (repeatable with `;` and `,`) |

## Window & Tab Management
| Shortcut | Description |
|----------|-------------|
| `<leader>sv` | Split window vertically |
| `<leader>sh` | Split window horizontally |
| `<leader>se` | Make splits equal size |
| `<leader>sx` | Close current split |
| `<leader>to` | Open new tab |
| `<leader>tx` | Close current tab |
| `<leader>tn` | Go to next tab |
| `<leader>tp` | Go to previous tab |
| `<leader>tf` | Open current buffer in new tab |

## Tips for Git Diff Navigation
1. **Primary git diff navigation**: Use `]h` and `[h` to jump between git hunks (changes)
2. **Preview before action**: Use `<leader>hp` to preview a hunk before staging/resetting
3. **Visual mode selection**: Use `ih` in visual mode to select entire hunk
4. **Quick staging workflow**: Navigate with `]h`/`[h`, preview with `<leader>hp`, then stage with `<leader>hs`
5. **Blame navigation**: Use `<leader>hb` to see who changed a line and when

## Common Navigation Workflows

### Reviewing Git Changes
1. `]h` - Jump to next change
2. `<leader>hp` - Preview the change
3. `<leader>hs` - Stage if good, or `<leader>hr` to reset
4. Repeat for all changes

### Finding and Jumping to Code
1. `<leader>fs` - Search for text across files
2. `gd` - Go to definition of symbol under cursor
3. `]m`/`[m` - Navigate between functions
4. `s` + characters - Quick jump with Flash

### Navigating Errors
1. `]d`/`[d` - Jump between diagnostics
2. `<leader>xd` - View all document diagnostics
3. `K` - Get hover info about the error
4. `<leader>ca` - See available fixes