-- This file can be loaded by calling `lua require('plugins')` from your init.vim
return require("packer").startup({
  function(use)
    -- Packer can manage itself
    use("wbthomason/packer.nvim")

    -- Colorscheme Tundra
    use("sam4llis/nvim-tundra")
    -- Colorscheme Mountain
    use("mountain-theme/Mountain")
    -- Icons
    use("kyazdani42/nvim-web-devicons") -- configured
    -- Status linve looks
    use("nvim-lualine/lualine.nvim") -- configured, for now
    use("farmergreg/vim-lastplace") -- configured
    -- Autocompletion, snippets
    use("hrsh7th/nvim-cmp") -- configured
    use("hrsh7th/cmp-nvim-lsp") -- configured
    use("hrsh7th/cmp-buffer") -- configured
    use("hrsh7th/cmp-path") -- configured
    use("hrsh7th/cmp-cmdline") -- configured
    use("hrsh7th/cmp-vsnip") -- configured
    use("hrsh7th/vim-vsnip") -- configured
    use("hrsh7th/cmp-nvim-lua") -- configured
    -- Symbols for code snippets
    use("onsails/lspkind-nvim") -- configured
    -- Language Server Protocl, mangement, config
    use("williamboman/mason.nvim") -- configured
    use("williamboman/mason-lspconfig.nvim") -- configured
    use("neovim/nvim-lspconfig") -- configured
    -- Code linting and formatting
    use("mfussenegger/nvim-lint") -- configured
    use("mhartington/formatter.nvim") -- configured
    use("nvim-lua/plenary.nvim") -- configured
    use("nvim-lua/telescope.nvim") -- configured
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- configured
    use("nvim-telescope/telescope-file-browser.nvim") -- configured
    -- comment out things, commands- gc and gcc
    use("b3nj5m1n/kommentary") -- configured
    -- Navigation between file and it's tests
    use("tpope/vim-projectionist") -- configured TODO needs keybindings
    -- test runner from within test file buffer
    use("vim-test/vim-test") -- configured
    -- Git gutter, e.g. color mark that line changed
    use("lewis6991/gitsigns.nvim") -- configured
    -- Show lines for code blocks
    use("lukas-reineke/indent-blankline.nvim") -- configured
    -- autopair for braces
    use("windwp/nvim-autopairs") -- confiugred
    -- manage braces, surround text in " or '
    use("tpope/vim-surround") -- confiugred need keybindings
    -- multi cursor support
    use({ "mg979/vim-visual-multi", branch = "master" }) -- configred, need keybindings
    -- Code coloring
    use({
      "nvim-treesitter/nvim-treesitter",
      run = function()
        require("nvim-treesitter.install").update({ with_sync = true })
      end,
    }) -- configured
    use("nvim-treesitter/playground")
    use("mbbill/undotree") -- confiugred TODO need keybindingsi
    use("mfussenegger/nvim-dap")
    use("beauwilliams/focus.nvim")
    use({ "phaazon/hop.nvim", branch = "v2" })
    use("alexghergh/nvim-tmux-navigation")
    use("tpope/vim-fugitive")
    use("asiryk/auto-hlsearch.nvim")
    use({
      "iamcco/markdown-preview.nvim",
      run = "cd app && npm install",
      setup = function()
        vim.g.mkdp_filetypes = { "markdown" }
      end,
      ft = { "markdown" },
    })
    use("JellyApple102/easyread.nvim")
  end,
  config = {
    display = {
      open_fn = function()
        return require("packer.util").float({ border = "single" })
      end,
    },
  },
})
