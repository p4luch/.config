return {
  "echasnovski/mini.nvim",
  version = "*",
  config = function()
    require("mini.move").setup({
      mappings = {
        -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
        right = "<S-l>",
        left = "<S-h>",
        down = "<S-j>",
        up = "<S-k>",

        -- Move current line in Normal mode
        line_left = "<S-h>",
        line_right = "<S-l>",
        line_down = "<S-j>",
        line_up = "<S-k>",
      },
    })
    require("mini.comment").setup({})
    require("mini.trailspace").setup({})
    require("mini.files").setup({})
    require("mini.indentscope").setup({})
    require("mini.animate").setup({})
    require("mini.icons").setup({})
    require("mini.statusline").setup({
      -- Content of statusline as functions which return statusline string. See
      -- `:h statusline` and code of default contents (used instead of `nil`).
      content = {
        -- Content for active window
        active = function()
          local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
          local git = MiniStatusline.section_git({ trunc_width = 40 })
          local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
          local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
          local location = MiniStatusline.section_location({ trunc_width = 75 })

          return MiniStatusline.combine_groups({
            { hl = mode_hl, strings = { mode } },
            { hl = "MiniStatuslineDevinfo", strings = { git } },
            "%<", -- Mark general truncate point
            "%=", -- End left alignment
            { hl = "MiniStatuslineDevinfo", strings = { lsp } },
            { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
            { hl = mode_hl, strings = { location } },
          })
        end,

        -- Content for inactive window(s)
        inactive = nil,
      },

      -- Whether to use icons by default
      use_icons = true,
    })
  end,
  keys = {
    {
      "<Leader>bf",
      function()
        require("mini.files").open()
      end,
      desc = "Open oil in cwd",
      { silent = true, noremap = true },
    },
  },
}
