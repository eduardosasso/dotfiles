return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = false,
  priority = 1000,
  config = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    require("nvim-tree").setup({
      sort = { sorter = "case_sensitive" },
      view = {
        width = 35,
        side = "left",
        preserve_window_proportions = false,
        number = false,
        relativenumber = false,
        signcolumn = "yes",
      },
      renderer = {
        group_empty = false,
        highlight_git = true,
        full_name = false,
        highlight_opened_files = "none",
        highlight_modified = "none",
        root_folder_label = ":t",
        indent_width = 2,
        indent_markers = { enable = false, inline_arrows = true },
        icons = {
          webdev_colors = true,
          git_placement = "before",
          modified_placement = "after",
          padding = " ",
          symlink_arrow = " ➛ ",
          show = {
            file = true,
            folder = false,
            folder_arrow = true,
            git = true,
            modified = true,
          },
          glyphs = {
            default = "",
            symlink = "",
            bookmark = "󰆤",
            modified = "●",
            folder = {
              arrow_closed = "",
              arrow_open = "",
              default = "",
              open = "",
              empty = "",
              empty_open = "",
              symlink = "",
              symlink_open = "",
            },
            git = {
              unstaged = "",
              staged = "",
              unmerged = "",
              renamed = "",
              untracked = "",
              deleted = "",
              ignored = "",
            },
          },
        },
        special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
        symlink_destination = true,
      },
      filters = {
        dotfiles = false,
        git_clean = false,
        no_buffer = false,
        custom = {},
        exclude = {},
      },
      disable_netrw = true,
      hijack_netrw = true,
      hijack_cursor = false,
      hijack_unnamed_buffer_when_opening = false,
      hijack_directories = {
        enable = false,  -- Don't automatically open when doing 'nvim .'
        auto_open = false,
      },
      sync_root_with_cwd = true,
      respect_buf_cwd = true,
      prefer_startup_root = false,
      update_focused_file = {
        enable = true,
        update_cwd = false,
        ignore_list = {},
      },
      on_attach = function(bufnr)
        local api = require "nvim-tree.api"
        
        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        -- Smart buffer naming
        local current_buf = vim.api.nvim_get_current_buf()
        local current_file = vim.api.nvim_buf_get_name(current_buf)
        local base_name = current_file ~= "" and vim.fn.fnamemodify(current_file, ":t") or "nvim-tree"

        local counter = 1
        local buffer_name = base_name

        while vim.fn.bufexists(buffer_name) == 1 do
          local existing_bufnr = vim.fn.bufnr(buffer_name)
          if existing_bufnr ~= bufnr and existing_bufnr ~= -1 then
            counter = counter + 1
            buffer_name = base_name .. "_" .. counter
          else
            break
          end
        end

        vim.api.nvim_buf_set_name(bufnr, buffer_name)

        -- Default mappings
        api.config.mappings.default_on_attach(bufnr)
      end,
      git = {
        enable = true,
        ignore = true,
        show_on_dirs = true,
        show_on_open_dirs = true,
        timeout = 400,
      },
      diagnostics = { enable = false },
      modified = { enable = false },
      filesystem_watchers = { enable = true, debounce_delay = 50 },
      actions = {
        use_system_clipboard = true,
        change_dir = { enable = true, global = false },
        expand_all = { max_folder_discovery = 300 },
        open_file = {
          quit_on_open = false,
          resize_window = true,
          window_picker = {
            enable = true,
            picker = "default",
            chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
          },
        },
        remove_file = { close_window = true },
      },
      trash = { cmd = "gio trash" },
      live_filter = { prefix = "[FILTER]: ", always_show_folders = true },
      notify = { threshold = vim.log.levels.INFO },
    })

    -- Git highlights
    vim.schedule(function()
      local git_highlights = {
        NvimTreeGitDirty = { fg = "#ffffff", bold = true },
        NvimTreeGitStaged = { fg = "#ffffff", bold = true },
        NvimTreeGitMerge = { fg = "#ffffff", bold = true },
        NvimTreeGitRenamed = { fg = "#ffffff", bold = true },
        NvimTreeGitNew = { fg = "#ffffff", bold = true },
        NvimTreeGitDeleted = { fg = "#f7768e", bold = true },
        NvimTreeGitDirtyFolderName = { fg = "#ffffff", bold = true },
        NvimTreeGitStagedFolderName = { fg = "#ffffff", bold = true },
        NvimTreeGitNewFolderName = { fg = "#ffffff", bold = true },
        NvimTreeGitDeletedFolderName = { fg = "#f7768e", bold = true },
      }

      for group, opts in pairs(git_highlights) do
        vim.api.nvim_set_hl(0, group, opts)
      end
    end)
  end,
}