return {
  -- Smart Commenting
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
    config = function()
      require("Comment").setup({
        padding = true,
        sticky = true,
        ignore = nil,
        toggler = { line = 'gcc', block = 'gbc' },
        opleader = { line = 'gc', block = 'gb' },
        extra = { above = 'gcO', below = 'gco', eol = 'gcA' },
        mappings = { basic = true, extra = true },
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
        post_hook = nil,
      })
    end,
  },

  -- GitHub Copilot
  {
    "github/copilot.vim",
    event = "InsertEnter",
    config = function()
      -- Don't disable tab, let copilot use it by default
      vim.g.copilot_no_tab_map = false
      vim.g.copilot_assume_mapped = true

      local keymap = vim.keymap.set
      keymap("i", "<C-J>", 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false })
      keymap("i", "<C-;>", "<Plug>(copilot-dismiss)")
      keymap("i", "<M-]>", "<Plug>(copilot-next)")
      keymap("i", "<M-[>", "<Plug>(copilot-previous)")

      vim.g.copilot_filetypes = { ["*"] = true }
    end,
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
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
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true
          }),
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
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
        formatting = {
          format = function(entry, vim_item)
            local kind_icons = {
              Text = "󰉿", Method = "󰆧", Function = "󰊕", Constructor = "",
              Field = "󰜢", Variable = "󰀫", Class = "󰠱", Interface = "",
              Module = "", Property = "󰜢", Unit = "󰑭", Value = "󰎠",
              Enum = "", Keyword = "󰌋", Snippet = "", Color = "󰏘",
              File = "󰈙", Reference = "󰈇", Folder = "󰉋", EnumMember = "",
              Constant = "󰏿", Struct = "󰙅", Event = "", Operator = "󰆕",
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

      -- Command line completion
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = 'buffer' } }
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
}