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

-- Suppress position_encoding warnings (plugins not yet updated for Neovim 0.11+)
local original_make_position_params = vim.lsp.util.make_position_params
vim.lsp.util.make_position_params = function(window, offset_encoding)
  offset_encoding = offset_encoding or "utf-16"
  return original_make_position_params(window, offset_encoding)
end

local original_get_offset_encoding = vim.lsp.util._get_offset_encoding
vim.lsp.util._get_offset_encoding = function(bufnr)
  local clients = vim.lsp.get_clients({ bufnr = bufnr })
  if #clients == 0 then return "utf-16" end
  return clients[1].offset_encoding or "utf-16"
end

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