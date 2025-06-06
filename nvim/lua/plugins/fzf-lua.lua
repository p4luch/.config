return {
  "ibhagwan/fzf-lua",
  dependencies = { "echasnovski/mini.icons" },
  keys = {
    { "<Leader>ff", "<cmd>FzfLua files<CR>", "n", desc = "Find files", { noremap = true, silent = true } },
    {
      "<Leader>fg",
      "<cmd>FzfLua live_grep winopts.preview.hidden=false<CR>",
      "n",
      desc = "Grep project's files (with ripgrep)",
      { noremap = true, silent = true },
    },
    {
      "<Leader>lk",
      "<cmd>FzfLua keymaps<CR>",
      "n",
      desc = "Nvim keymaps",
      { noremap = true, silent = true },
    },
    {
      "<Leader>fr",
      "<cmd> FzfLua lsp_references<CR>",
      "n",
      desc = "Get LSP references for a symbol",
      { noremap = true, silent = true },
    },
    {
      "<Leader>ds",
      "<cmd> FzfLua lsp_document_symbols<CR>",
      "n",
      desc = "Get symbols in a file from LSP",
      { noremap = true, silent = true },
    },
  },
  opts = {
    fzf_opts = { ["--wrap"] = true },
    fzf_colors = true,
    defaults = {
      formatter = "path.dirname_first",
    },
    keymap = {
      fzf = {
        ["ctrl-p"] = "toggle-preview",
      },
    },
    winopts = {
      preview = {
        wrap = "wrap",
        hidden = true,
        default = "bat",
        scrollbar = "false",
      },
    },
  },
}
