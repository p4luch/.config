local opts = { noremap = true, silent = true }
return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "debugloop/telescope-undo.nvim",
    },
    keys = {
      {
        "<Leader>ff",
        "<cmd>Telescope find_files find_command=fd,--type,f,--strip-cwd-prefix,--hidden,--follow,--exclude,.git<cr>",
        opts,
      },
      { "<Leader>fg", "<cmd>Telescope live_grep<cr>", opts },
      { "<Leader>bf", "<cmd>Telescope file_browser<cr>", opts },
      { "<Leader>u", "<cmd>Telescope undo<cr>", opts },
    },
    config = function()
      require("telescope").setup({
        pickers = {
          find_files = {
            previewer = false,
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
          file_browser = {
            hijack_netrw = true,
            previewer = false,
          },
          undo = {
            side_by_side = true,
            layout_strategy = "vertical",
            layout_config = {
              preview_height = 0.8,
            },
          },
        },
      })
      require("telescope").load_extension("fzf")
      require("telescope").load_extension("file_browser")
      require("telescope").load_extension("undo")
    end,
  },
}
