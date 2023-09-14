return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function () 
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
          "toml",
          "erlang",
          "yaml",
          "surface",
          "html",
          "markdown",
          "css",
          "javascript",
          "graphql",
          "json"
        },
        auto_install = false,
        highlight = { 
          enable = true, 
          additional_vim_regex_highlighting = true
        },
        indent = { enable = true },  
        sync_install = false,  
      })
    end
  }
}
