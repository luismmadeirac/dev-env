# Standard Tmux Cheat Sheet & Quick Reference ![Status: Updated](https://img.shields.io/badge/Status-Updated-green)

Last updated: Sep, 12th 2025

---
**Default Prefix:** `Ctrl` + `b` (Press this combination before pressing the command key)

### Sessions

| Command                       | Action                                       |
| :---------------------------- | :------------------------------------------- |
| `tmux new -s <name>`          | Start a new session named `<name>`           |
| `tmux attach -t <name>` or `tmux a -t <name>` | Attach to an existing session named `<name>` |
| `tmux ls`                     | List running sessions                       |
| `Prefix` + `d`                | Detach from the current session             |
| `Prefix` + `s`                | Show all sessions (interactive)              |
| `Prefix` + `$`                | Rename the current session                  |
| `tmux kill-ses -t <name>`     | Kill session named `<name>`                 |
| `tmux kill-server`            | Kill the tmux server and all sessions     |
| `Prefix` + `(`                | Switch to the previous session              |
| `Prefix` + `)`                | Switch to the next session                  |

### Windows (Tabs)

| Command          | Action                                |
| :--------------- | :------------------------------------ |
| `Prefix` + `c`   | Create a new window                  |
| `Prefix` + `,`   | Rename the current window            |
| `Prefix` + `w`   | List windows (interactive)           |
| `Prefix` + `&`   | Kill the current window              |
| `Prefix` + `n`   | Switch to the next window            |
| `Prefix` + `p`   | Switch to the previous window        |
| `Prefix` + `l`   | Switch to the last active window     |
| `Prefix` + `0-9` | Switch to window number 0-9          |
| `Prefix` + `f`   | Find window                          |
| `Prefix` + `.`   | Move window (interactive prompt)     |

### Panes (Splits)

| Command           | Action                                   |
| :---------------- | :--------------------------------------- |
| `Prefix` + `%`    | Split pane vertically                    |
| `Prefix` + `"`    | Split pane horizontally                  |
| `Prefix` + `x`    | Kill the current pane                    |
| `Prefix` + `o`    | Switch to the next pane                 |
| `Prefix` + `;`    | Toggle between the last two active panes |
| `Prefix` + `q`    | Show pane numbers (press number to switch) |
| `Prefix` + `z`    | Toggle pane zoom (fullscreen)           |
| `Prefix` + `Space`| Toggle between different pane layouts    |
| `Prefix` + `{`    | Move the current pane left               |
| `Prefix` + `}`    | Move the current pane right              |
| `Prefix` + `!`    | Convert the current pane into a window   |
| `Prefix` + Arrow Keys | Navigate between panes                |
| `Prefix` + `Ctrl`+ Arrow Keys | Resize pane (hold Ctrl)      |

### Copy Mode (Scrolling and Copying)

| Command           | Action                                      |
| :---------------- | :------------------------------------------ |
| `Prefix` + `[`    | Enter copy mode                             |
| `q`               | Exit copy mode                              |
| (In Copy Mode)    |                                             |
| `Space`           | Start selection (vi mode: `v`)             |
| `Enter`           | Copy selected text & exit (vi mode: `y`)    |
| `Esc`             | Clear selection & exit                     |
| Arrow Keys        | Move cursor (vi mode: `h`,`j`,`k`,`l`)     |
| `PgUp`, `PgDn`    | Scroll page up/down (vi mode: `Ctrl+u`,`Ctrl+d`) |
| `g`               | Go to top line                              |
| `G`               | Go to bottom line                           |
| `/`               | Search forward                              |
| `?`               | Search backward                             |
| `n`, `N`          | Next/Previous search result                 |
| `Prefix` + `]`    | Paste the most recently copied text        |

### Miscellaneous

| Command          | Action                         |
| :--------------- | :----------------------------- |
| `Prefix` + `t`   | Show a large clock             |
| `Prefix` + `:`   | Enter tmux command prompt     |
| `Prefix` + `?`   | List all key bindings         |

### Further Resources

* [Tmux Cheat Sheet & Quick Reference | Session, window, pane and more](https://tmuxcheatsheet.com/)
* [Tmux Cheat Sheet: Commands and Shortcuts Explained - phoenixNAP](https://phoenixnap.com/kb/tmux-cheat-sheet)
* [Tmux Command Cheat Sheet & Quick Reference](https://quickref.me/tmux.html)
* [tmux Cheat Sheet - Pluralsight](https://www.pluralsight.com/resources/blog/cloud/tmux-cheat-sheet)
* [GitHub Gist: tmux shortcuts & cheatsheet](https://gist.github.com/MohamedAlaa/2961058)
* [GitHub Gist: tmux Cheat Sheet](https://gist.github.com/michaellihs/b6d46fa460fa5e429ea7ee5ff8794b96)
