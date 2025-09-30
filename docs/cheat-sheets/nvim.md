# Neovim Cheat Sheet  ![Status: Updated](https://img.shields.io/badge/Status-Updated-green)

Last updated: Sep, 15th 2025

## Leader Key

**Leader Key:** `Space`

---

## Essential Vim Motions & Commands

### Basic Movement

| Keybinding | Description |
| :--------- | :---------- |
| `h`, `j`, `k`, `l` | Move left, down, up, right |
| `w` | Move to start of next word |
| `e` | Move to end of word |
| `b` | Move to beginning of word |
| `0` | Move to beginning of line |
| `$` | Move to end of line |
| `^` | Move to first non-blank character |
| `gg` | Go to top of file |
| `G` | Go to end of file |
| `{` / `}` | Move by paragraphs |
| `%` | Jump to matching bracket |

### Advanced Movement

| Keybinding | Description |
| :--------- | :---------- |
| `f{char}` | Find next occurrence of character |
| `F{char}` | Find previous occurrence of character |
| `t{char}` | Move to before next occurrence |
| `T{char}` | Move to after previous occurrence |
| `;` | Repeat last f/t/F/T |
| `,` | Repeat last f/t/F/T in opposite direction |
| `*` | Search for word under cursor |
| `#` | Search backward for word under cursor |

### Text Objects

| Keybinding | Description |
| :--------- | :---------- |
| `iw` / `aw` | Inner word / A word |
| `is` / `as` | Inner sentence / A sentence |
| `ip` / `ap` | Inner paragraph / A paragraph |
| `i"` / `a"` | Inner quotes / A quotes |
| `i'` / `a'` | Inner single quotes / A single quotes |
| `i(` / `a(` | Inner parentheses / A parentheses |
| `i[` / `a[` | Inner brackets / A brackets |
| `i{` / `a{` | Inner braces / A braces |
| `it` / `at` | Inner tag / A tag |

### Editing Commands

| Keybinding | Description |
| :--------- | :---------- |
| `i` | Insert before cursor |
| `a` | Insert after cursor |
| `I` | Insert at beginning of line |
| `A` | Insert at end of line |
| `o` | Open new line below |
| `O` | Open new line above |
| `r` | Replace single character |
| `R` | Replace mode |
| `s` | Substitute character |
| `S` | Substitute line |
| `c` | Change |
| `C` | Change to end of line |
| `d` | Delete |
| `D` | Delete to end of line |
| `x` | Delete character under cursor |
| `X` | Delete character before cursor |
| `y` | Yank (copy) |
| `Y` | Yank line |
| `p` | Paste after cursor |
| `P` | Paste before cursor |

### Visual Mode

| Keybinding | Description |
| :--------- | :---------- |
| `v` | Character visual mode |
| `V` | Line visual mode |
| `Ctrl-v` | Block visual mode |
| `gv` | Reselect last visual selection |

### Search & Replace

| Keybinding | Description |
| :--------- | :---------- |
| `/pattern` | Search forward |
| `?pattern` | Search backward |
| `n` | Next search result (enhanced - centers screen) |
| `N` | Previous search result (enhanced - centers screen) |
| `:s/old/new/` | Replace first occurrence in line |
| `:s/old/new/g` | Replace all in line |
| `:%s/old/new/g` | Replace all in file |
| `:%s/old/new/gc` | Replace all with confirmation |

---

## Custom Keybindings (Your Configuration)

### File Navigation

| Keybinding | Description |
| :--------- | :---------- |
| `<leader>pv` | Open netrw file explorer |
| `-` | Open Oil.nvim file explorer (float, hidden files shown) |

### Movement Enhancements

| Keybinding | Description |
| :--------- | :---------- |
| `<C-d>` | Half page down (centered) |
| `<C-u>` | Half page up (centered) |
| `J` | Join lines (cursor stays in place) |
| `=ap` | Format paragraph and return to original position |

### Visual Mode Enhancements

| Keybinding | Description |
| :--------- | :---------- |
| `J` (visual) | Move selected lines down |
| `K` (visual) | Move selected lines up |

### Copy/Paste/Delete System

| Keybinding | Description |
| :--------- | :---------- |
| `<leader>y` | Yank to system clipboard |
| `<leader>Y` | Yank line to system clipboard |
| `<leader>p` (visual) | Paste without losing clipboard content |
| `<leader>d` | Delete to void register (doesn't overwrite clipboard) |

### Quick Lists Navigation

| Keybinding | Description |
| :--------- | :---------- |
| `<C-k>` | Next quickfix item (centered) |
| `<C-j>` | Previous quickfix item (centered) |
| `<leader>k` | Next location list item (centered) |
| `<leader>j` | Previous location list item (centered) |

### Utilities

| Keybinding | Description |
| :--------- | :---------- |
| `<leader>s` | Search and replace word under cursor |
| `<leader>x` | Make current file executable |
| `<leader>so` | Source current file |
| `<C-c>` (insert) | Escape to normal mode |
| `Q` | Disabled (no-op) |

---

## LSP Keybindings (Language Server Protocol)

| Keybinding | Description |
| :--------- | :---------- |
| `gd` | Go to definition |
| `K` | Hover documentation |
| `<leader>vws` | Workspace symbol search |
| `<leader>vd` | Show diagnostic float |
| `<leader>vca` | Code actions |
| `<leader>vrr` | Find references |
| `<leader>vrn` | Rename symbol |
| `<C-h>` (insert) | Signature help |
| `[d` | Previous diagnostic |
| `]d` | Next diagnostic |
| `<leader>f` | Format buffer |

---

## Plugin Keybindings

### Telescope (Fuzzy Finder)

| Keybinding | Description |
| :--------- | :---------- |
| `<leader>pf` | Find files in project |
| `<C-p>` | Find git tracked files |
| `<leader>ps` | Search in project (grep with input) |
| `<leader>pws` | Search word under cursor |
| `<leader>pWs` | Search WORD under cursor |
| `<leader>vh` | Help tags search |

### Harpoon (Quick File Navigation)

| Keybinding | Description |
| :--------- | :---------- |
| `<leader>H` | Add current file to Harpoon list |
| `<leader>h` | Toggle Harpoon quick menu |
| `<leader>1` | Navigate to Harpoon file 1 |
| `<leader>2` | Navigate to Harpoon file 2 |
| `<leader>3` | Navigate to Harpoon file 3 |
| `<leader>4` | Navigate to Harpoon file 4 |
| `<leader>5` | Navigate to Harpoon file 5 |

### UndoTree

| Keybinding | Description |
| :--------- | :---------- |
| `<leader>u` | Toggle UndoTree |

### Theme Switching

| Keybinding | Description |
| :--------- | :---------- |
| `<leader>ts` | Interactive theme switcher |
| `<leader>trp` | Switch to Rose Pine Moon |
| `<leader>ttn` | Switch to Tokyo Night Storm |

### Terminal (ToggleTerm)

| Keybinding | Description |
| :--------- | :---------- |
| `<leader>tt` | Toggle floating terminal (20 lines) |
| `<leader>th` | Toggle horizontal terminal (20 lines) |
| `<leader>tv` | Toggle vertical terminal (30 cols) |
| `<Esc><Esc>` (terminal) | Exit terminal mode |
| `<C-\>` | Default terminal toggle mapping |

### Zen Mode

| Keybinding | Description |
| :--------- | :---------- |
| `<leader>zz` | Toggle Zen Mode |
| `<leader>zZ` | Toggle Zen Mode with Twilight |

### Oil.nvim (File Explorer)

| Keybinding | Description |
| :--------- | :---------- |
| `-` | Open parent directory (float) |
| `<Esc>` (in Oil) | Close Oil explorer |

---

## Tmux Integration

### Tmux-Sessionizer

| Keybinding | Description |
| :--------- | :---------- |
| `<C-f>` | Open tmux project sessionizer |

**What it does:** Opens a fuzzy finder to select and switch between projects in tmux sessions. Searches through:
- Predefined project directories (~/Developer, ~/personal, ~/work, ~/.config, ~/.local/scripts)
- Up to 20 subdirectories in ~/Developer (depth 1-2)
- Creates new tmux session if needed or switches to existing one

---

## Completion & Snippets (nvim-cmp)

### Insert Mode Completion

| Keybinding | Description |
| :--------- | :---------- |
| `<C-p>` | Previous completion item |
| `<C-n>` | Next completion item |
| `<C-y>` | Confirm selection |
| `<C-Space>` | Trigger completion |

---

## Window & Tab Management

### Windows

| Keybinding | Description |
| :--------- | :---------- |
| `:sp` | Horizontal split |
| `:vsp` | Vertical split |
| `<C-w>h/j/k/l` | Navigate windows |
| `<C-w>w` | Cycle through windows |
| `<C-w>=` | Equalize window sizes |
| `<C-w>q` | Close window |

### Tabs

| Keybinding | Description |
| :--------- | :---------- |
| `:tabnew` | New tab |
| `:tabn` / `gt` | Next tab |
| `:tabp` / `gT` | Previous tab |
| `:tabclose` | Close tab |

---

## Command Mode Essentials

| Command | Description |
| :------ | :---------- |
| `:w` | Write (save) file |
| `:q` | Quit |
| `:q!` | Force quit without saving |
| `:wq` / `:x` | Write and quit |
| `:e filename` | Edit file |
| `:bn` / `:bp` | Next/previous buffer |
| `:bd` | Delete buffer |
| `:ls` | List buffers |
| `:set nu` | Show line numbers |
| `:set rnu` | Show relative line numbers |
| `:noh` | Clear search highlighting |
| `:so %` | Source current file |

---

## Advanced Features

### Macros

| Keybinding | Description |
| :--------- | :---------- |
| `q{register}` | Start recording macro |
| `q` | Stop recording |
| `@{register}` | Play macro |
| `@@` | Repeat last macro |

### Marks

| Keybinding | Description |
| :--------- | :---------- |
| `m{letter}` | Set mark |
| `'{letter}` | Go to mark (line) |
| `` `{letter}` | Go to mark (exact position) |
| `''` | Go to previous mark |

### Folding
| Keybinding | Description |
| :--------- | :---------- |
| `zf` | Create fold |
| `zo` | Open fold |
| `zc` | Close fold |
| `za` | Toggle fold |
| `zR` | Open all folds |
| `zM` | Close all folds |

---

## Configuration Details

### Custom Settings

- **Leader key:** Space
- **Line numbers:** Enabled with relative numbers
- **Tab settings:** 4 spaces, expanded tabs
- **Persistent undo:** Enabled
- **Auto-cleanup:** Removes trailing whitespace on save
- **Transparency:** 80% window/popup transparency
- **Color column:** Set to 300 characters
- **Spell check:** Enabled for code files, markdown, and git commits

### Installed Plugins

- **Lazy.nvim** - Plugin manager
- **LSP** - Language server support with Mason
- **nvim-cmp** - Completion engine
- **Telescope** - Fuzzy finder for files, text, help tags
- **Harpoon 2** - Quick file navigation and marking
- **Oil.nvim** - File explorer with floating window
- **UndoTree** - Undo history visualizer
- **ToggleTerm** - Terminal integration with multiple layouts
- **Rose Pine & Tokyo Night & Brightburn** - Color themes
- **Zen Mode** - Distraction-free writing with line numbers toggle
- **Treesitter** - Better syntax highlighting and parsing

### Theme Information

**Default theme:** Rose Pine Moon
**Available themes:** Rose Pine (main, moon, dawn), Tokyo Night (storm, night, day), Brightburn

---

## Tips & Tricks

1. **Quick project switching:** Use `<C-f>` to quickly switch between tmux sessions for different projects
2. **Efficient editing:** Use text objects (`ci"`, `da(`, etc.) for rapid text manipulation
3. **Multi-cursor editing:** Use visual block mode (`<C-v>`) for column editing
4. **Quick fixes:** Use `<C-k>` and `<C-j>` to navigate through errors and warnings
5. **System clipboard:** Always use `<leader>y` for copying to share with other applications
6. **File exploration:** Use `-` for quick directory browsing with hidden files visible
7. **Theme switching:** Use `<leader>ts` for interactive theme selection
8. **Undo history:** Use `<leader>u` to visualize and navigate undo tree

### Workflow Recommendations

1. **Project Navigation:** `<C-f>` → Select project → Start coding
2. **File Finding:** `<C-p>` for git files, `<leader>pf` for all files, `<leader>ps` for text search
3. **File Navigation:** `<leader>h` (Harpoon) for frequently used files, `-` for exploration
4. **Code Navigation:** `gd`, `<leader>vrr`, `K` for understanding codebase
5. **Editing:** Use text objects and custom clipboard mappings for efficiency
6. **Focus:** Use `<leader>zz` for distraction-free coding sessions

---

### Further Resources

* [Neovim Documentation](https://neovim.io/doc/)
* [Vim Cheat Sheet](https://vim.rtorr.com/)
* [Vim Adventures](https://vim-adventures.com/) - Interactive vim tutorial
