return {
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

  -- Neovim development setup
  { "folke/neodev.nvim", lazy = false, priority = 1000 },

  -- Mason LSP config bridge
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls", "ts_ls", "pyright", "rust_analyzer",
          "gopls", "html", "cssls", "jsonls", "solargraph", "biome",
        },
        automatic_installation = true,
      })
    end,
  },

  -- LSP configuration
  {
    "neovim/nvim-lspconfig",
    dependencies = { "mason-lspconfig.nvim", "neodev.nvim" },
    config = function()
      require("neodev").setup({
        library = {
          enabled = true,
          runtime = true,
          types = true,
          plugins = true,
        },
      })

      local lspconfig = require("lspconfig")
      local util = require("lspconfig.util")
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              completion = { callSnippet = "Replace" },
              telemetry = { enable = false },
              diagnostics = { disable = { "trailing-space" } },
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
        biome = {
          cmd = { "biome", "lsp-proxy" },
          filetypes = {
            "javascript", "javascriptreact", "javascript.jsx",
            "typescript", "typescriptreact", "typescript.tsx",
            "json", "jsonc"
          },
          root_dir = util.root_pattern("biome.json", "biome.jsonc", "package.json", ".git"),
        },
        solargraph = {
          settings = {
            solargraph = {
              diagnostics = true,
              completion = true,
            }
          }
        },
      }

      for server, config in pairs(servers) do
        config.capabilities = capabilities
        lspconfig[server].setup(config)
      end
    end,
  },
}
