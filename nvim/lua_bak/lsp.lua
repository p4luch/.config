local fn = vim.fn
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "elixirls",
    "lua_ls",
    "erlangls",
    "dockerls",
    "yamlls",
    "terraformls",
    "tailwindcss",
    "graphql",
  },
})
local lspconfig = require("lspconfig")

-- Convenience function for mapping keys
local map = function(m, lhs, rhs, opts)
  vim.keymap.set(m, lhs, rhs, opts)
end

local opts = { noremap = true, silent = true }

-- Mappings for diagnostic
vim.diagnostic.config({ virtual_text = false })
map("n", "<space>e", vim.diagnostic.open_float, opts)
map("n", "<space>dp", vim.diagnostic.goto_prev, opts)
map("n", "<space>dn", vim.diagnostic.goto_next, opts)
-- map("n", "<space>q", vim.diagnostic.setloclist, opts)

local on_attach = function(client, bufnr)
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  -- map("n", "gD", vim.lsp.buf.declaration, bufopts) -- jump to DECLARATION, not used by many thus disabled
  map("n", "gd", vim.lsp.buf.definition, bufopts) -- jump to definition (e.g. function implementation)
  map("n", "K", vim.lsp.buf.hover, bufopts) -- display docs in float window
  map("n", "gi", vim.lsp.buf.implementation, bufopts) -- display all occurences in files under cursor
  map("n", "<C-k>", vim.lsp.buf.signature_help, bufopts) -- display function params help
  map("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
  map("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
  map("n", "<space>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  map("n", "<space>D", vim.lsp.buf.type_definition, bufopts) -- not supported by elixir
  map("n", "<space>rn", vim.lsp.buf.rename, bufopts) -- rename all occurences
  map("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
  map("n", "gr", vim.lsp.buf.references, bufopts) -- display all references for symbol under cursor
  map("n", "<space>f", function()
    vim.lsp.buf.format({ async = true })
  end, bufopts) -- format code
end

local cmp = require("cmp")

local cmp_autopairs = require("nvim-autopairs.completion.cmp")

cmp.setup({
  snippet = {
    expand = function(args)
      fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = "path" },
    { name = "nvim_lsp", keyword_length = 1, priority = 10 },
    { name = "vsnip", keyword_length = 1, priority = 7 },
    { name = "nvim_lua", keyword_length = 1, priority = 8 },
    { name = "buffer", keyword_length = 1, priority = 5 },
  }),

  formatting = {
    format = require("lspkind").cmp_format(),
  },

  window = {
    completion = {
      cmp.config.window.bordered(),
      col_offset = 3,
      side_padding = 1,
    },
    documentation = cmp.config.window.bordered(),
  },
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- `/` cmdline setup.
cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
  capabilities = capabilities,
})
-- `:` cmdline setup.
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
  capabilities = capabilities,
})

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

lspconfig.elixirls.setup({
  -- cmd = { fn.expand("~/.config/nvim-data/language-servers/elixir-ls/release/language_server.sh") },
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    fetchDeps = false,
    dialyzerEnabled = false,
  },
})

lspconfig.lua_ls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
})

lspconfig.erlangls.setup({
  on_attach = on_attach,
})
lspconfig.dockerls.setup({
  on_attach = on_attach,
})
lspconfig.yamlls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  setings = {
    yaml = {
      schemas = {
        ["../../nvim-data/language-servers/github-workflow.json"] = "/.github/workflows/*",
        ["../../nvim-data/language-server/language-servers/kubernetes-json-schema/v1.25.0-standalone-strict/all.json"] = "/*.k8s.yaml",
      },
    },
  },
})
lspconfig.terraformls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})
lspconfig.tailwindcss.setup({
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

lspconfig.cssls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})
lspconfig.emmet_ls.setup({
  on_attach = on_attach,
  filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "heex" },
})
lspconfig.gopls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})
lspconfig.taplo.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

lspconfig.graphql.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

lspconfig.ltex.setup({
  on_attach = on_attach,
  settings = {
    ltex = {
      language = "en-GB",
      additionalRules = {
        languageModel = "~/ngrams/",
      },
    },
  },
})

lspconfig.helm_ls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})
