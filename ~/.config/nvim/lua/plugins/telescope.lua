return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons"
  },
  config = function()
    require("telescope").setup({
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        path_display = { "truncate" },
        file_ignore_patterns = {
          "node_modules/", ".git/", "target/", "build/", "dist/", "%.lock"
        },
        layout_config = {
          horizontal = {
            preview_width = 0.55,
            results_width = 0.8,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
        case_insensitive = true,
        vimgrep_arguments = {
          "rg", "--color=never", "--no-heading", "--with-filename",
          "--line-number", "--column", "--smart-case",
        },
        mappings = {
          i = {
            ["<C-c>"] = require("telescope.actions").close,
            ["<Esc>"] = require("telescope.actions").close,
            ["<CR>"] = require("telescope.actions").select_tab,
            ["<D-CR>"] = require("telescope.actions").select_vertical,
          },
          n = {
            ["<C-c>"] = require("telescope.actions").close,
            ["<Esc>"] = require("telescope.actions").close,
            ["<CR>"] = require("telescope.actions").select_tab,
            ["<D-CR>"] = require("telescope.actions").select_vertical,
          },
        },
      },
      pickers = {
        find_files = { theme = "dropdown", previewer = false },
        buffers = { theme = "dropdown", previewer = false },
      },
    })
  end,
}