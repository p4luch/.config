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
    -- TODO parse file names
    require("mini.statusline").setup({})
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
