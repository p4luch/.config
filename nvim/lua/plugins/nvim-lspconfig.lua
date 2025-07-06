return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    -- native LSP utilities
    local blink_cmp = require("blink.cmp")
    local capabilities = blink_cmp.get_lsp_capabilities()
    local on_attach = function(client, bufnr)
      local map_opts = { noremap = true, silent = true, buffer = bufnr }
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, map_opts)
      vim.keymap.set("n", "sd", vim.lsp.buf.hover, map_opts)
      vim.keymap.set("n", "<Space>e", vim.diagnostic.open_float, map_opts)
      vim.keymap.set("n", "<Space>dp", vim.diagnostic.goto_prev, map_opts)
      vim.keymap.set("n", "<Space>dn", vim.diagnostic.goto_next, map_opts)
    end

    vim.lsp.config("*", {
      capabilities = capabilities,
      on_attach = on_attach(),
    })

    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          runtime = { version = "Lua 5.1" },
          diagnostics = { globals = { "vim", "bit", "it", "describe", "before_each", "after_each" } },
          telemetry = { enable = false },
        },
      },
    })
    vim.lsp.config("elixirls", {
      -- dynamically determine elixir-ls install path via Mason
      cmd = { vim.fn.stdpath("data") .. "/mason/packages/elixir-ls/language_server.sh" },
      settings = {
        elixirLS = {
          dialyzerEnabled = false,
          fetchDeps = false,
        },
      },
    })
    vim.lsp.config("rust_analyzer", {
      settings = {
        ["rust-analyzer"] = {
          diagnostics = { enable = false },
          checkOnSave = { command = "clippy" },
          cargo = { features = "all" },
        },
      },
    })
    vim.lsp.config("elp", {})

    require("mason").setup()
    require("mason-lspconfig").setup({

      ensure_installed = {
        "elixirls",
        "lua_ls",
        "rust_analyzer",
        "elp",
        "marksman",
        "docker_compose_language_service",
        "tailwindcss",
        "emmet_language_server",
      },
    })
  end,
}
