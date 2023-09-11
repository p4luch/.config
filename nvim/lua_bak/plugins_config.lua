local cmd = vim.cmd -- to execute Vim commands e.g. cmd('pwd')
local g = vim.g
local opt = vim.opt

-- Convenience function for mapping keys
local map = function(m, lhs, rhs, opts)
  vim.keymap.set(m, lhs, rhs, opts)
end

local opts = { noremap = true, silent = true }

require("nvim-tundra").setup({
  plugins = {
    lsp = true,
    treesitter = true,
    nvimtree = true,
    cmp = true,
    context = true,
    dbui = true,
    gitsigns = true,
    telescope = false,
  },
})
-- Set colorscheme
cmd("colorscheme tundra")

-- Gitsigns config
require("gitsigns").setup({
  current_line_blame = true,
})

-- LSP config
require("lsp")

-- Projectionist config
require("projectionist")

-- Enable devicons
require("nvim-web-devicons").setup({
  default = true,
})

require("auto-hlsearch").setup({
  remap_keys = { "/", "?", "*", "#", "n", "N" },
})

-- Treesitter config
require("nvim-treesitter.configs").setup({
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
    "hcl",
    "surface",
    "html",
    "markdown",
    "css",
    "javascript",
    "json",
    "go",
    "graphql",
  },
  auto_install = false,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = true },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  },
})
opt.foldlevelstart = 99

-- Telscope config
local telescope = require("telescope")
telescope.setup({
  defaults = {
    file_browser = {
      theme = "ivy",
      hijack_netrw = true,
    },
    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    file_sorter = require("telescope.sorters").get_fuzzy_file,
  },
  extensions = {
    fuzzy = true,
    override_generic_sorter = true,
    override_file_sorter = true,
    case_mode = "smartcase",
  },
})
map("n", "<Leader>ff", "<cmd>Telescope find_files find_command=rg,--files,--hidden,-g,!.git<cr>", opts)
map("n", "<Leader>fg", "<cmd>Telescope live_grep<cr>", opts)
map("n", "<Leader>fb", "<cmd>Telescope buffers<cr>", opts)
map("n", "<Leader>fh", "<cmd>Telescope help_tags<cr>", opts)
map("n", "<Leader>bf", "<cmd>Telescope file_browser hidden=true<cr>", opts)
telescope.load_extension("fzf")
telescope.load_extension("file_browser")

-- Formatter config
require("formatter").setup({
  logging = true,
  log_level = vim.log.levels.WARN,
  filetype = {
    markdown = {
      function()
        return {
          exe = "prettier",
          args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0), "--double-quote" },
          stdin = true,
        }
      end,
    },
    lua = {
      function()
        return {
          exe = "stylua",
          args = { "--indent-width", 2, "--indent-type", "Spaces" },
          stdin = false,
        }
      end,
    },
    elixir = {
      require("formatter.filetypes.elixir").mixformat,
    },
    rust = {
      require("formatter.filetypes.rust").rustfmt(),
    },
    go = {
      require("formatter.filetypes.go").gofumpt(),
    },
    -- Use the special "*" filetype for defining formatter configurations on
    -- any filetype
    ["*"] = {
      -- "formatter.filetypes.any" defines default configurations for any
      -- filetype
      require("formatter.filetypes.any").remove_trailing_whitespace,
    },
  },
})

local linter = require("lint")
linter.linters_by_ft = {
  elixir = { "credo" },
  lua = { "luacheck" },
}
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    linter.try_lint()
  end,
})

require("nvim-autopairs").setup()
require("indent_blankline").setup()

-- Test runner setup
g["test#strategy"] = "neovim"
g["test#neovim#term_position"] = "vert botright 100"
map("n", "<Leader>n", ":TestNearest<cr>", opts)
map("n", "<Leader>f", ":TestFile<cr>", opts)
map("n", "<Leader>s", ":TestSuite<cr>", opts)
map("n", "<Leader>l", ":TestLast<cr>", opts)

-- Markdown preview config
map("n", "<Leader>v", ":MarkdownPreview<cr>", opts)

-- Focus config
require("focus").setup({
  hybridnumber = true,
  autoresize = {
    enable = false
  }
})

map("n", "<Leader>fh", ":FocusSplitLeft<CR>", opts)
map("n", "<Leader>fj", ":FocusSplitDown<CR>", opts)
map("n", "<Leader>fk", ":FocusSplitUp<CR>", opts)
map("n", "<Leader>fl", ":FocusSplitRight<CR>", opts)

-- Tmux nvim config
local tmux_nav = require("nvim-tmux-navigation")
tmux_nav.setup({
  disable_when_zoomed = true,
})
map("n", "<C-h>", tmux_nav.NvimTmuxNavigateLeft, opts)
map("n", "<C-j>", tmux_nav.NvimTmuxNavigateDown, opts)
map("n", "<C-k>", tmux_nav.NvimTmuxNavigateUp, opts)
map("n", "<C-l>", tmux_nav.NvimTmuxNavigateRight, opts)
map("n", "<C-\\>", tmux_nav.NvimTmuxNavigateLastActive, opts)
map("n", "<C-Space>", tmux_nav.NvimTmuxNavigateNext, opts)

-- Lualine config
require("evil_lualine")

-- Bionic reading
require("easyread").setup({})
