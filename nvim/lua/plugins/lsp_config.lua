return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "towolf/vim-helm",
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
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        -- map("n", "gD", vim.lsp.buf.declaration, bufopts) -- jump to DECLARATION, not used by many thus disabled
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts) -- jump to definition (e.g. function implementation)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts) -- display docs in float window
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts) -- display all occurences in files under cursor
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts) -- display function params help
        vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
        vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
        vim.keymap.set("n", "<space>wl", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, bufopts)
        vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts) -- not supported by elixir
        vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts) -- rename all occurences
        vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts) -- display all references for symbol under cursor
        vim.keymap.set("n", "<space>f", function()
          vim.lsp.buf.format({ async = true })
        end, bufopts) -- format code
      end

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      require("lspconfig").elixirls.setup({
        cmd = { vim.fn.expand("~/.local/share/nvim/mason/bin/elixir-ls") },
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          fetchDeps = false,
          dialyzerEnabled = false,
        },
      })

      require("lspconfig").lua_ls.setup({
        on_init = function(client)
          local path = client.workspace_folders[1].name
          if not vim.loop.fs_stat(path .. "/.luarc.json") and not vim.loop.fs_stat(path .. "/.luarc.jsonc") then
            client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {
              Lua = {
                runtime = {
                  -- Tell the language server which version of Lua you're using
                  -- (most likely LuaJIT in the case of Neovim)
                  version = "LuaJIT",
                },
                -- Make the server aware of Neovim runtime files
                workspace = {
                  checkThirdParty = false,
                  library = {
                    vim.env.VIMRUNTIME,
                    -- "${3rd}/luv/library"
                    -- "${3rd}/busted/library",
                  },
                  -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                  -- library = vim.api.nvim_get_runtime_file("", true)
                },
              },
            })

            client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
          end
          return true
        end,
      })

      require("lspconfig").erlangls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })

      require("lspconfig").dockerls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })

      require("lspconfig").yamlls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        setings = {
          yaml = {
            schemas = {
              ["../../../nvim-data/language-servers/github-workflow.json"] = "/.github/workflows/*",
              ["../../../nvim-data/language-server/language-servers/kubernetes-json-schema/v1.25.0-standalone-strict/all.json"] = "/*.k8s.yaml",
            },
          },
        },
      })

      require("lspconfig").tailwindcss.setup({
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
        filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "heex" },
      })

      require("lspconfig").graphql.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })

      require("lspconfig").helm_ls.setup({
        cmd = { vim.fn.expand("~/.local/share/nvim/mason/bin/helm_ls"), "serve" },
        on_attach = on_attach,
        capabilities = capabilities,
      })

      require("lspconfig").taplo.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })

      require("lspconfig").helm_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })
    end,
  },
}
