return {
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("mason").setup({})

      require("mason-lspconfig").setup({
        automatic_installation = false,
        ensure_installed = {
          "elixirls",
          "lua_ls",
          "erlangls",
          "yamlls",
          "tailwindcss",
          "graphql",
          "emmet_ls",
          "helm_ls",
          "taplo",
          "dockerls",
          "docker_compose_language_service",
        },
      })
    end,
  },
}
