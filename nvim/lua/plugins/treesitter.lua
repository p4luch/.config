return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        ensure_installed = {
          "lua",
          "dockerfile",
          "elixir",
          "vim",
          "eex",
          "heex",
          "gitignore",
          "surface",
          "html",
          "markdown",
          "markdown_inline",
          "css",
          "javascript",
          "json",
          "rust",
        },
        auto_install = false,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
        sync_install = false,
      })
    end,
  },
}
