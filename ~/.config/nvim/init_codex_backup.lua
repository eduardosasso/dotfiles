-- Neovim minimal, Mac-friendly defaults with concise notes.
-- Safe to source alongside your main init; does not require plugins.

-- Leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = ","

local opt = vim.opt

-- UI & ergonomics
opt.number = true
opt.relativenumber = false
opt.cursorline = true
opt.signcolumn = "yes"          -- keep sign column stable to avoid text shifting
opt.scrolloff = 4                -- keep context lines visible when scrolling
opt.wrap = false                 -- avoid soft-wrapping long lines
opt.termguicolors = true         -- enable 24-bit colors in capable terminals
opt.splitright = true            -- vertical splits open to the right
opt.splitbelow = true            -- horizontal splits open below

-- Search behavior
opt.ignorecase = true            -- case-insensitive by default
opt.smartcase = true             -- but become case-sensitive if search has capitals
opt.incsearch = true             -- live update while typing a search
opt.hlsearch = true
opt.inccommand = "nosplit"       -- live preview for :substitute without opening a split

-- Tabs & indentation (tweak to taste per-language via ftplugins later)
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.smartindent = true

-- Completion UX (plays well with LSP/cmp if added later)
opt.completeopt = { "menu", "menuone", "noselect" }

-- Performance & timing
opt.updatetime = 200             -- faster CursorHold/diagnostics updates
opt.timeoutlen = 400             -- snappier mapped sequence timeout without being too tight

-- Files, undo, and backups
opt.swapfile = false             -- reduce clutter; rely on persistent undo instead
opt.backup = false
opt.writebackup = false
opt.undofile = true              -- persist undo history across sessions

-- Ensure undo directory exists inside Neovim state path
do
  local undodir = vim.fn.stdpath('state') .. '/undo'
  if vim.fn.isdirectory(undodir) == 0 then
    vim.fn.mkdir(undodir, 'p')
  end
  opt.undodir = undodir
end

-- System clipboard (macOS pbcopy/pbpaste via provider)
opt.clipboard = "unnamedplus"    -- use the OS clipboard for all yanks/pastes

-- Show invisible characters; quick toggle below
opt.list = false
opt.listchars = {
  tab = '» ', trail = '·', extends = '›', precedes = '‹', nbsp = '␣'
}

-- Netrw quality-of-life
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_browse_split = 0     -- open in the current window by default
vim.g.netrw_use_errorwindow = 0
vim.g.netrw_browsex_viewer = 'open' -- macOS: use `open` for gx on files/URLs

-- Colorscheme (built-in; safe without plugins)
pcall(vim.cmd.colorscheme, 'habamax')

-- Keymaps
local map = vim.keymap.set
local silent = { silent = true }

-- Window navigation with Ctrl + h/j/k/l
map('n', '<C-h>', '<C-w>h', silent)
map('n', '<C-j>', '<C-w>j', silent)
map('n', '<C-k>', '<C-w>k', silent)
map('n', '<C-l>', '<C-w>l', silent)

-- Fast save/quit
map('n', '<leader>w', ':write<CR>', silent)
map('n', '<leader>q', ':quit<CR>', silent)

-- Clear search highlight quickly
map('n', '<Esc>', ':nohlsearch<CR><Esc>', silent)

-- Handy toggles
map('n', '<leader>un', function()
  opt.relativenumber = not opt.relativenumber:get()
end, { desc = 'Toggle relative number' })

map('n', '<leader>ul', function()
  opt.list = not opt.list:get()
end, { desc = 'Toggle listchars' })

map('n', '<leader>us', function()
  opt.spell = not opt.spell:get()
end, { desc = 'Toggle spell' })

map('n', '<leader>uh', function()
  opt.hlsearch = not opt.hlsearch:get()
end, { desc = 'Toggle search highlight' })

-- Quick access to diagnostics float without LSP setup
map('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Line diagnostics' })

-- macOS: open URL/file under cursor using `open` (fallback if netrw not active)
map('n', 'gx', function()
  local url = vim.fn.expand('<cfile>')
  if url ~= '' then
    vim.fn.jobstart({ 'open', url }, { detach = true })
  end
end, { desc = 'Open with macOS open(1)', silent = true })

-- Tips:
-- - Use <leader>un/<leader>ul/<leader>us/<leader>uh to toggle UI features
-- - Adjust shiftwidth/tabstop per project in .editorconfig or ftplugins
