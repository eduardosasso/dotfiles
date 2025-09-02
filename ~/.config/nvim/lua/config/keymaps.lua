-- Key mappings
local map = vim.keymap.set
local silent = { silent = true }

-- Clear search highlighting
map("n", "<Esc>", ":nohlsearch<CR><Esc>", silent)

-- Window navigation
map("n", "<C-h>", "<C-w>h", silent)
map("n", "<C-j>", "<C-w>j", silent)
map("n", "<C-k>", "<C-w>k", silent)
map("n", "<C-l>", "<C-w>l", silent)

-- Quick save and quit
map("n", "<leader>w", ":write<CR>", silent)
map("n", "<leader>q", ":quit<CR>", silent)

-- Toggles
map("n", "<leader>un", function() vim.o.relativenumber = not vim.o.relativenumber end, { desc = "Toggle relative numbers" })
map("n", "<leader>ul", function() vim.o.list = not vim.o.list end, { desc = "Toggle listchars" })
map("n", "<leader>us", function() vim.o.spell = not vim.o.spell end, { desc = "Toggle spell check" })
map("n", "<leader>uh", function() vim.o.hlsearch = not vim.o.hlsearch end, { desc = "Toggle search highlight" })

-- Config
map("n", "<leader>ev", ":edit $MYVIMRC<CR>", { desc = "Edit config" })
map("n", "<leader>rr", ":qa<CR>", { desc = "Restart Neovim" })
map("n", "Q", ":qa<CR>", { desc = "Quit all" })



-- File explorer
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
map("n", "<leader>ef", "<cmd>NvimTreeFindFile<CR>", { desc = "Find current file in explorer" })
map("n", "<D-e>", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer (Cmd+E)" })
map("n", "<D-b>", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer (Cmd+B)" })

-- Tabs
map("n", "<M-]>", "<cmd>tabnext<CR>", { desc = "Next tab (Alt+])" })
map("n", "<M-[>", "<cmd>tabprevious<CR>", { desc = "Previous tab (Alt+[)" })
map("n", "<D-w>", "<cmd>tabclose<CR>", { desc = "Close tab (Cmd+W)" })
map("n", "<D-t>", "<cmd>tabnew<CR>", { desc = "New tab (Cmd+T)" })

-- Visual mode
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Insert mode
map("i", "jk", "<Esc>")
map("i", "kj", "<Esc>")

-- Command mode
map("c", "<C-a>", "<Home>")
map("c", "<C-e>", "<End>")

-- Terminal
map("t", "<Esc>", "<C-\\><C-n>", silent)
map("t", "<C-h>", "<C-\\><C-n><C-w>h", silent)
map("t", "<C-j>", "<C-\\><C-n><C-w>j", silent)
map("t", "<C-k>", "<C-\\><C-n><C-w>k", silent)
map("t", "<C-l>", "<C-\\><C-n><C-w>l", silent)

-- LSP
map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Line diagnostics" })
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
map("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
map("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
map("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature help" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
map("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, { desc = "Format code" })

-- Telescope
map("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Find files" })
map("n", "<D-p>", ":Telescope find_files<CR>", { desc = "Find files (VS Code style)" })
map("n", "<leader>fg", ":Telescope live_grep<CR>", { desc = "Live grep" })
map("n", "<D-f>", ":Telescope live_grep<CR>", { desc = "Live grep (VS Code style)" })
map("n", "<C-r>", ":Telescope live_grep<CR>", { desc = "Live grep (Ctrl+R)" })
map("n", "<leader>fb", ":Telescope buffers<CR>", { desc = "Find buffers" })
map("n", "<leader>fh", ":Telescope help_tags<CR>", { desc = "Help tags" })
map("n", "<leader>fc", ":Telescope commands<CR>", { desc = "Commands" })
map("n", "<leader>fk", ":Telescope keymaps<CR>", { desc = "Keymaps" })
map("n", "<leader>fr", ":Telescope oldfiles<CR>", { desc = "Recent files" })
map("n", "<D-O>", ":Telescope treesitter<CR>", { desc = "Treesitter symbols (Cmd+Shift+O)" })

-- macOS open URL
map("n", "gx", function()
    local url = vim.fn.expand('<cfile>')
    if url ~= '' then
        vim.fn.jobstart({ 'open', url }, { detach = true })
    end
end, { desc = "Open with macOS", silent = true })
