return {
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    opts = {
      ensure_installed = {
        "elixirls",
        "lua_ls",
        "dockerls",
        "tailwindcss",
        "emmet_ls",
        "docker_compose_language_service",
        "marksman",
        "taplo",
        "rust_analyzer",
        "elp",
      },
      automatic_enable = true,
    },
    config = function(_, opts)
      -- setup Mason and Mason-LSPconfig
      require("mason").setup()
      require("mason-lspconfig").setup(opts)

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

      -- server-specific overrides
      local servers = {
        elixirls = {
          -- dynamically determine elixir-ls install path via Mason
          cmd = { vim.fn.stdpath("data") .. "/mason/packages/elixir-ls/language_server.sh" },
          settings = {
            elixirLS = {
              dialyzerEnabled = false,
              fetchDeps = false,
            },
          },
        },
        lua_ls = {
          settings = {
            Lua = {
              runtime = { version = "LuaJIT", path = vim.split(package.path, "%%;") },
              diagnostics = { globals = { "vim" } },
              workspace = { library = vim.api.nvim_get_runtime_file("", true) },
              telemetry = { enable = false },
            },
          },
        },
        dockerls = {},
        tailwindcss = {},
        emmet_ls = {},
        docker_compose_language_service = {},
        marksman = {},
        taplo = {},
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              cargo = { allFeatures = true },
              checkOnSave = { command = "clippy" },
              inlayHints = { enable = true },
            },
          },
        },
        elp = { cmd = { "elp", "server" } },
      }

      -- register each server: merge capabilities & on_attach, then define via native API
      for name, cfg in pairs(servers) do
        cfg.capabilities = capabilities
        cfg.on_attach = on_attach
        vim.lsp.config(name, cfg)
      end
    end,
  },
}
