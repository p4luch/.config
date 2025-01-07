local opts = { noremap = true, silent = true }
return {
  {
    "alexghergh/nvim-tmux-navigation",
    keys = {
      { "<C-h>", "<cmd>NvimTmuxNavigateLeft<cr>", desc = "Tmux Navigation Left", opts },
      { "<C-j>", "<cmd>NvimTmuxNavigateDown<cr>", desc = "Tmux Navigation Down", opts },
      { "<C-k>", "<cmd>NvimTmuxNavigateUp<cr>", desc = "Tmux Navigation Up", opts },
      { "<C-l>", "<cmd>NvimTmuxNavigateRight<cr>", desc = "Tmux Navigation Right", opts },
      { "<C-\\>", "<cmd>NvimTmuxNavigateLastActive<cr>", desc = "Tmux Navigation Last Active", opts },
      { "<C-Space>", "<cmd>NvimTmuxNavigateNext<cr>", desc = "Tmux Navigation Next", opts },
    },
    opts = { disable_when_zoomed = true },
  },
}
