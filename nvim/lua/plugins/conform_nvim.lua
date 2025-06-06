return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      elixir = { "mix" },
      toml = { "taplo" },
      rust = { "rustfmt" },
    },
    format_on_save = {
      -- These options will be passed to conform.format()
      timeout_ms = 1000,
      lsp_format = "fallback",
    },
    formatters = {
      stylua = {
        prepend_args = { "--indent-width", 2, "--indent-type", "Spaces" },
      },
    },
  },
}
