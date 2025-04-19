return {
  "saghen/blink.cmp",
  lazy = false,
  dependencies = { "rafamadriz/friendly-snippets" },
  version = "*",
  opts = {
    keymap = { preset = "enter" },
    completion = {
      accept = { auto_brackets = { enabled = true } },
      menu = {
        border = "single",
        draw = {
          columns = { { "item_idx" }, { "seperator" }, { "kind_icon" }, { "label", "label_description", gap = 1 } },
          components = {
            item_idx = {
              text = function(ctx)
                return ctx.idx == 10 and "0" or ctx.idx >= 10 and " " or tostring(ctx.idx)
              end,
              highlight = "comment",
            },
            seperator = {
              text = function()
                return "│"
              end,
              highlight = "comment",
            },
          },
          gap = 1,
          treesitter = { "lsp" },
        },
      },
      list = {
        selection = {
          preselect = true,
          auto_insert = true,
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
        window = {
          border = "single",
        },
      },
      ghost_text = {
        enabled = vim.g.ai_cmp,
      },
    },
    signature = {
      enabled = true,
      window = { border = "rounded" },
    },

    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
  },
  opts_extend = { "sources.default" },
}
