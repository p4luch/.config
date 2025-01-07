return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  build = "cd app && yarn install",
  init = function()
    vim.g.mkdp_filetypes = { "markdown" }
  end,
  ft = { "markdown" },
  keys = {
    { "<Leader>mp", "<cmd>MarkdownPreview<cr>", desc = "MarkdownPreview toggle", { noremap = true, silent = true } },
  },
}
