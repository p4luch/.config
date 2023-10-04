return {
  {
    "sam4llis/nvim-tundra",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme tundra]])
    end,
  },
}
