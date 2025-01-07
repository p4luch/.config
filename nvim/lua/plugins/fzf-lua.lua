return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
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
  },
  opts = {
    fzf_opts = { ["--wrap"] = true },
    fzf_colors = true,
    defaults = {
      formatter = "path.filename_first",
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
