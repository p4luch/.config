return {
  "michel-garcia/fzf-lua-file-browser.nvim",
  dependencies = {
    "ibhagwan/fzf-lua",
  },
  opts = {},
  keys = {
    { "<Leader>fb", "<cmd>FzfLua file_browser<CR>", desc = "Fzf Lua file browser", { noremap = true, silent = true } },
  },
}
