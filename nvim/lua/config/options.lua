vim.opt.hidden = true
vim.opt.backspace = { "indent", "eol", "start" }
vim.opt.joinspaces = false
vim.opt.list = false
vim.opt.linebreak = false
vim.opt.showmode = true
vim.opt.cursorline = true
vim.opt.inccommand = "nosplit"
vim.opt.encoding = "utf8"
vim.opt.autoindent = true
vim.opt.ruler = true

vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.scrolloff = 5
vim.opt.syntax = "on"
vim.opt.errorbells = false
vim.opt.visualbell = false
vim.opt.autowrite = true
vim.opt.clipboard = "unnamedplus"
vim.completeopt = "menuone,noinsert,noselect"
vim.optsmartindent = true
vim.opt.mouse = ""

vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.signcolumn = "auto"
vim.opt.lazyredraw = true
vim.colorcolumn = "80"

vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.shiftround = true

vim.opt.wrap = true

vim.opt.number = true
vim.numberwidth = 5
vim.opt.relativenumber = true

vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.showmatch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.laststatus = 2

vim.opt.backupdir = vim.fn.expand("~/.config/nvim-data/backup")
vim.opt.backup = true
vim.opt.swapfile = false -- disable swap files, keep swap dir config
vim.opt.directory = vim.fn.expand("~/.config/nvim-data/swap")
vim.opt.undodir = vim.fn.expand("~/.config/nvim-data/undo")
vim.opt.undofile = true


