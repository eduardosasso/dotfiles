-- =============================================================================
-- NeoVim Configuration for Mac (Modern Lua)
-- Minimal, Mac-friendly defaults with clean organization
-- =============================================================================

-- Set leader keys early
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Bootstrap lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Basic Settings
-- =============================================================================
local opt = vim.opt

opt.number = true               -- Show line numbers
opt.relativenumber = true       -- Show relative line numbers
opt.cursorline = true           -- Enable cursorline for line number highlighting
opt.cursorlineopt = "number"       -- Only highlight the line number, not the entire line
opt.signcolumn = "yes"          -- Keep sign column stable (prevents text shifting)
opt.scrolloff = 4               -- Keep context lines visible when scrolling
opt.wrap = false                -- Avoid soft-wrapping long lines
opt.showmatch = true            -- Show matching brackets
opt.laststatus = 0              -- Disable default statusline (lualine will handle it)

-- Search Settings
-- =============================================================================
opt.hlsearch = true             -- Highlight search matches
opt.incsearch = true            -- Incremental search
opt.ignorecase = true           -- Case insensitive searching
opt.smartcase = true            -- Case sensitive if uppercase present
opt.inccommand = "nosplit"      -- Live preview for :substitute

-- Indentation and Formatting (Modern defaults)
-- =============================================================================
opt.autoindent = true           -- Copy indent from current line
opt.smartindent = true          -- Smart autoindenting
opt.expandtab = true            -- Use spaces instead of tabs
opt.tabstop = 2                 -- 2 spaces per tab (modern default)
opt.shiftwidth = 2              -- 2 spaces for autoindent
opt.softtabstop = 2             -- 2 spaces for editing
opt.shiftround = true           -- Round indent to multiple of shiftwidth

-- File and Buffer Settings
-- =============================================================================
opt.autoread = true             -- Auto reload files changed outside vim
opt.hidden = true               -- Allow switching buffers without saving
opt.confirm = true              -- Confirm before closing unsaved files
opt.splitright = true           -- Vertical splits open to the right
opt.splitbelow = true           -- Horizontal splits open below

-- Backup and Swap Files
-- =============================================================================
opt.backup = false              -- Don't create backup files
opt.writebackup = false         -- Don't create backup before overwriting
opt.swapfile = false            -- Don't create swap files
opt.undofile = true             -- Persistent undo

-- Ensure undo directory exists using proper XDG paths
do
    local undodir = vim.fn.stdpath('state') .. '/undo'
    if vim.fn.isdirectory(undodir) == 0 then
        vim.fn.mkdir(undodir, 'p')
    end
    opt.undodir = undodir
end

-- Mac-Specific Settings
-- =============================================================================
opt.clipboard = "unnamedplus"   -- Use system clipboard
opt.mouse = "a"                 -- Enable mouse support

-- Colors and Appearance
-- =============================================================================
opt.termguicolors = true        -- Enable 24-bit RGB colors
opt.background = "dark"         -- Dark background

-- Plugin Setup
-- =============================================================================
require("lazy").setup({
  -- Tokyo Night colorscheme
  {
    "folke/tokyonight.nvim",
    lazy = false, -- make sure we load this during startup
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- Tokyo Night configuration
      require("tokyonight").setup({
        style = "night", -- Options: "storm", "moon", "night", "day"
        light_style = "day", -- Style for when background is light
        transparent = false, -- Enable transparent background
        terminal_colors = true, -- Configure terminal colors
        styles = {
          comments = { italic = true },
          keywords = { italic = true },
          functions = {},
          variables = {},
          sidebars = "dark", -- "dark", "transparent" or "normal"
          floats = "dark", -- "dark", "transparent" or "normal"
        },
        sidebars = { "qf", "help" }, -- Darker sidebars
        day_brightness = 0.3, -- Adjusts brightness of colors in day style
        hide_inactive_statusline = false, -- Hide statuslines on inactive windows
        dim_inactive = false, -- Dims inactive windows
        lualine_bold = false, -- Bold section headers in lualine
      })
      
      -- Load the colorscheme
      vim.cmd.colorscheme("tokyonight")
      
      -- Custom highlight for bold diff in lualine
      vim.api.nvim_set_hl(0, 'LualineDiffBold', { bold = true, fg = nil })
    end,
  },

  -- Lualine statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- Optional: for file icons
    config = function()
      require("lualine").setup({
        options = {
          theme = "tokyonight", -- Matches your colorscheme
          component_separators = "",
          section_separators = { left = "", right = "" },
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = true, -- Use single global statusline instead of per-window
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          }
        },
        sections = {
          lualine_a = { { "mode", separator = { left = "", right = "" } } },
          lualine_b = { "branch", "diagnostics" },
          lualine_c = { 
            {
              "filename",
              fmt = function(str)
                if vim.bo.filetype == "NvimTree" then
                  return ""  -- Hide nvim-tree buffer names in statusline
                elseif str:match(".*_?%d+$") and vim.bo.filetype == "NvimTree" then
                  return ""  -- Hide filename_X patterns for nvim-tree
                end
                return str
              end
            },
            { 
              "diff", 
              symbols = { added = "+", modified = "~", removed = "-" },
                              diff_color = {
                  added = { fg = '#7aa2a0', gui = 'bold' },    -- Muted sage green
                  modified = { fg = '#b8aa7a', gui = 'bold' }, -- Muted golden beige
                  removed = { fg = '#b87a7a', gui = 'bold' }   -- Muted dusty rose
                },
              fmt = function(str)
                if str and str ~= "" then
                  -- Make text smaller using a smaller font variant
                  return str:gsub("([+~%-])(%d+)", function(symbol, number)
                    return symbol .. number
                  end)
                end
                return str
              end
            }
          },
          lualine_x = { "encoding", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { { "location", separator = { left = "", right = "" } } }
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {}
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {}
      })
      -- Force disable vim's built-in statusline completely
      vim.opt.laststatus = 3
      vim.opt.cmdheight = 1  -- Show command line (needed for : commands)
      -- Disable vim's ruler which might be showing extra info
      vim.opt.ruler = false
    end,
  },

  -- Web devicons (for file icons in lualine and other plugins)
  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup({
        override = {},
        default = true,
        strict = true,
      })
    end,
  },

  -- Telescope fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { 
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons" 
    },
    config = function()
      require("telescope").setup({
        defaults = {
          -- Default configuration for telescope goes here:
          prompt_prefix = " ",
          selection_caret = " ",
          path_display = { "truncate" },
          file_ignore_patterns = {
            "node_modules/",
            ".git/",
            "target/",
            "build/",
            "dist/",
            "%.lock"
          },
          layout_config = {
            horizontal = {
              preview_width = 0.55,
              results_width = 0.8,
            },
            vertical = {
              mirror = false,
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
          },
          borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
          color_devicons = true,
          case_insensitive = true,
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case", -- Smart case: case-insensitive unless uppercase letters are used
          },
          mappings = {
            i = {
              ["<C-c>"] = require("telescope.actions").close,
              ["<Esc>"] = require("telescope.actions").close,
              ["<CR>"] = require("telescope.actions").select_tab,        -- Enter opens in new tab
              ["<D-CR>"] = require("telescope.actions").select_vertical, -- Cmd+Enter opens in vertical split
            },
            n = {
              ["<C-c>"] = require("telescope.actions").close,
              ["<Esc>"] = require("telescope.actions").close,
              ["<CR>"] = require("telescope.actions").select_tab,        -- Enter opens in new tab
              ["<D-CR>"] = require("telescope.actions").select_vertical, -- Cmd+Enter opens in vertical split
            },
          },
        },
        pickers = {
          find_files = {
            theme = "dropdown",
            previewer = false,
          },
          buffers = {
            theme = "dropdown",
            previewer = false,
          },
        },
        extensions = {}
      })
    end,
  },

  -- Plenary dependency for telescope
  {
    "nvim-lua/plenary.nvim",
    lazy = true,
  },

  -- Treesitter for better syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        -- Languages to install parsers for
        ensure_installed = { 
          "lua", "vim", "vimdoc", "query",
          "javascript", "typescript", "tsx", "json",
          "python", "rust", "go", "java",
          "html", "css", "yaml", "toml",
          "markdown", "bash", "fish", "ruby"
        },
        
        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,
        
        -- Automatically install missing parsers when entering buffer
        auto_install = true,
        
        -- List of parsers to ignore installing (for "all")
        ignore_install = {},
        
        highlight = {
          enable = true,
          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },
        
        indent = {
          enable = true
        },
        
        -- Enable incremental selection
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },
      })
    end,
  },

  -- Mason LSP installer
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
          }
        }
      })
    end,
  },

  -- Mason LSP config bridge
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        -- Automatically install these language servers
        ensure_installed = { 
          "lua_ls",        -- Lua
          "ts_ls",         -- TypeScript/JavaScript (new name)
          "pyright",       -- Python
          "rust_analyzer", -- Rust
          "gopls",         -- Go
          "html",          -- HTML
          "cssls",         -- CSS
          "jsonls",        -- JSON
          "solargraph",    -- Ruby
        },
        automatic_installation = true,
      })
    end,
  },

  -- LSP configuration
  {
    "neovim/nvim-lspconfig",
    dependencies = { "mason-lspconfig.nvim" },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      
      -- Enhanced capabilities for better completion
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      
      -- LSP server configurations
      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              runtime = { version = "LuaJIT" },
              diagnostics = { globals = { "vim" } },
              workspace = { 
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
              },
              telemetry = { enable = false },
            },
          },
        },
        ts_ls = {},
        pyright = {},
        rust_analyzer = {},
        gopls = {},
        html = {},
        cssls = {},
        jsonls = {},
        solargraph = {
          settings = {
            solargraph = {
              diagnostics = true,
              completion = true,
            }
          }
        },
      }
      
      -- Setup each server
      for server, config in pairs(servers) do
        config.capabilities = capabilities
        lspconfig[server].setup(config)
      end
      

    end,
  },

  -- File Explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,  -- Load immediately
    priority = 1000,
    config = function()
      -- Disable netrw at the very start of your init.lua (recommended)
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      
      require("nvim-tree").setup({
        sort = {
          sorter = "case_sensitive",
        },
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
          indent_markers = {
            enable = false,
            inline_arrows = true,
            icons = {
              corner = "└",
              edge = "│",
              item = "│",
              bottom = "─",
              none = " ",
            },
          },
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

          -- Smart buffer naming using current file name + counter
          local current_buf = vim.api.nvim_get_current_buf()
          local current_file = vim.api.nvim_buf_get_name(current_buf)
          local base_name = current_file ~= "" and vim.fn.fnamemodify(current_file, ":t") or "nvim-tree"
          
          local counter = 1
          local buffer_name = base_name
          
          -- Check if buffer name exists and increment counter
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

          -- Custom mappings
          vim.keymap.set('n', '<C-]>', api.tree.change_root_to_node,          opts('CD'))
          vim.keymap.set('n', '<C-e>', api.node.open.replace_tree_buffer,     opts('Open: In Place'))
          vim.keymap.set('n', '<C-k>', api.node.show_info_popup,              opts('Info'))
          vim.keymap.set('n', '<C-r>', api.fs.rename_sub,                     opts('Rename: Omit Filename'))
          vim.keymap.set('n', '<C-t>', api.node.open.tab,                     opts('Open: New Tab'))
          vim.keymap.set('n', '<C-v>', api.node.open.vertical,                opts('Open: Vertical Split'))
          vim.keymap.set('n', '<C-x>', api.node.open.horizontal,              opts('Open: Horizontal Split'))
          vim.keymap.set('n', '<BS>',  api.node.navigate.parent_close,        opts('Close Directory'))
          vim.keymap.set('n', '<CR>',  api.node.open.edit,                    opts('Open'))
          vim.keymap.set('n', '<Tab>', api.node.open.preview,                 opts('Open Preview'))
          vim.keymap.set('n', '>',     api.node.navigate.sibling.next,        opts('Next Sibling'))
          vim.keymap.set('n', '<',     api.node.navigate.sibling.prev,        opts('Previous Sibling'))
          vim.keymap.set('n', '.',     api.node.run.cmd,                      opts('Run Command'))
          vim.keymap.set('n', '-',     api.tree.change_root_to_parent,        opts('Up'))
          vim.keymap.set('n', 'a',     api.fs.create,                         opts('Create'))
          vim.keymap.set('n', 'bmv',   api.marks.bulk.move,                   opts('Move Bookmarked'))
          vim.keymap.set('n', 'B',     api.tree.toggle_no_buffer_filter,      opts('Toggle No Buffer'))
          vim.keymap.set('n', 'c',     api.fs.copy.node,                      opts('Copy'))
          vim.keymap.set('n', 'C',     api.tree.toggle_git_clean_filter,      opts('Toggle Git Clean'))
          vim.keymap.set('n', '[c',    api.node.navigate.git.prev,            opts('Prev Git'))
          vim.keymap.set('n', ']c',    api.node.navigate.git.next,            opts('Next Git'))
          vim.keymap.set('n', 'd',     api.fs.remove,                         opts('Delete'))
          vim.keymap.set('n', 'D',     api.fs.trash,                          opts('Trash'))
          vim.keymap.set('n', 'E',     api.tree.expand_all,                   opts('Expand All'))
          vim.keymap.set('n', 'e',     api.fs.rename_basename,                opts('Rename: Basename'))
          vim.keymap.set('n', ']e',    api.node.navigate.diagnostics.next,    opts('Next Diagnostic'))
          vim.keymap.set('n', '[e',    api.node.navigate.diagnostics.prev,    opts('Prev Diagnostic'))
          vim.keymap.set('n', 'F',     api.live_filter.clear,                 opts('Clean Filter'))
          vim.keymap.set('n', 'f',     api.live_filter.start,                 opts('Filter'))
          vim.keymap.set('n', 'g?',    api.tree.toggle_help,                  opts('Help'))
          vim.keymap.set('n', 'gy',    api.fs.copy.absolute_path,             opts('Copy Absolute Path'))
          vim.keymap.set('n', 'H',     api.tree.toggle_hidden_filter,         opts('Toggle Dotfiles'))
          vim.keymap.set('n', 'I',     api.tree.toggle_gitignore_filter,      opts('Toggle Git Ignore'))
          vim.keymap.set('n', 'J',     api.node.navigate.sibling.last,        opts('Last Sibling'))
          vim.keymap.set('n', 'K',     api.node.navigate.sibling.first,       opts('First Sibling'))
          vim.keymap.set('n', 'm',     api.marks.toggle,                      opts('Toggle Bookmark'))
          vim.keymap.set('n', 'o',     api.node.open.edit,                    opts('Open'))
          vim.keymap.set('n', 'O',     api.node.open.no_window_picker,        opts('Open: No Window Picker'))
          vim.keymap.set('n', 'p',     api.fs.paste,                          opts('Paste'))
          vim.keymap.set('n', 'P',     api.node.navigate.parent,              opts('Parent Directory'))
          vim.keymap.set('n', 'q',     api.tree.close,                        opts('Close'))
          vim.keymap.set('n', 'r',     api.fs.rename,                         opts('Rename'))
          vim.keymap.set('n', 'R',     api.tree.reload,                       opts('Refresh'))
          vim.keymap.set('n', 's',     api.node.run.system,                   opts('Run System'))
          vim.keymap.set('n', 'S',     api.tree.search_node,                  opts('Search'))
          vim.keymap.set('n', 'U',     api.tree.toggle_custom_filter,         opts('Toggle Hidden'))
          vim.keymap.set('n', 'W',     api.tree.collapse_all,                 opts('Collapse'))
          vim.keymap.set('n', 'x',     api.fs.cut,                            opts('Cut'))
          vim.keymap.set('n', 'y',     api.fs.copy.filename,                  opts('Copy Name'))
          vim.keymap.set('n', 'Y',     api.fs.copy.relative_path,             opts('Copy Relative Path'))
          vim.keymap.set('n', '<2-LeftMouse>',  api.node.open.edit,           opts('Open'))
          vim.keymap.set('n', '<2-RightMouse>', api.tree.change_root_to_node, opts('CD'))
        end,
        git = {
          enable = true,
          ignore = true,
          show_on_dirs = true,
          show_on_open_dirs = true,
          timeout = 400,
        },
        diagnostics = {
          enable = false,
          show_on_dirs = false,
          show_on_open_dirs = true,
          debounce_delay = 50,
          severity = {
            min = vim.diagnostic.severity.HINT,
            max = vim.diagnostic.severity.ERROR,
          },
          icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
          },
        },
        modified = {
          enable = false,
          show_on_dirs = true,
          show_on_open_dirs = true,
        },
        filesystem_watchers = {
          enable = true,
          debounce_delay = 50,
          ignore_dirs = {},
        },
        actions = {
          use_system_clipboard = true,
          change_dir = {
            enable = true,
            global = false,
            restrict_above_cwd = false,
          },
          expand_all = {
            max_folder_discovery = 300,
            exclude = {},
          },
          file_popup = {
            open_win_config = {
              col = 1,
              row = 1,
              relative = "cursor",
              border = "shadow",
              style = "minimal",
            },
          },
          open_file = {
            quit_on_open = false,
            resize_window = true,
            window_picker = {
              enable = true,
              picker = "default",
              chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
              exclude = {
                filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
                buftype = { "nofile", "terminal", "help" },
              },
            },
          },
          remove_file = {
            close_window = true,
          },
        },
        trash = {
          cmd = "gio trash",
        },
        live_filter = {
          prefix = "[FILTER]: ",
          always_show_folders = true,
        },
        tab = {
          sync = {
            open = false,
            close = false,
            ignore = {},
          },
        },
        notify = {
          threshold = vim.log.levels.INFO,
        },
        log = {
          enable = false,
          truncate = false,
          types = {
            all = false,
            config = false,
            copy_paste = false,
            dev = false,
            diagnostics = false,
            git = false,
            profile = false,
            watcher = false,
          },
        },
        system_open = {
          cmd = "",
          args = {},
        },
      })
      
      -- Set up Git highlights immediately after nvim-tree setup
      vim.schedule(function()
        -- Force override all possible Git highlight groups
        local git_highlights = {
          NvimTreeGitDirty = { fg = "#ffffff", bold = true },
          NvimTreeGitStaged = { fg = "#ffffff", bold = true },
          NvimTreeGitMerge = { fg = "#ffffff", bold = true },
          NvimTreeGitRenamed = { fg = "#ffffff", bold = true },
          NvimTreeGitNew = { fg = "#ffffff", bold = true },
          NvimTreeGitDeleted = { fg = "#f7768e", bold = true },
          -- Also override any linked groups
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
  },

  -- Smart Commenting
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
      -- Enable Comment.nvim
      require("Comment").setup({
        -- Add a space b/w comment and the line
        padding = true,
        -- Whether the cursor should stay at its position
        sticky = true,
        -- Lines to be ignored while (un)comment
        ignore = nil,
        -- LHS of toggle mappings in NORMAL mode
        toggler = {
          line = 'gcc',       -- Line-comment toggle keymap
          block = 'gbc',      -- Block-comment toggle keymap
        },
        -- LHS of operator-pending mappings in NORMAL and VISUAL mode
        opleader = {
          line = 'gc',        -- Line-comment keymap
          block = 'gb',       -- Block-comment keymap
        },
        -- LHS of extra mappings
        extra = {
          above = 'gcO',      -- Add comment on the line above
          below = 'gco',      -- Add comment on the line below
          eol = 'gcA',        -- Add comment at the end of line
        },
        -- Enable keybindings
        mappings = {
          basic = true,       -- Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
          extra = true,       -- Extra mapping; `gco`, `gcO`, `gcA`
        },
        -- Function to call before (un)comment
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
        -- Function to call after (un)comment
        post_hook = nil,
      })
    end,
  },

  -- Session Management
  {
    "rmagatti/auto-session",
    lazy = false,
    config = function()
      require("auto-session").setup({
        log_level = "error",
        auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
        auto_session_use_git_branch = false,
        auto_session_enable_last_session = false,
        auto_session_root_dir = vim.fn.stdpath('data').."/sessions/",
        auto_session_enabled = true,
        auto_save_enabled = true,
        auto_restore_enabled = true,
        auto_session_create_enabled = true,
        session_lens = {
          buftypes_to_ignore = {},
          load_on_setup = true,
          theme_conf = { border = true },
          previewer = false,
        },
      })
    end,
  },

  -- Git Integration
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("gitsigns").setup({
        signs = {
          add          = { text = "▎" },
          change       = { text = "▎" },
          delete       = { text = "▎" },
          topdelete    = { text = "▔" },
          changedelete = { text = "▎" },
          untracked    = { text = "┆" },
        },
        signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
        numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
        linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir = {
          follow_files = true
        },
        auto_attach = true,
        attach_to_untracked = false,
        current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
          delay = 1000,
          ignore_whitespace = false,
          virt_text_priority = 100,
        },
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil, -- Use default
        max_file_length = 40000, -- Disable if file is longer than this (in lines)
        preview_config = {
          -- Options passed to nvim_open_win
          border = 'single',
          style = 'minimal',
          relative = 'cursor',
          row = 0,
          col = 1
        },
        -- Custom highlight colors for better visibility
        signs_staged_enable = true,
        signs_staged = {
          add          = { text = "▎" },
          change       = { text = "▎" },
          delete       = { text = "▎" },
          topdelete    = { text = "▔" },
          changedelete = { text = "▎" },
        },
        on_attach = function(bufnr)
          -- Set custom highlight colors for git signs
          vim.api.nvim_set_hl(0, 'GitSignsAdd', { fg = '#00ff41', bold = true })           -- Neon green for additions
          vim.api.nvim_set_hl(0, 'GitSignsChange', { fg = '#ffff00', bold = true })        -- Neon yellow for changes  
          vim.api.nvim_set_hl(0, 'GitSignsDelete', { fg = '#dc143c', bold = true })        -- Dark red-pink for deletions
          vim.api.nvim_set_hl(0, 'GitSignsTopdelete', { fg = '#dc143c', bold = true })     -- Dark red-pink for top deletions
          vim.api.nvim_set_hl(0, 'GitSignsChangedelete', { fg = '#bb9af7', bold = true })  -- Purple for change+delete
          vim.api.nvim_set_hl(0, 'GitSignsUntracked', { fg = '#565f89', bold = true })     -- Gray for untracked
          local gitsigns = require('gitsigns')

          local function map(mode, lhs, rhs, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, lhs, rhs, opts)
          end

          -- Navigation
          map('n', ']c', function()
            if vim.wo.diff then
              vim.cmd.normal({']c', bang = true})
            else
              gitsigns.nav_hunk('next')
            end
          end, { desc = 'Next git hunk' })

          map('n', '[c', function()
            if vim.wo.diff then
              vim.cmd.normal({'[c', bang = true})
            else
              gitsigns.nav_hunk('prev')
            end
          end, { desc = 'Previous git hunk' })

          -- Actions
          map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'Stage hunk' })
          map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'Reset hunk' })
          map('v', '<leader>hs', function() gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = 'Stage hunk (visual)' })
          map('v', '<leader>hr', function() gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = 'Reset hunk (visual)' })
          map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'Stage buffer' })
          map('n', '<leader>hu', gitsigns.undo_stage_hunk, { desc = 'Undo stage hunk' })
          map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'Reset buffer' })
          map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'Preview hunk' })
          map('n', '<leader>hb', function() gitsigns.blame_line{full=true} end, { desc = 'Blame line' })
          map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = 'Toggle line blame' })
          map('n', '<leader>hd', gitsigns.diffthis, { desc = 'Diff this' })
          map('n', '<leader>hD', function() gitsigns.diffthis('~') end, { desc = 'Diff this ~' })
          map('n', '<leader>td', gitsigns.toggle_deleted, { desc = 'Toggle deleted' })

          -- Text object
          map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'Select hunk' })
        end
      })
    end,
  },

  -- GitHub Copilot
  {
    "github/copilot.vim",
    event = "InsertEnter",
    config = function()
      -- Copilot settings
      vim.g.copilot_no_tab_map = true  -- Disable default Tab mapping
      vim.g.copilot_assume_mapped = true
      vim.g.copilot_tab_fallback = ""
      
      -- Custom keybindings for Copilot
      local keymap = vim.keymap.set
      keymap("i", "<C-J>", 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false })
      keymap("i", "<C-;>", "<Plug>(copilot-dismiss)")
      keymap("i", "<M-]>", "<Plug>(copilot-next)")      -- Changed from Ctrl+] to Alt+]
      keymap("i", "<M-[>", "<Plug>(copilot-previous)")  -- Changed from Ctrl+[ to Alt+[
      
      -- Ensure Escape still works normally (don't override it)
      vim.g.copilot_filetypes = { ["*"] = true }
    end,
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",     -- LSP completion source
      "hrsh7th/cmp-buffer",       -- Buffer completion source
      "hrsh7th/cmp-path",         -- Path completion source
      "hrsh7th/cmp-cmdline",      -- Command line completion
      "L3MON4D3/LuaSnip",        -- Snippet engine
      "saadparwaiz1/cmp_luasnip", -- Snippet completion source
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        
        mapping = cmp.mapping.preset.insert({
          -- Navigation
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          
          -- Scroll documentation
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          
          -- Complete
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          
          -- Confirm selection
          ["<CR>"] = cmp.mapping.confirm({ 
            behavior = cmp.ConfirmBehavior.Replace,
            select = true 
          }),
          
          -- Tab completion
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        
        sources = cmp.config.sources({
          { name = "nvim_lsp" },    -- LSP completions (highest priority)
          { name = "luasnip" },     -- Snippet completions
        }, {
          { name = "buffer" },      -- Buffer text completions
          { name = "path" },        -- File path completions
        }),
        
        formatting = {
          format = function(entry, vim_item)
            -- Add icons for different completion sources
            local kind_icons = {
              Text = "󰉿",
              Method = "󰆧",
              Function = "󰊕",
              Constructor = "",
              Field = "󰜢",
              Variable = "󰀫",
              Class = "󰠱",
              Interface = "",
              Module = "",
              Property = "󰜢",
              Unit = "󰑭",
              Value = "󰎠",
              Enum = "",
              Keyword = "󰌋",
              Snippet = "",
              Color = "󰏘",
              File = "󰈙",
              Reference = "󰈇",
              Folder = "󰉋",
              EnumMember = "",
              Constant = "󰏿",
              Struct = "󰙅",
              Event = "",
              Operator = "󰆕",
              TypeParameter = "",
            }
            
            vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
            vim_item.menu = ({
              nvim_lsp = "[LSP]",
              luasnip = "[Snippet]",
              buffer = "[Buffer]",
              path = "[Path]",
            })[entry.source.name]
            
            return vim_item
          end,
        },
      })

      -- Setup command line completion
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        })
      })
    end,
  },
})

-- Show invisible characters (togglable)
opt.list = false
opt.listchars = {
    tab = '» ',
    trail = '·',
    extends = '›',
    precedes = '‹',
    nbsp = '␣'
}

-- Performance Settings
-- =============================================================================
opt.updatetime = 200            -- Faster CursorHold/diagnostics updates
opt.timeoutlen = 400            -- Snappier mapped sequence timeout

-- Tab Settings - Show filename only
-- =============================================================================
vim.opt.showtabline = 2  -- Always show tabs

-- Simple custom tabline for filename-only display
function _G.tabline()
  local s = ''
  for i = 1, vim.fn.tabpagenr('$') do
    -- Select the highlighting for the tab
    if i == vim.fn.tabpagenr() then
      s = s .. '%#TabLineSel#'
    else
      s = s .. '%#TabLine#'
    end
    
    -- Set the tab page number (for mouse clicks)
    s = s .. '%' .. i .. 'T'
    
    -- Get the filename without path
    local buflist = vim.fn.tabpagebuflist(i)
    local winnr = vim.fn.tabpagewinnr(i)
    local bufname = vim.fn.bufname(buflist[winnr])
    local filename = vim.fn.fnamemodify(bufname, ':t')
    
    if filename == '' then
      filename = '[No Name]'
    end
    
    -- Add the filename with padding
    s = s .. ' ' .. filename .. ' '
  end
  
  -- Fill the rest of the tabline
  s = s .. '%#TabLineFill#%T'
  return s
end

vim.opt.tabline = "%!v:lua.tabline()"



-- Completion Settings (LSP-ready)
-- =============================================================================
opt.completeopt = { "menu", "menuone", "noselect" }

-- Netrw File Explorer Settings
-- =============================================================================
vim.g.netrw_banner = 0          -- Disable banner
vim.g.netrw_liststyle = 3       -- Tree style listing
vim.g.netrw_browse_split = 0    -- Open in current window
vim.g.netrw_use_errorwindow = 0 -- Suppress error window
vim.g.netrw_browsex_viewer = 'open' -- Use macOS open command
vim.g.netrw_statusline = ""     -- Disable netrw's own statusline

-- Key Mappings
-- =============================================================================
local map = vim.keymap.set
local silent = { silent = true }

-- Clear search highlighting
map("n", "<Esc>", ":nohlsearch<CR><Esc>", silent)

-- Better window navigation
map("n", "<C-h>", "<C-w>h", silent)
map("n", "<C-j>", "<C-w>j", silent)
map("n", "<C-k>", "<C-w>k", silent)
map("n", "<C-l>", "<C-w>l", silent)

-- Quick save and quit
map("n", "<leader>w", ":write<CR>", silent)
map("n", "<leader>q", ":quit<CR>", silent)

-- Handy toggles with descriptions
map("n", "<leader>un", function()
    opt.relativenumber = not opt.relativenumber:get()
end, { desc = "Toggle relative numbers" })

map("n", "<leader>ul", function()
    opt.list = not opt.list:get()
end, { desc = "Toggle listchars" })

map("n", "<leader>us", function()
    opt.spell = not opt.spell:get()
end, { desc = "Toggle spell check" })

map("n", "<leader>uh", function()
    opt.hlsearch = not opt.hlsearch:get()
end, { desc = "Toggle search highlight" })

-- Quick edit and restart config
map("n", "<leader>ev", ":edit $MYVIMRC<CR>", { desc = "Edit config" })
map("n", "<leader>rr", ":qa<CR>", { desc = "Restart Neovim" })

-- Quick quit all mapping
map("n", "Q", ":qa<CR>", { desc = "Quit all" })

-- Session management shortcuts
map("n", "<leader>ss", ":SessionSave<CR>", { desc = "Save session" })
map("n", "<leader>sr", ":SessionRestore<CR>", { desc = "Restore session" })

-- File explorer shortcuts
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
map("n", "<leader>ef", "<cmd>NvimTreeFindFile<CR>", { desc = "Find current file in explorer" })
map("n", "<D-e>", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer (Cmd+E)" })
map("n", "<D-b>", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer (Cmd+B)" })

-- Tab cycling
map("n", "<M-]>", "<cmd>tabnext<CR>", { desc = "Next tab (Alt+])" })
map("n", "<M-[>", "<cmd>tabprevious<CR>", { desc = "Previous tab (Alt+[)" })
map("n", "<D-w>", "<cmd>tabclose<CR>", { desc = "Close tab (Cmd+W)" })
map("n", "<D-t>", "<cmd>tabnew<CR>", { desc = "New tab (Cmd+T)" })





-- Visual mode improvements
map("v", "<", "<gv")             -- Stay in visual mode when indenting
map("v", ">", ">gv")             -- Stay in visual mode when indenting

-- Insert mode convenience
map("i", "jk", "<Esc>")          -- Quick escape
map("i", "kj", "<Esc>")          -- Quick escape

-- Command mode convenience
map("c", "<C-a>", "<Home>")      -- Beginning of line
map("c", "<C-e>", "<End>")       -- End of line

-- Terminal mappings
map("t", "<Esc>", "<C-\\><C-n>", silent)
map("t", "<C-h>", "<C-\\><C-n><C-w>h", silent)
map("t", "<C-j>", "<C-\\><C-n><C-w>j", silent)
map("t", "<C-k>", "<C-\\><C-n><C-w>k", silent)
map("t", "<C-l>", "<C-\\><C-n><C-w>l", silent)

-- Diagnostic support (LSP-ready)
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Line diagnostics" })

-- Telescope keybindings
map("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Find files" })
map("n", "<D-p>", ":Telescope find_files<CR>", { desc = "Find files (VS Code style)" })
map("n", "<leader>fg", ":Telescope live_grep<CR>", { desc = "Live grep" })
map("n", "<D-f>", ":Telescope live_grep<CR>", { desc = "Live grep (VS Code style)" })
map("n", "<C-r>", ":Telescope live_grep<CR>", { desc = "Live grep (Ctrl+R)" })
map("n", "<leader>fb", ":Telescope buffers<CR>", { desc = "Find buffers" })
map("n", "<leader>fh", ":Telescope help_tags<CR>", { desc = "Help tags" })
map("n", "<leader>fc", ":Telescope commands<CR>", { desc = "Commands" })
map("n", "<leader>fk", ":Telescope keymaps<CR>", { desc = "Keymaps" })
map("n", "<leader>fr", ":Telescope oldfiles<CR>", { desc = "Recent files" })

-- LSP keybindings
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
map("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
map("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
map("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature help" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
map("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, { desc = "Format code" })

-- macOS: open URL/file under cursor
map("n", "gx", function()
    local url = vim.fn.expand('<cfile>')
    if url ~= '' then
        vim.fn.jobstart({ 'open', url }, { detach = true })
    end
end, { desc = "Open with macOS", silent = true })

-- Auto Commands
-- =============================================================================
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

-- Return to last edit position when opening files
autocmd("BufReadPost", {
    pattern = "*",
    callback = function()
        local last_pos = vim.fn.line("'\"")
        if last_pos > 0 and last_pos <= vim.fn.line("$") then
            vim.api.nvim_win_set_cursor(0, {last_pos, 0})
        end
    end
})

-- Terminal buffer settings
autocmd("TermOpen", {
    pattern = "*",
    callback = function()
        vim.bo.number = false
        vim.bo.relativenumber = false
        vim.cmd("startinsert")
    end
})

-- Highlight on yank (modern NeoVim feature)
autocmd("TextYankPost", {
    pattern = "*",
    callback = function()
        vim.highlight.on_yank()
    end
})

-- =============================================================================
-- Configuration complete - Modern, minimal, Mac-optimized
-- Tips: Use <leader>u* toggles, <leader>ev to edit config, gx to open URLs
-- =============================================================================