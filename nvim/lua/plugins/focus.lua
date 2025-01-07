local opts = { noremap = true, silent = true }
return {
  {
    "nvim-focus/focus.nvim",
    version = false,
    keys = {
      { "<Leader>fh", ":FocusSplitLeft<cr>", desc = "Focus split left", opts },
      { "<Leader>fj", ":FocusSplitDown<cr>", desc = "Focus split down", opts },
      { "<Leader>fk", ":FocusSplitUp<cr>", desc = "Focus split up", opts },
      { "<Leader>fl", ":FocusSplitRight<cr>", desc = "Focus splut right", opts },
    },
    opts = {
      ui = {
        hybridnumber = true,
      },
      autoresize = {
        enable = false,
      },
    },
  },
}
