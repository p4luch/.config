return {
  --[[ {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-vsnip",
      "hrsh7th/vim-vsnip",
      "hrsh7th/cmp-nvim-lua",
      "onsails/lspkind-nvim"
    },
    config = function()
      require("cmp").setup({
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
          end,
        },
        mapping = require("cmp").mapping.preset.insert({
          ["<C-b>"] = require("cmp").mapping.scroll_docs(-4),
          ["<C-f>"] = require("cmp").mapping.scroll_docs(4),
          ["<C-Space>"] = require("cmp").mapping.complete(),
          ["<C-e>"] = require("cmp").mapping.abort(),
          ["<CR>"] = require("cmp").mapping.confirm({ select = true }),
        }),
        sources = require("cmp").config.sources({
          { name = "path" },
          { name = "nvim_lsp", keyword_length = 1, priority = 10 },
          { name = "vsnip", keyword_length = 1, priority = 7 },
          { name = "nvim_lua", keyword_length = 1, priority = 8 },
          { name = "buffer", keyword_length = 1, priority = 5 },
        }),
        formatting = {
          format = require("lspkind").cmp_format()
        },
        window = {
          completion = {
            require("cmp").config.window.bordered(),
            col_offset = 3,
            side_padding = 1,
          },
          documentation = require("cmp").config.window.bordered(),
        }
      })
      require("cmp").setup.cmdline("/", {
        mapping = require("cmp").mapping.preset.cmdline(),
          sources = {
            { name = "buffer" },
          },
      })
      require("cmp").setup.cmdline(":", {
        mapping = require("cmp").mapping.preset.cmdline(),
        sources = require("cmp").config.sources({
          { name = "path" },
          }, {
          { name = "cmdline" },
        })
      })

      require("cmp").event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())

    end
  } ]]
}
