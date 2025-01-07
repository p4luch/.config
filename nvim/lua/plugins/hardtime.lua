return {
  "m4xshen/hardtime.nvim",
  dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
  opts = {
    disabled_keys = {
      ["<Up>"] = { "x", "n" },
      ["<Down>"] = { "x", "n" },
      ["<Left>"] = { "x", "n" },
      ["<Right>"] = { "x", "n" },
    },
    showmode = false,
  },
  config = function(PluginSpec)
    vim.notify = require("notify")
    require("hardtime").setup(PluginSpec.opts)
  end,
}
