# Nvim Cheatsheet

# Neovim Keymap Summary

### General & Editing Keymaps (`remap.lua`)

| Mode(s) | Keybinding      | Description                                                    |
| :------ | :-------------- | :------------------------------------------------------------- |
| n       | `<leader>pv`    | Open file explorer (`Ex` command)                 |
| v       | `J`             | Move selected line(s) down                          |
| v       | `K`             | Move selected line(s) up                            |
| n       | `J`             | Join lines below current line without moving cursor |
| n       | `<C-d>`         | Scroll down half a page and center screen           |
| n       | `<C-u>`         | Scroll up half a page and center screen             |
| n       | `n`             | Repeat last search forward and center screen        |
| n       | `N`             | Repeat last search backward and center screen       |
| x       | `<leader>p`     | Paste without yanking ("greatest remap ever")       |
| n, v    | `<leader>y`     | Yank to system clipboard                            |
| n       | `<leader>Y`     | Yank current line to system clipboard               |
| n, v    | `<leader>d`     | Delete without yanking                              |
| i       | `<C-c>`         | Escape from Insert mode                             |
| n       | `Q`             | No operation (disabled Ex mode)                     |
| n       | `<C-f>`         | Open tmux-sessionizer in a new tmux window          |
| n       | `<leader>f`     | Format buffer using LSP                             |
| n       | `<C-k>`         | Go to next item in quickfix list and center         |
| n       | `<C-j>`         | Go to previous item in quickfix list and center     |
| n       | `<leader>k`     | Go to next item in location list and center         |
| n       | `<leader>j`     | Go to previous item in location list and center     |
| n       | `<leader>s`     | Search and replace word under cursor globally       |
| n       | `<leader>x`     | Make the current file executable (`chmod +x`)       |
| n       | `<leader><leader>` | Source (reload) the current file                    |
| n       | `<leader>ca`     | Start cellular automaton animation ("make_it_rain") |

### LSP Keymaps (`init.lua` & `lsp.lua`)

*These are set up within the `LspAttach` autocmd.*

| Mode(s) | Keybinding      | Description                              |
| :------ | :-------------- | :--------------------------------------- |
| n       | `gd`            | Go to definition              |
| n       | `K`             | Show hover information        |
| n       | `<leader>vws`   | Search workspace symbols      |
| n       | `<leader>vd`    | Show line diagnostics         |
| n       | `<leader>vca`   | Show code actions             |
| n       | `<leader>vrr`   | Show references               |
| n       | `<leader>vrn`   | Rename symbol                 |
| i       | `<C-h>`         | Show signature help           |
| n       | `[d`            | Go to previous diagnostic     |
| n       | `]d`            | Go to next diagnostic         |
| n       | `<leader>zig`    | Restart Zig Language Server (zls) |
| i       | `<C-p>`         | Select previous completion item |
| i       | `<C-n>`         | Select next completion item     |
| i       | `<C-y>`         | Confirm selected completion     |
| i       | `<C-Space>`     | Trigger completion            |

### Telescope (`telescope.lua`)

| Mode(s) | Keybinding   | Description                                       |
| :------ | :----------- | :------------------------------------------------ |
| n       | `<leader>pf` | Find files                             |
| n       | `<C-p>`      | Find Git files                         |
| n       | `<leader>pws` | Grep for word under cursor (vim.fn.expand("<cword>")) |
| n       | `<leader>pWs` | Grep for WORD under cursor (vim.fn.expand("<cWORD>")) |
| n       | `<leader>ps` | Grep for string (prompts for input)    |
| n       | `<leader>vh` | Search help tags                       |

### Neo-tree (`neo-tree.lua`)

| Mode(s) | Keybinding   | Description                          |
| :------ | :----------- | :----------------------------------- |
| n       | `<leader>e` | Toggle file explorer (left) |
| n       | `<leader>E` | Reveal current file in explorer (left) |
| n       | `<Esc>`      | Close Neo-tree window (when focused) |
| n       | `P`          | Toggle preview window (when focused) |

### Harpoon (`harpoon2.lua`)

| Mode(s) | Keybinding   | Description                      |
| :------ | :----------- | :------------------------------- |
| n       | `<leader>H` | Add current file to Harpoon list |
| n       | `<leader>h` | Toggle Harpoon quick menu |
| n       | `<leader>1` | Navigate to Harpoon file 1  |
| n       | `<leader>2` | Navigate to Harpoon file 2  |
| n       | `<leader>3` | Navigate to Harpoon file 3  |
| n       | `<leader>4` | Navigate to Harpoon file 4  |
| n       | `<leader>5` | Navigate to Harpoon file 5  |

### ToggleTerm (`toggleterm.lua`)

| Mode(s) | Keybinding    | Description                                |
| :------ | :------------ | :----------------------------------------- |
| n, t    | `<leader>tt` | Toggle floating terminal (40% height) |
| n, t    | `<leader>th` | Toggle horizontal terminal (15 lines) |
| n, t    | `<leader>tv` | Toggle vertical terminal (80 columns) |
| t       | `<Esc><Esc>` | Exit terminal mode back to Normal mode |

### LazyGit (`lazygit.lua`)

| Mode(s) | Keybinding   | Description          |
| :------ | :----------- | :------------------- |
| n       | `<leader>gg` | Toggle LazyGit popup |

### Oil (`oil.lua`)

| Mode(s) | Keybinding | Description                                 |
| :------ | :--------- | :------------------------------------------ |
| n       | `-`        | Open parent directory in Oil float |
| n       | `<Esc>`    | Close Oil buffer/window (when focused) |