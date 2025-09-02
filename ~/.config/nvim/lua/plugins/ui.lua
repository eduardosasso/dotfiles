return {
  -- Lualine statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local colors = {
        blue   = '#7aa2f7',
        cyan   = '#7dcfff', 
        black  = '#1a1b26',
        white  = '#c0caf5',
        red    = '#f7768e',
        violet = '#9d7cd8',
        grey   = '#414868',
      }

      local bubbles_theme = {
        normal = {
          a = { fg = colors.black, bg = colors.violet },
          b = { fg = colors.white, bg = colors.grey },
          c = { fg = colors.white },
        },
        insert = { a = { fg = colors.black, bg = colors.blue } },
        visual = { a = { fg = colors.black, bg = colors.cyan } },
        replace = { a = { fg = colors.black, bg = colors.red } },
        inactive = {
          a = { fg = colors.white, bg = colors.black },
          b = { fg = colors.white, bg = colors.black },
          c = { fg = colors.white },
        },
      }

      require("lualine").setup({
        options = {
          theme = bubbles_theme,
          component_separators = '',
          section_separators = { left = '\u{e0b0}', right = '\u{e0b2}' },
          globalstatus = true,
        },
        sections = {
          lualine_a = { { 'mode', right_padding = 2 } },
          lualine_b = { 'branch' },
          lualine_c = {
            { 'filename', path = 1 },
            {
              "diff",
              symbols = { added = "+", modified = "~", removed = "-" },
              diff_color = {
                added = { fg = '#7aa2a0', gui = 'bold' },
                modified = { fg = '#b8aa7a', gui = 'bold' },
                removed = { fg = '#b87a7a', gui = 'bold' }
              },
            }
          },
          lualine_x = { 'diagnostics' },
          lualine_y = { { 'progress', fmt = function(str) return str:gsub('Bot', 'End') end } },
          lualine_z = { { 'location', left_padding = 1 } }
        },
        inactive_sections = {
          lualine_c = { "filename" },
          lualine_x = { "location" },
        },
      })
      
      vim.opt.laststatus = 3
      vim.opt.cmdheight = 1
      vim.opt.ruler = false
    end,
  },

  -- Web devicons
  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup({ default = true })
    end,
  },
}