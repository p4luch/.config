local opts = { noremap = true, silent = true }
return {
  {
    "alexghergh/nvim-tmux-navigation",
    keys = {
      {"<C-h>", "<cmd>NvimTmuxNavigateLeft<cr>", opts},
      {"<C-j>", "<cmd>NvimTmuxNavigateDown<cr>", opts},
      {"<C-k>", "<cmd>NvimTmuxNavigateUp<cr>", opts},
      {"<C-l>", "<cmd>NvimTmuxNavigateRight<cr>", opts},
      {"<C-\\>", "<cmd>NvimTmuxNavigateLastActive<cr>", opts},
      {"<C-Space>", "<cmd>NvimTmuxNavigateNext<cr>", opts},
    },
    config = function()
      require("nvim-tmux-navigation").setup({
        disable_when_zoomed = true
      })
    end,
  },
}
