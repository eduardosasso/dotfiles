# Tmux Cheatsheet

Prefix: `Ctrl-a` (remapped from default `Ctrl-b`)

## Sessions

| Shortcut | Action |
|----------|--------|
| `C-a d` | Detach from session |
| `C-a s` | List/switch sessions |
| `C-a $` | Rename session |
| `C-a (` / `)` | Previous/next session |

## Windows (tabs)

| Shortcut | Action |
|----------|--------|
| `C-a c` | Create new window (in current path) |
| `C-a n` | Next window |
| `C-a p` | Previous window |
| `C-a 0-9` | Go to window by number |
| `C-a ,` | Rename window |
| `C-a &` | Kill window |
| `C-a w` | List all windows |

## Panes (splits)

| Shortcut | Action | Note |
|----------|--------|------|
| `C-a \|` | Split vertical | Custom |
| `C-a -` | Split horizontal | Custom |
| `C-a h/j/k/l` | Navigate panes (vim-style) | Custom |
| `C-a H/J/K/L` | Resize panes | Custom |
| `C-a o` | Cycle through panes | Default |
| `C-a x` | Kill pane | Default |
| `C-a z` | Toggle pane zoom (fullscreen) | Default |
| `C-a {` / `}` | Swap pane left/right | Default |
| `C-a space` | Cycle pane layouts | Default |

## Copy Mode (vi-style)

| Shortcut | Action | Note |
|----------|--------|------|
| `C-a [` | Enter copy mode | Default |
| `q` | Exit copy mode | |
| `v` | Start selection | Custom |
| `y` | Copy selection (to system clipboard) | Custom |
| `C-a ]` | Paste | Default |

## Other

| Shortcut | Action | Note |
|----------|--------|------|
| `C-a r` | Reload config | Custom |
| `C-a ?` | List all keybindings | Default |
| `C-a :` | Command prompt | Default |
| `C-a t` | Show clock | Default |

## Command Line

```bash
tmux                    # Start new session
tmux new -s name        # Start new session with name
tmux ls                 # List sessions
tmux attach -t name     # Attach to session
tmux kill-session -t name   # Kill session
tmux kill-server        # Kill all sessions
```
