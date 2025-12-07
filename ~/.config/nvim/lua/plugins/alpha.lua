return {
  "goolord/alpha-nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    -- Set header
    dashboard.section.header.val = {
      "                                                     ",
      "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
      "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
      "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
      "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
      "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
      "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
      "                                                     ",
    }

    -- Set menu
    dashboard.section.buttons.val = {
      dashboard.button("e", "󰈔  New file", ":ene <BAR> startinsert <CR>"),
      dashboard.button("f", "󰈞  Find file", ":Telescope find_files <CR>"),
      dashboard.button("r", "󰊄  Recent files", ":Telescope oldfiles <CR>"),
      dashboard.button("g", "󰊢  Find text", ":Telescope live_grep <CR>"),
      dashboard.button("c", "󰒓  Configuration", ":e $MYVIMRC <CR>"),
      dashboard.button("q", "󰅚  Quit", ":qa<CR>"),
    }

    -- Set footer
    local function footer()
      local version = vim.version()
      local nvim_version = "v" .. version.major .. "." .. version.minor .. "." .. version.patch
      return "🚀 Happy coding!  |  Neovim " .. nvim_version
    end

    dashboard.section.footer.val = footer()

    dashboard.section.footer.opts.hl = "Type"
    dashboard.section.header.opts.hl = "Include"
    dashboard.section.buttons.opts.hl = "Keyword"

    dashboard.opts.opts.noautocmd = true
    alpha.setup(dashboard.opts)

    -- Show Alpha when opening a directory and clean up directory buffer
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        local arg = vim.fn.argv(0)
        if arg == "" then
          require("alpha").start()
          return
        end
        local stats = vim.uv.fs_stat(arg)
        if stats and stats.type == "directory" then
          -- Delete the directory buffer
          vim.cmd("bdelete")
          require("alpha").start()
        end
      end,
    })

  end,
}
