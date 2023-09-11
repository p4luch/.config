-- This file contains autocommands.
-- autocmd is command called automatically on file writting or reading

local cmd = vim.cmd

-- recompile packer config on plugins.lua save
cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

cmd([[
  augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost * FormatWrite
 augroup end
]])

vim.api.nvim_create_autocmd({ "BufEnter", "BufAdd", "BufNew", "BufNewFile", "BufWinEnter" }, {
  group = vim.api.nvim_create_augroup("TS_FOLD_WORKAROUND", {}),
  callback = function()
    vim.opt.foldmethod = "expr"
    vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
  end,
})
