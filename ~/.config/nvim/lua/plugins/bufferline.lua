return {
  "akinsho/bufferline.nvim",
  version = "*",
  config = function()
    -- Mode colors matching lualine
    local mode_colors = {
      normal = '#9d7cd8',  -- violet
      insert = '#7aa2f7',  -- blue
      visual = '#7dcfff',  -- cyan
      replace = '#f7768e', -- red
    }

    local function update_bufferline_colors()
      local mode = vim.fn.mode()
      local bg_color = mode_colors.normal

      if mode == 'i' then
        bg_color = mode_colors.insert
      elseif mode == 'v' or mode == 'V' or mode == '' then
        bg_color = mode_colors.visual
      elseif mode == 'R' then
        bg_color = mode_colors.replace
      end

      vim.api.nvim_set_hl(0, 'BufferLineBufferSelected', { fg = '#1a1b26', bg = bg_color, bold = true })
      vim.api.nvim_set_hl(0, 'BufferLineIndicatorSelected', { fg = bg_color, bg = bg_color })
    end

    require("bufferline").setup({
      options = {
        mode = "buffers",
        style_preset = require("bufferline").style_preset.minimal,
        close_command = "bdelete! %d",
        right_mouse_command = "bdelete! %d",
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level)
          return " " .. count
        end,
        offsets = {
          {
            filetype = "NvimTree",
            text = "File Explorer",
            highlight = "Directory",
            separator = true,
          },
        },
        show_buffer_icons = false,
        show_buffer_close_icons = false,
        show_close_icon = false,
        separator_style = "thin",
        always_show_bufferline = true,
      },
    })

    -- Update colors on mode change
    vim.api.nvim_create_autocmd("ModeChanged", {
      pattern = "*",
      callback = update_bufferline_colors,
    })

    -- Set initial colors
    update_bufferline_colors()
  end,
}
