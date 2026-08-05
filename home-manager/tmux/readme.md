# 🐧 Tmux + Neovim Configuration (NixOS / Home Manager)

This `tmux` configuration is optimized for **NixOS** and managed declaratively via **Home Manager**. It focuses on seamless integration with **Neovim**, global clipboard synchronization, a modern Catppuccin Mocha interface, and robust session persistence.

---

## 🚀 Key Features

- **Neovim Integration (`vim-tmux-navigator`)**: Navigate seamlessly between tmux panes and Neovim splits without delay using `Ctrl + h/j/k/l`.
- **Catppuccin Mocha Flavor**: Modern status bar with `rounded` status modules, 24-hour clock format, active session names, and current directory tracking.
- **Continuous Session Persistence (`Resurrect` & `Continuum`)**: Automatically saves your complete workspace (tabs, panes, paths) every **15 minutes**. Restores your exact previous session automatically upon system boot.
- **Global Clipboard Sync (`tmux-yank`)**: Yank text inside tmux using `y` in copy-mode and paste it directly into external applications (Browser, Discord, Slack, etc.) powered by `set-clipboard on`.

## 📂 Session Management Workflow

Tmux allows you to isolate your projects into independent workspaces called **Sessions**. Thanks to the `Continuum` and `Resurrect` plugins in this ecosystem, all running sessions are automatically saved in the background.

### 1. External Command-Line Operations (Outside Tmux)

| Command | Function |
| :--- | :--- |
| `tmux new -s <name>` | Create a new named session (e.g., `tmux new -s backend`) |
| `tmux ls` | List all active running sessions on your machine |
| `tmux attach -t <name>` | Attach/Connect back into an existing session |
| `tmux kill-session -t <name>`| Terminate and delete a specific session |
| `tmux kill-server` | Kill all sessions and shut down the tmux engine |

### 2. Internal Session Keybindings (Inside Tmux)
*Press **`Ctrl + a`** (Prefix) first before using these commands:*

- `Ctrl + a` ➔ `d` : **Detach** from the current session safely (leaves your server and tasks running in the background).
- `Ctrl + a` ➔ `s` : Open an **interactive tree list menu** to dynamically browse and switch between all active sessions.
- `Ctrl + a` ➔ `$` : **Rename** your current session.

---

## ⌨️ Complete Keybindings Reference

> 💡 **Note:** Press the prefix combination **`Ctrl + a`** before hitting any of the following operational keys (except for the direct navigation shortcuts).

### 1. Window Management

| Keybinding | Function |
| :--- | :--- |
| `Ctrl + a` ➔ `c` | Create a **new window** |
| `Ctrl + a` ➔ `n` | Switch to the **next** window |
| `Ctrl + a` ➔ `p` | Switch to the **previous** window |
| `Ctrl + a` ➔ `w` | **List** all active windows interactively |
| `Ctrl + a` ➔ `,` | **Rename** the current window |
| `Ctrl + a` ➔ `&` | Kill (close) the current window entirely |
| `Ctrl + a` ➔ `1 - 9` | Jump directly to a window by its index number |

### 2. Pane Management & Layouts

| Keybinding | Function |
| :--- | :--- |
| `Ctrl + a` ➔ `%` | Split pane **horizontally** (side-by-side) |
| `Ctrl + a` ➔ `"` | Split pane **vertically** (top-and-bottom) |
| `Ctrl + a` ➔ `o` | Rotate focus to the next pane in the current window |
| `Ctrl + a` ➔ `;` | Move focus to the previously active pane |
| `Ctrl + a` ➔ `z` | **Toggle zoom** (maximize the current pane / restore it) |
| `Ctrl + a` ➔ `Space` | Cycle through standard preset pane layouts |
| `Ctrl + a` ➔ `x` | Kill (close) the current active pane |
| `Ctrl + a` ➔ `q` | Briefly show pane indicators (numbers) |

### 3. Direct Navigation (Tmux 🤝 Neovim via Plugin)
*Do **NOT** press `Ctrl + a`. Use these combinations directly to move your cursor seamlessly across tmux panes and Neovim splits:*
- **`Ctrl + h`**: Move focus to the **Left** pane/split
- **`Ctrl + j`**: Move focus to the **Bottom** pane/split
- **`Ctrl + k`**: Move focus to the **Top** pane/split
- **`Ctrl + l`**: Move focus to the **Right** pane/split

### 4. Vim Copy Mode & Clipboard (via `yank` Plugin)
Press **`Ctrl + a`** ➔ **`[`** to enter copy/history scroll mode:
- Navigate around using standard Vim directional keys (**`h`**, **`j`**, **`k`**, **`l`**).
- Press **`v`**: Begin text selection (Visual Mode).
- Press **`y`**: Copy the highlighted text directly to your **System Clipboard**.
- Press **`Alt + y`**: Copy text and paste it immediately into the command line.
- Press **`q`** or **`Enter`**: Exit copy mode.
- *(To paste inside tmux, press `Ctrl + a` ➔ `]`)*

### 5. Manual Backup & Recovery (via `Resurrect` Plugin)

| Keybinding | Function |
| :--- | :--- |
| `Ctrl + a` ➔ `Ctrl + s` | **Manually save** the current state of all environments |
| `Ctrl + a` ➔ `Ctrl + r` | **Manually restore** sessions from the latest available save state |
| *(Automated)* | The system **auto-saves** your workspace every **15 minutes**. |

### 6. Miscellaneous Utilities

| Keybinding | Function |
| :--- | :--- |
| `Ctrl + a` ➔ `?` | Show the official built-in tmux **help/keybindings list** |
| `Ctrl + a` ➔ `t` | Display a large **24-hour digital clock** |
| `Ctrl + a` ➔ `:` | Open the tmux command prompt |
