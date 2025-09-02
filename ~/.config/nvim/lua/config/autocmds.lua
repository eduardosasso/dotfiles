-- Auto commands
local autocmd = vim.api.nvim_create_autocmd

-- Language-specific indentation
autocmd("FileType", {
    pattern = "python",
    callback = function()
        vim.bo.tabstop = 4
        vim.bo.shiftwidth = 4
        vim.bo.softtabstop = 4
    end
})

autocmd("FileType", {
    pattern = "make",
    callback = function()
        vim.bo.expandtab = false
    end
})

-- Remove trailing whitespace on save
autocmd("BufWritePre", {
    pattern = "*",
    command = [[%s/\s\+$//e]]
})

-- Return to last edit position
autocmd("BufReadPost", {
    pattern = "*",
    callback = function()
        local last_pos = vim.fn.line("'\"")
        if last_pos > 0 and last_pos <= vim.fn.line("$") then
            vim.api.nvim_win_set_cursor(0, {last_pos, 0})
        end
    end
})

-- Terminal settings
autocmd("TermOpen", {
    pattern = "*",
    callback = function()
        vim.bo.number = false
        vim.bo.relativenumber = false
        vim.cmd("startinsert")
    end
})

-- Highlight on yank
autocmd("TextYankPost", {
    pattern = "*",
    callback = function()
        vim.highlight.on_yank()
    end
})