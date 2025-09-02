-- Basic Neovim settings
local opt = vim.opt

-- Leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- UI
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.cursorlineopt = "number"
opt.signcolumn = "yes"
opt.scrolloff = 4
opt.wrap = false
opt.showmatch = true
opt.laststatus = 0

-- Search
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.inccommand = "nosplit"

-- Indentation
opt.autoindent = true
opt.smartindent = true
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.shiftround = true

-- Files
opt.autoread = true
opt.hidden = true
opt.confirm = true
opt.splitright = true
opt.splitbelow = true

-- Backup
opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.undofile = true

-- Undo directory
do
    local undodir = vim.fn.stdpath('state') .. '/undo'
    if vim.fn.isdirectory(undodir) == 0 then
        vim.fn.mkdir(undodir, 'p')
    end
    opt.undodir = undodir
end

-- Mac specific
opt.clipboard = "unnamedplus"
opt.mouse = "a"

-- Colors
opt.termguicolors = true
opt.background = "dark"

-- Invisible characters
opt.list = false
opt.listchars = {
    tab = '» ',
    trail = '·',
    extends = '›',
    precedes = '‹',
    nbsp = '␣'
}

-- Performance
opt.updatetime = 200
opt.timeoutlen = 400

-- Tabs
opt.showtabline = 2

-- Completion
opt.completeopt = { "menu", "menuone", "noselect" }

-- Netrw
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_browse_split = 0
vim.g.netrw_use_errorwindow = 0
vim.g.netrw_browsex_viewer = 'open'
vim.g.netrw_statusline = ""