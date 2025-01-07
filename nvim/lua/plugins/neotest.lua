local opts = { noremap = true, silent = true }
return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "jfpedroza/neotest-elixir",
  },
  keys = {
    {
      "<Leader>n",
      function()
        require("neotest").run.run()
      end,
      desc = "Neotest, run nearest test",
      opts,
    },
    {
      "<Leader>f",
      function()
        require("neotest").run.run(vim.fn.expand("%"))
      end,
      desc = "Neotest, run test file",
      opts,
    },
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-elixir")({}),
      },
    })
  end,
}
