# Neovim Shortcuts Cheat Sheet

## Core Neovim Keymaps (lua/config/keymaps.lua)

### Basic Operations
| Shortcut | Mode | Action | Description |
|----------|------|--------|-------------|
| `<Esc>` | Normal | `:nohlsearch<CR><Esc>` | Clear search highlights |
| `<leader>w` | Normal | `:write<CR>` | Save file |
| `<leader>q` | Normal | `:quit<CR>` | Quit current buffer |
| `Q` | Normal | `:qa<CR>` | Quit all buffers |
| `<leader>rr` | Normal | `:qa<CR>` | Restart Neovim |

### Window Navigation (Built-in)
| Shortcut | Mode | Action | Description |
|----------|------|--------|-------------|
| `<C-h>` | Normal | `<C-w>h` | Move to left window |
| `<C-j>` | Normal | `<C-w>j` | Move to window below |
| `<C-k>` | Normal | `<C-w>k` | Move to window above |
| `<C-l>` | Normal | `<C-w>l` | Move to right window |

### Toggle Features (Built-in)
| Shortcut | Mode | Action | Description |
|----------|------|--------|-------------|
| `<leader>un` | Normal | Toggle relative numbers | Toggle relative line numbers |
| `<leader>ul` | Normal | Toggle listchars | Toggle invisible characters |
| `<leader>us` | Normal | Toggle spell check | Toggle spell checking |
| `<leader>uh` | Normal | Toggle search highlight | Toggle search highlighting |

### Configuration
| Shortcut | Mode | Action | Description |
|----------|------|--------|-------------|
| `<leader>ev` | Normal | `:edit $MYVIMRC<CR>` | Edit Neovim config |

## File Explorer - NvimTree Plugin (lua/plugins/nvim-tree.lua)

| Shortcut | Mode | Action | Description |
|----------|------|--------|-------------|
| `<leader>e` | Normal | `:NvimTreeToggle<CR>` | Toggle file explorer |
| `<leader>ef` | Normal | `:NvimTreeFindFile<CR>` | Find current file in explorer |
| `<Cmd-e>` | Normal | `:NvimTreeToggle<CR>` | Toggle file explorer (Mac style) |
| `<Cmd-b>` | Normal | `:NvimTreeToggle<CR>` | Toggle file explorer (VS Code style) |

## Tab Management (Built-in)

| Shortcut | Mode | Action | Description |
|----------|------|--------|-------------|
| `<Alt-]>` | Normal | `:tabnext<CR>` | Next tab |
| `<Alt-[>` | Normal | `:tabprevious<CR>` | Previous tab |
| `<Cmd-w>` | Normal | `:tabclose<CR>` | Close current tab |
| `<Cmd-t>` | Normal | `:tabnew<CR>` | New tab |

## Visual Mode (Built-in)

| Shortcut | Mode | Action | Description |
|----------|------|--------|-------------|
| `<` | Visual | `<gv` | Indent left and reselect |
| `>` | Visual | `>gv` | Indent right and reselect |

## Insert Mode (Built-in)

| Shortcut | Mode | Action | Description |
|----------|------|--------|-------------|
| `jk` | Insert | `<Esc>` | Exit insert mode |
| `kj` | Insert | `<Esc>` | Exit insert mode |

## Command Mode (Built-in)

| Shortcut | Mode | Action | Description |
|----------|------|--------|-------------|
| `<C-a>` | Command | `<Home>` | Go to beginning of line |
| `<C-e>` | Command | `<End>` | Go to end of line |

## Terminal Mode (Built-in)

| Shortcut | Mode | Action | Description |
|----------|------|--------|-------------|
| `<Esc>` | Terminal | `<C-\><C-n>` | Exit terminal mode |
| `<C-h>` | Terminal | `<C-\><C-n><C-w>h` | Exit terminal and move to left window |
| `<C-j>` | Terminal | `<C-\><C-n><C-w>j` | Exit terminal and move to window below |
| `<C-k>` | Terminal | `<C-\><C-n><C-w>k` | Exit terminal and move to window above |
| `<C-l>` | Terminal | `<C-\><C-n><C-w>l` | Exit terminal and move to right window |

## LSP (Language Server Protocol) - Built-in LSP

| Shortcut | Mode | Action | Description |
|----------|------|--------|-------------|
| `<leader>d` | Normal | `vim.diagnostic.open_float` | Show line diagnostics |
| `gd` | Normal | `vim.lsp.buf.definition` | Go to definition |
| `gD` | Normal | `vim.lsp.buf.declaration` | Go to declaration |
| `gr` | Normal | `vim.lsp.buf.references` | Go to references |
| `gi` | Normal | `vim.lsp.buf.implementation` | Go to implementation |
| `K` | Normal | `vim.lsp.buf.hover` | Show hover documentation |
| `<C-k>` | Normal | `vim.lsp.buf.signature_help` | Show signature help |
| `<leader>rn` | Normal | `vim.lsp.buf.rename` | Rename symbol |
| `<leader>ca` | Normal | `vim.lsp.buf.code_action` | Show code actions |
| `<leader>f` | Normal | `vim.lsp.buf.format({ async = true })` | Format code |

## Telescope Plugin (lua/plugins/telescope.lua)

| Shortcut | Mode | Action | Description |
|----------|------|--------|-------------|
| `<leader>ff` | Normal | `:Telescope find_files<CR>` | Find files |
| `<Cmd-p>` | Normal | `:Telescope find_files<CR>` | Find files (VS Code style) |
| `<leader>fg` | Normal | `:Telescope live_grep<CR>` | Live grep search |
| `<Cmd-f>` | Normal | `:Telescope live_grep<CR>` | Live grep (VS Code style) |
| `<C-r>` | Normal | `:Telescope live_grep<CR>` | Live grep (Ctrl+R) |
| `<leader>fb` | Normal | `:Telescope buffers<CR>` | Find buffers |
| `<leader>fh` | Normal | `:Telescope help_tags<CR>` | Search help tags |
| `<leader>fc` | Normal | `:Telescope commands<CR>` | Search commands |
| `<leader>fk` | Normal | `:Telescope keymaps<CR>` | Search keymaps |
| `<leader>fr` | Normal | `:Telescope oldfiles<CR>` | Recent files |
| `<Cmd-Shift-O>` | Normal | `:Telescope treesitter<CR>` | Search document symbols (Treesitter) |

### Telescope Internal Mappings (Within Telescope)
| Shortcut | Mode | Action | Description |
|----------|------|--------|-------------|
| `<C-c>` | Insert/Normal | Close telescope | Close telescope picker |
| `<Esc>` | Insert/Normal | Close telescope | Close telescope picker |
| `<CR>` | Insert/Normal | Select in tab | Open selection in new tab |
| `<Cmd-CR>` | Insert/Normal | Select vertical | Open selection in vertical split |

## Git Integration - Gitsigns Plugin (lua/plugins/git.lua)

### Git Navigation
| Shortcut | Mode | Action | Description |
|----------|------|--------|-------------|
| `]c` | Normal | Next git hunk | Navigate to next git change |
| `[c` | Normal | Previous git hunk | Navigate to previous git change |

### Git Actions
| Shortcut | Mode | Action | Description |
|----------|------|--------|-------------|
| `<leader>hs` | Normal | Stage hunk | Stage current git hunk |
| `<leader>hr` | Normal | Reset hunk | Reset current git hunk |
| `<leader>hs` | Visual | Stage hunk (visual) | Stage selected git hunk |
| `<leader>hr` | Visual | Reset hunk (visual) | Reset selected git hunk |
| `<leader>hS` | Normal | Stage buffer | Stage entire buffer |
| `<leader>hu` | Normal | Undo stage hunk | Undo stage hunk |
| `<leader>hR` | Normal | Reset buffer | Reset entire buffer |
| `<leader>hp` | Normal | Preview hunk | Preview git hunk changes |
| `<leader>hb` | Normal | Blame line | Show git blame for current line |
| `<leader>hd` | Normal | Diff this | Show diff for current file |
| `<leader>hD` | Normal | Diff this ~ | Show diff against HEAD~ |

### Git Toggles
| Shortcut | Mode | Action | Description |
|----------|------|--------|-------------|
| `<leader>tb` | Normal | Toggle line blame | Toggle git blame display |
| `<leader>td` | Normal | Toggle deleted | Toggle showing deleted lines |

### Git Text Objects
| Shortcut | Mode | Action | Description |
|----------|------|--------|-------------|
| `ih` | Operator/Visual | Select hunk | Select git hunk as text object |

## GitHub Copilot - Copilot Plugin (lua/plugins/coding.lua)

| Shortcut | Mode | Action | Description |
|----------|------|--------|-------------|
| `<C-J>` | Insert | Accept suggestion | Accept Copilot suggestion |
| `<C-;>` | Insert | Dismiss suggestion | Dismiss Copilot suggestion |
| `<Alt-]>` | Insert | Next suggestion | Show next Copilot suggestion |
| `<Alt-[>` | Insert | Previous suggestion | Show previous Copilot suggestion |

## URL Opening (Built-in)

| Shortcut | Mode | Action | Description |
|----------|------|--------|-------------|
| `gx` | Normal | Open URL | Open URL under cursor in browser |

## Notes

- `<leader>` is typically mapped to the space key
- `<Cmd>` refers to the Cmd key on Mac (equivalent to Windows key on Windows/Linux)
- `<Alt>` refers to the Alt/Option key
- `<C->` refers to the Ctrl key
- Some shortcuts may conflict with system shortcuts depending on your terminal/OS configuration
- Plugin-specific shortcuts are only available when the respective plugin is loaded and active
