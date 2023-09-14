return {
  {
    "mfussenegger/nvim-lint",
    config = function ()
      require("lint").linters_by_ft = {
        elixir = { "credo" },
        lua = { "luacheck" }
      }

      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function ()
          require("lint").try_lint()
        end
      })
    end
  }
}
