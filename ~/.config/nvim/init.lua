-- =============================================================================
-- Optimized NeoVim Configuration (Modern Lua)
-- Modular, clean, and maintainable structure
-- =============================================================================

-- Bootstrap lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load core configuration modules
require("config.options")    -- Basic Neovim settings
require("config.keymaps")    -- Key mappings  
require("config.autocmds")   -- Auto commands
require("config.tabline")    -- Custom tabline

-- Setup plugins
require("lazy").setup("plugins", {
  checker = {
    enabled = true,        -- Enable update checker
    notify = true,         -- Show notification when updates available
    frequency = 3600,      -- Check every hour (3600 seconds)
  },
  change_detection = {
    enabled = true,        -- Enable change detection
    notify = true,         -- Show notification when config changes
  },
})

-- =============================================================================
-- Configuration complete - Modern, modular, maintainable
-- =============================================================================