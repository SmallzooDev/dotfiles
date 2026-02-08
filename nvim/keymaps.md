# Keymaps

Leader key: `Space`

## Helix-style Space Pickers

| Key | Action | Source |
|-----|--------|--------|
| `Space f` | Find files | fzf-lua |
| `Space F` | Find files (buffer dir) | fzf-lua |
| `Space b` | Find buffers | fzf-lua |
| `Space /` | Live grep | fzf-lua |
| `Space ?` | Find keymaps | fzf-lua |
| `Space '` | Resume last picker | fzf-lua |
| `Space d` | Document diagnostics | fzf-lua |
| `Space D` | Workspace diagnostics | fzf-lua |

## Helix-style Space LSP (buffer-local, on LspAttach)

| Key | Action | Source |
|-----|--------|--------|
| `Space a` | Code actions (fzf picker) | fzf-lua |
| `Space r` | Rename symbol | lspconfig |
| `Space k` | Hover documentation | lspconfig |
| `Space s` | Document symbols | fzf-lua |
| `Space S` | Workspace symbols | fzf-lua |

## LSP Goto (buffer-local, on LspAttach)

| Key | Action | Split variant |
|-----|--------|---------------|
| `gd` | Go to definition | `Space v gd` |
| `gD` | Go to declaration | `Space v gD` |
| `gR` | Show references | `Space v gR` |
| `gi` | Show implementations | `Space v gi` |
| `gt` | Show type definitions | `Space v gt` |
| `gu` | Show usages (references) | `Space v gu` |
| `gI` | Go to super/parent type | `Space v gI` |

## LSP Settings (buffer-local, on LspAttach)

| Key | Action |
|-----|--------|
| `Space lr` | Restart LSP |
| `Space ll` | Open LSP log |
| `Space li` | LSP info (checkhealth) |
| `Space lh` | Toggle inlay hints |
| `Space ld` | Toggle diagnostics virtual text |

## Diagnostics Navigation

| Key | Action |
|-----|--------|
| `[d` | Previous diagnostic |
| `]d` | Next diagnostic |

## Trouble

| Key | Action |
|-----|--------|
| `Space xw` | Workspace diagnostics (Trouble) |
| `Space xd` | Document diagnostics (Trouble) |
| `Space xq` | Quickfix list |
| `Space xl` | Location list |
| `Space xt` | Todo comments |

## Git (Gitsigns)

| Key | Action |
|-----|--------|
| `]h` | Next hunk |
| `[h` | Previous hunk |
| `Space hs` | Stage hunk |
| `Space hr` | Reset hunk |
| `Space hS` | Stage buffer |
| `Space hR` | Reset buffer |
| `Space hu` | Undo stage hunk |
| `Space hp` | Preview hunk |
| `Space hb` | Blame line |
| `Space hB` | Toggle line blame |
| `Space hd` | Diff this |
| `Space hD` | Diff this ~ |
| `ih` | Select hunk (operator/visual) |

## Git (Snacks)

| Key | Action |
|-----|--------|
| `Space gb` | Git blame line |
| `Space gB` | Git browse |
| `Space lg` | Lazygit |

## File Explorer (Oil)

| Key | Action |
|-----|--------|
| `Space e` | Open file explorer (float) |

Inside Oil:

| Key | Action |
|-----|--------|
| `CR` / `]` | Select |
| `[` / `-` | Parent directory |
| `Ctrl+v` | Open in vsplit |
| `Ctrl+s` | Open in split |
| `Ctrl+p` | Preview |
| `q` / `Ctrl+c` | Close |
| `g.` | Toggle hidden files |
| `gs` | Change sort |

## Buffers

| Key | Action |
|-----|--------|
| `Tab` | Next buffer |
| `Shift+Tab` | Previous buffer |
| `Space bd` | Delete buffer |

## Window

| Key | Action |
|-----|--------|
| `Space wv` | Split vertically |
| `Space ws` | Split horizontally |
| `Space we` | Make splits equal |
| `Space wx` | Close split |
| `Ctrl+h/j/k/l` | Navigate panes (tmux-aware) |
| `Ctrl+Up/Down` | Resize height |
| `Ctrl+Left/Right` | Resize width |

## Editing (Mini)

Move:

| Key | Action |
|-----|--------|
| `J` | Move line/selection down |
| `K` | Move line/selection up |
| `Shift+H` | Move selection left |
| `Shift+L` | Move selection right |

Surround:

| Key | Action |
|-----|--------|
| `sa` | Add surround |
| `sd` | Delete surround |
| `sr` | Replace surround |
| `sh` | Highlight surround |

## Navigation (Helix-style)

| Key | Action |
|-----|--------|
| `gh` | Go to start of line |
| `gl` | Go to end of line |
| `gs` | Go to first non-blank |

## Flash

| Key | Action |
|-----|--------|
| `sf` | Flash jump |
| `sF` | Flash treesitter |
| `gr` | Remote flash (operator mode) |
| `gR` | Treesitter search (operator/visual) |
| `Ctrl+s` | Toggle flash search (command mode) |

## Treesitter Text Objects

Select:

| Key | Action |
|-----|--------|
| `a=` / `i=` | Assignment (outer/inner) |
| `l=` / `r=` | Assignment (lhs/rhs) |
| `a:` / `i:` | Property (outer/inner) |
| `aa` / `ia` | Parameter (outer/inner) |
| `ai` / `ii` | Conditional (outer/inner) |
| `al` / `il` | Loop (outer/inner) |
| `af` / `if` | Function call (outer/inner) |
| `am` / `im` | Function definition (outer/inner) |
| `ac` / `ic` | Class (outer/inner) |

Swap:

| Key | Action |
|-----|--------|
| `Space na` | Swap next parameter |
| `Space pa` | Swap prev parameter |
| `Space n:` | Swap next property |
| `Space p:` | Swap prev property |
| `Space nm` | Swap next function |
| `Space pm` | Swap prev function |

Move (next/prev):

| Key | Action |
|-----|--------|
| `]f` / `[f` | Function call start |
| `]m` / `[m` | Function def start |
| `]c` / `[c` | Class start |
| `]i` / `[i` | Conditional start |
| `]l` / `[l` | Loop start |
| `]s` | Next scope |
| `]z` | Next fold |

Repeat:

| Key | Action |
|-----|--------|
| `;` | Repeat last move |
| `,` | Repeat last move (opposite) |
| `f/F/t/T` | Repeatable built-in motions |

## Treesitter Selection

| Key | Action |
|-----|--------|
| `CR` | Init/expand selection |
| `BS` | Shrink selection |

## Snacks

| Key | Action |
|-----|--------|
| `Space un` | Dismiss notifications |
| `Space uh` | Notification history |
| `]]` | Next reference |
| `[[` | Previous reference |

## Formatting

| Key | Action |
|-----|--------|
| `Space mp` | Format file/range |

## Completion (blink.cmp, insert mode)

| Key | Action |
|-----|--------|
| `Ctrl+j` | Select next |
| `Ctrl+k` | Select prev |
| `Ctrl+n` | Show completion |
| `Ctrl+e` | Hide completion |
| `CR` | Accept |
| `Ctrl+b` | Scroll docs up |
| `Ctrl+f` | Scroll docs down |

## FZF Picker (inside picker)

| Key | Action |
|-----|--------|
| `Ctrl+j/k` | Navigate results |
| `Ctrl+d/u` | Scroll preview |
| `Ctrl+t` | Toggle preview |
| `Ctrl+v` | Open in vsplit |
| `Ctrl+s` | Open in hsplit |
| `Ctrl+q` | Select all to quickfix |
| `CR` | Open |

## General

| Key | Action |
|-----|--------|
| `jk` | Exit insert mode |
| `Space +` / `Space -` | Increment / decrement number |
| `<` / `>` (visual) | Indent and re-select |
| `p` (visual) | Paste without yanking |
| `yp` | Copy filepath:line to clipboard |
| `gp` | Go to file:line from clipboard |
| `Esc` | Clear search highlight |
