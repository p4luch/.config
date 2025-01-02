return {
  "m4xshen/hardtime.nvim",
  dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
  config = function()
    vim.notify = require("notify")
    require("hardtime").setup({
      disabled_keys = {
        ["<Up>"] = { "x", "n" },
        ["<Down>"] = { "x", "n" },
        ["<Left>"] = { "x", "n" },
        ["<Right>"] = { "x", "n" },
      },
      showmode = false,
    })
  end,
}
