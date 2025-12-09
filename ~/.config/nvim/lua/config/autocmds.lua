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

-- Clean up empty/alpha buffers when opening a real file
autocmd("BufEnter", {
    callback = function()
        local bufnr = vim.api.nvim_get_current_buf()
        local bufname = vim.api.nvim_buf_get_name(bufnr)
        -- If current buffer has a name (is a real file)
        if bufname ~= "" and not bufname:match("NvimTree") then
            -- Find and delete empty/alpha buffers
            for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                if buf ~= bufnr and vim.api.nvim_buf_is_valid(buf) then
                    local name = vim.api.nvim_buf_get_name(buf)
                    local ft = vim.bo[buf].filetype
                    if name == "" or ft == "alpha" then
                        vim.api.nvim_buf_delete(buf, { force = true })
                    end
                end
            end
        end
    end
})