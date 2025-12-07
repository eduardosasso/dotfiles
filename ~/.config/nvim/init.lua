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
-- tabline replaced by bufferline plugin

-- Setup plugins
require("lazy").setup("plugins")

-- =============================================================================
-- Configuration complete - Modern, modular, maintainable
-- =============================================================================