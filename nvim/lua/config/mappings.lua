local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<Leader>w", "<cmd>:w<cr>", opts)
vim.keymap.set("n", "qq", "<cmd>q<cr>", opts)
