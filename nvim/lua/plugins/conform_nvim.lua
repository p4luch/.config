return {
  "stevearc/conform.nvim",
  config = function()
    require("conform").setup({
      log_level = vim.log.levels.DEBUG,
      formatters_by_ft = {
        lua = { "stylua" },
        elixir = { "mix" },
        ["*"] = { "trim_newlines", "trim_whitespace" },
      },
      format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_format = "fallback",
      },
      formatters = {
        stylua = {
          prepend_args = { "--indent-width", 2, "--indent-type", "Spaces" },
        },
      },
    })
  end,
}
