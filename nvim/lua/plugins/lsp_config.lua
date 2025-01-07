return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "saghen/blink.cmp",
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local opts = { noremap = true, silent = true }

      -- Mappings for diagnostic
      vim.diagnostic.config({ virtual_text = false })
      vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
      vim.keymap.set("n", "<space>dp", vim.diagnostic.goto_prev, opts)
      vim.keymap.set("n", "<space>dn", vim.diagnostic.goto_next, opts)
      -- map("n", "<space>q", vim.diagnostic.setloclist, opts)

      local on_attach = function(_, bufnr)
        -- Mappings.
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts) -- jump to definition (e.g. function implementation)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts) -- display all occurences in files under cursor
      end

      local capabilities = require("blink.cmp").get_lsp_capabilities()

      require("lspconfig").elixirls.setup({
        cmd = { vim.fn.expand("~/.local/share/nvim/mason/bin/elixir-ls") },
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          fetchDeps = false,
          dialyzerEnabled = false,
        },
      })

      require("lspconfig").lua_ls.setup({
        capabilities = capabilities,
        on_init = function(client)
          if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc") then
              return
            end
          end

          client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
            runtime = {
              diagnostics = {
                globals = { "vim" },
              },
              version = "LuaJIT",
            },
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME,
              },
            },
          })
        end,
        settings = {
          Lua = {},
        },
      })

      require("lspconfig").dockerls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      require("lspconfig").tailwindcss.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        init_options = {
          userLanguages = {
            elixir = "phoenix-heex",
            heex = "phoenix-heex",
          },
        },
        handlers = {
          ["tailwindcss/getConfiguration"] = function(_, _, params, bufnr, _)
            vim.lsp.buf_notify(bufnr, "tailwindcss/getConfigurationResponse", { _id = params._id })
          end,
        },
        settings = {
          includeLanguages = {
            ["html-eex"] = "html",
            ["phoenix-heex"] = "html",
            heex = "html",
            elixir = "html",
          },
          tailwindCSS = {
            lint = {
              cssConflict = "warning",
              invalidApply = "error",
              invalidConfigPath = "error",
              invalidScreen = "error",
              invalidTailwindDirective = "error",
              invalidVariant = "error",
              recommendedVariantOrder = "warning",
            },
            experimental = {
              classRegex = {
                [[class= "([^"]*)]],
                [[class: "([^"]*)]],
                '~H""".*class="([^"]*)".*"""',
              },
            },
            validate = true,
          },
        },
        filetypes = {
          "eelixir",
          "elixir",
          "html-eex",
          "heex",
          "css",
          "less",
          "postcss",
          "sass",
          "scss",
          "javascript",
          "javascriptreact",
        },
      })
      require("lspconfig").emmet_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "heex" },
      })

      require("lspconfig").docker_compose_language_service.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })

      require("lspconfig").marksman.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })
    end,
  },
}
