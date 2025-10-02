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

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      -- Modern vim.lsp.config approach (Neovim 0.11+)
      vim.lsp.config.lua_ls = {
        cmd = { vim.fn.exepath("lua-language-server") },
        filetypes = { "lua" },
        capabilities = capabilities,
        settings = {
          Lua = {
            completion = { callSnippet = "Replace" },
            telemetry = { enable = false },
            diagnostics = { disable = { "trailing-space" } },
          },
        },
      }

      vim.lsp.config.ts_ls = {
        cmd = { vim.fn.exepath("typescript-language-server"), "--stdio" },
        filetypes = { "javascript", "typescript", "typescriptreact", "javascriptreact" },
        capabilities = capabilities,
      }

      vim.lsp.config.pyright = {
        cmd = { vim.fn.exepath("pyright-langserver"), "--stdio" },
        filetypes = { "python" },
        capabilities = capabilities,
      }

      vim.lsp.config.rust_analyzer = {
        cmd = { vim.fn.exepath("rust-analyzer") },
        filetypes = { "rust" },
        capabilities = capabilities,
      }

      vim.lsp.config.gopls = {
        cmd = { vim.fn.exepath("gopls") },
        filetypes = { "go", "gomod", "gowork", "gotmpl" },
        capabilities = capabilities,
      }

      vim.lsp.config.html = {
        cmd = { vim.fn.exepath("vscode-html-language-server"), "--stdio" },
        filetypes = { "html" },
        capabilities = capabilities,
      }

      vim.lsp.config.cssls = {
        cmd = { vim.fn.exepath("vscode-css-language-server"), "--stdio" },
        filetypes = { "css", "scss", "less" },
        capabilities = capabilities,
      }

      vim.lsp.config.jsonls = {
        cmd = { vim.fn.exepath("vscode-json-language-server"), "--stdio" },
        filetypes = { "json", "jsonc" },
        capabilities = capabilities,
      }

      vim.lsp.config.biome = {
        cmd = { vim.fn.exepath("biome"), "lsp-proxy" },
        filetypes = {
          "javascript", "javascriptreact", "javascript.jsx",
          "typescript", "typescriptreact", "typescript.tsx",
          "json", "jsonc"
        },
        capabilities = capabilities,
        root_dir = function(fname)
          return vim.fs.find({"biome.json", "biome.jsonc", "package.json", ".git"}, {
            path = fname,
            upward = true,
          })[1]
        end,
      }

      vim.lsp.config.solargraph = {
        cmd = { vim.fn.exepath("solargraph"), "stdio" },
        filetypes = { "ruby" },
        capabilities = capabilities,
        settings = {
          solargraph = {
            diagnostics = true,
            completion = true,
          }
        }
      }

      -- Enable the language servers
      vim.lsp.enable("lua_ls")
      vim.lsp.enable("ts_ls")
      vim.lsp.enable("pyright")
      vim.lsp.enable("rust_analyzer")
      vim.lsp.enable("gopls")
      vim.lsp.enable("html")
      vim.lsp.enable("cssls")
      vim.lsp.enable("jsonls")
      vim.lsp.enable("biome")
      vim.lsp.enable("solargraph")
    end,
  },
}
