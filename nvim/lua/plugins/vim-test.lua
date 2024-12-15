local opts = { noremap = true, silent = true }
return {
  {
    "vim-test/vim-test",
    keys = {
      { "<Leader>n", "<cmd>TestNearest<cr>", opts },
      { "<Leader>f", "<cmd>TestFile<cr>", opts },
      { "<Leader>s", "<cmd>TestSuite<cr>", opts },
    },
    init = function()
      vim.g["test#strategy"] = "neovim"
      vim.g["test#neovim#term_position"] = "vert botright 100"
    end,
  },
}
