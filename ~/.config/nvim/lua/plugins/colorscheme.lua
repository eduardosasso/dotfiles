return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("tokyonight").setup({
      style = "night",
      light_style = "day",
      transparent = false,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        sidebars = "dark",
        floats = "dark",
      },
      sidebars = { "qf", "help" },
      day_brightness = 0.3,
      hide_inactive_statusline = false,
      dim_inactive = false,
      lualine_bold = false,
    })

    vim.cmd.colorscheme("tokyonight")
    vim.api.nvim_set_hl(0, 'LualineDiffBold', { bold = true, fg = nil })
    
    -- Match main editor background to sidebar background
    local colors = require("tokyonight.colors").setup()
    vim.api.nvim_set_hl(0, 'Normal', { bg = colors.bg_sidebar })
    vim.api.nvim_set_hl(0, 'NormalNC', { bg = colors.bg_sidebar })
    vim.api.nvim_set_hl(0, 'SignColumn', { bg = colors.bg_sidebar })
    
    -- Preserve original line number colors, only change background
    local linenr_hl = vim.api.nvim_get_hl(0, { name = 'LineNr' })
    local cursorlinenr_hl = vim.api.nvim_get_hl(0, { name = 'CursorLineNr' })
    
    vim.api.nvim_set_hl(0, 'LineNr', { bg = colors.bg_sidebar, fg = linenr_hl.fg })
    vim.api.nvim_set_hl(0, 'CursorLineNr', { bg = colors.bg_sidebar, fg = cursorlinenr_hl.fg, bold = true })
  end,
}
