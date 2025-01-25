return {
  "OXY2DEV/markview.nvim",
  lazy = false,
  keys = {
    { "<Leader>mp", "<cmd>Markview Toggle<cr>", desc = "Toggle markdown preview", { silent = true, noremap = true } },
  },
  opts = {
    preivew = {
      icon_provider = "devicons",
    },
  },
}
