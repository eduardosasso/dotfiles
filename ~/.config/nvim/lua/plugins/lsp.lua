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

      -- Setup capabilities
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      -- Configure LSP servers using the new vim.lsp.config API
      local encoding = "utf-16"

      vim.lsp.config('lua_ls', {
        capabilities = capabilities,
        position_encoding = encoding,
        settings = {
          Lua = {
            completion = { callSnippet = "Replace" },
            telemetry = { enable = false },
            diagnostics = { disable = { "trailing-space" } },
          },
        },
      })

      vim.lsp.config('ts_ls', {
        capabilities = capabilities,
        position_encoding = encoding,
      })

      vim.lsp.config('pyright', {
        capabilities = capabilities,
        position_encoding = encoding,
      })

      vim.lsp.config('rust_analyzer', {
        capabilities = capabilities,
        position_encoding = encoding,
      })

      vim.lsp.config('gopls', {
        capabilities = capabilities,
        position_encoding = encoding,
      })

      vim.lsp.config('html', {
        capabilities = capabilities,
        position_encoding = encoding,
      })

      vim.lsp.config('cssls', {
        capabilities = capabilities,
        position_encoding = encoding,
      })

      vim.lsp.config('jsonls', {
        capabilities = capabilities,
        position_encoding = encoding,
      })

      vim.lsp.config('biome', {
        capabilities = capabilities,
        position_encoding = encoding,
        cmd = { "biome", "lsp-proxy" },
        filetypes = {
          "javascript", "javascriptreact", "javascript.jsx",
          "typescript", "typescriptreact", "typescript.tsx",
          "json", "jsonc"
        },
        root_markers = { "biome.json", "biome.jsonc", "package.json", ".git" },
      })

      vim.lsp.config('solargraph', {
        capabilities = capabilities,
        position_encoding = encoding,
        settings = {
          solargraph = {
            diagnostics = true,
            completion = true,
          }
        }
      })

    end,
  },
}
