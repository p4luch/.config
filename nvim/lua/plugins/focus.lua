local opts = {noremap = true, silent = true}
return {
  {
    "nvim-focus/focus.nvim", 
    version = false,
    keys = {
      {"<Leader>fh", ":FocusSplitLeft<cr>", opts},
      {"<Leader>fj", ":FocusSplitDown<cr>", opts},
      {"<Leader>fk", ":FocusSplitUp<cr>", opts},
      {"<Leader>fl", ":FocusSplitRight<cr>", opts},
    },
    config = function()
      require("focus").setup({
        autoresize = {
          enable = false
        },
        ui = {
          hybridnumber = true,
        },
      })
    end
  }
}
