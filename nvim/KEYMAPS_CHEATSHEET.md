# Neovim Keymaps Cheatsheet

> Leader key: `<Space>`

## Core Mappings

### General
| Key | Mode | Description |
|-----|------|-------------|
| `jk` | Insert | Exit insert mode |
| `<leader>nh` | Normal | Clear search highlights |
| `<leader>+` | Normal | Increment number |
| `<leader>-` | Normal | Decrement number |

### Window Management
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>sv` | Normal | Split window vertically |
| `<leader>sh` | Normal | Split window horizontally |
| `<leader>se` | Normal | Make splits equal size |
| `<leader>sx` | Normal | Close current split |
| `<leader>sm` | Normal | Maximize/minimize a split (vim-maximizer) |

### Tab Management
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>to` | Normal | Open new tab |
| `<leader>tx` | Normal | Close current tab |
| `<leader>tn` | Normal | Go to next tab |
| `<leader>tp` | Normal | Go to previous tab |
| `<leader>tf` | Normal | Open current buffer in new tab |

## File Explorer (nvim-tree)
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>ee` | Normal | Toggle file explorer |
| `<leader>ef` | Normal | Toggle file explorer on current file |
| `<leader>ec` | Normal | Collapse file explorer |
| `<leader>er` | Normal | Refresh file explorer |

## Telescope (Fuzzy Finding)
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>ff` | Normal | Fuzzy find files in cwd |
| `<leader>fr` | Normal | Fuzzy find recent files |
| `<leader>fs` | Normal | Find string in cwd (live grep) |
| `<leader>fc` | Normal | Find string under cursor in cwd |
| `<leader>ft` | Normal | Find todos |
| `<leader>fk` | Normal | Find keymaps |

### Telescope Navigation (Insert Mode)
| Key | Mode | Description |
|-----|------|-------------|
| `<C-k>` | Insert | Move to previous result |
| `<C-j>` | Insert | Move to next result |
| `<C-q>` | Insert | Send to quickfix list |
| `<C-t>` | Insert | Open in Trouble |

## LSP (Language Server)
| Key | Mode | Description |
|-----|------|-------------|
| `gR` | Normal | Show LSP references |
| `gD` | Normal | Go to declaration |
| `gd` | Normal | Show LSP definitions |
| `gi` | Normal | Show LSP implementations |
| `gt` | Normal | Show LSP type definitions |
| `<leader>ca` | Normal/Visual | See available code actions |
| `<leader>rn` | Normal | Smart rename |
| `<leader>D` | Normal | Show buffer diagnostics |
| `<leader>d` | Normal | Show line diagnostics |
| `[d` | Normal | Go to previous diagnostic |
| `]d` | Normal | Go to next diagnostic |
| `K` | Normal | Show documentation for what is under cursor |
| `<leader>rs` | Normal | Restart LSP |

## Git (Gitsigns)
| Key | Mode | Description |
|-----|------|-------------|
| `]h` | Normal | Next hunk |
| `[h` | Normal | Previous hunk |
| `<leader>hs` | Normal/Visual | Stage hunk |
| `<leader>hr` | Normal/Visual | Reset hunk |
| `<leader>hS` | Normal | Stage buffer |
| `<leader>hR` | Normal | Reset buffer |
| `<leader>hu` | Normal | Undo stage hunk |
| `<leader>hp` | Normal | Preview hunk |
| `<leader>hb` | Normal | Blame line |
| `<leader>hB` | Normal | Toggle line blame |
| `<leader>hd` | Normal | Diff this |
| `<leader>hD` | Normal | Diff this ~ |
| `ih` | Operator/Visual | Select hunk |

## LazyGit
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>lg` | Normal | Open LazyGit |

## Trouble (Diagnostics)
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>xw` | Normal | Open trouble workspace diagnostics |
| `<leader>xd` | Normal | Open trouble document diagnostics |
| `<leader>xq` | Normal | Open trouble quickfix list |
| `<leader>xl` | Normal | Open trouble location list |
| `<leader>xt` | Normal | Open todos in trouble |

## Todo Comments
| Key | Mode | Description |
|-----|------|-------------|
| `]t` | Normal | Next todo comment |
| `[t` | Normal | Previous todo comment |

## Substitute
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>r` | Normal | Substitute with motion |
| `<leader>rr` | Normal | Substitute line |
| `<leader>R` | Normal | Substitute to end of line |
| `<leader>r` | Visual | Substitute in visual mode |

## Flash (Navigation)
| Key | Mode | Description |
|-----|------|-------------|
| `s` | Normal/Visual/Operator | Flash jump |
| `S` | Normal/Visual/Operator | Flash Treesitter |
| `r` | Operator | Remote Flash |
| `R` | Operator/Visual | Treesitter Search |
| `<C-s>` | Command | Toggle Flash Search |

## Formatting & Linting
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>mp` | Normal/Visual | Format file or range |
| `<leader>l` | Normal | Trigger linting for current file |

## Session Management
| Key | Mode | Description |
|-----|------|-------------|
| `<leader>wr` | Normal | Restore session for cwd |
| `<leader>ws` | Normal | Save session for auto session root dir |

## Autocompletion (nvim-cmp)
| Key | Mode | Description |
|-----|------|-------------|
| `<C-k>` | Insert | Previous suggestion |
| `<C-j>` | Insert | Next suggestion |
| `<C-b>` | Insert | Scroll docs backward |
| `<C-f>` | Insert | Scroll docs forward |
| `<C-Space>` | Insert | Show completion suggestions |
| `<C-e>` | Insert | Close completion window |
| `<CR>` | Insert | Confirm selection |

## Surround (nvim-surround)
Default keybindings from nvim-surround:
| Key | Mode | Description |
|-----|------|-------------|
| `ys{motion}{char}` | Normal | Add surrounding |
| `ds{char}` | Normal | Delete surrounding |
| `cs{target}{replacement}` | Normal | Change surrounding |
| `S{char}` | Visual | Add surrounding to selection |

Examples:
- `ysiw"` - Surround inner word with quotes
- `ds"` - Delete surrounding quotes
- `cs"'` - Change surrounding quotes to single quotes
- `S"` - In visual mode, surround selection with quotes

## Tips
- Use `<leader>fk` to search for keymaps interactively
- Most plugin keymaps start with `<leader>` for easy access
- Navigation keymaps often use `[` and `]` for previous/next
- Git operations are grouped under `<leader>h` (hunk)
- File operations are grouped under `<leader>f` (find)
- Window/split operations are grouped under `<leader>s` (split)
- Tab operations are grouped under `<leader>t` (tab)