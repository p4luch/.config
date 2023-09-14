local opt = { noremap = true, silent = true }

vim.keymap.set("n", "<Leader>t", "<cmd>:tabe<cr>", opts)
vim.keymap.set("n", "<Leader>w", "<cmd>:w<cr>", opts)
vim.keymap.set("n", "qq", "<cmd>q<cr>", opts)
vim.keymap.set("x", "K", ":move '<-2<cr>gv-gv'", opts)
vim.keymap.set("x", "J", ":move '>+1<cr>gv-gv'", opts)
