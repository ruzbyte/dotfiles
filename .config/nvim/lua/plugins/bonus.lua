return {
  {
    "tpope/vim-fugitive",
  },
  {
    "mbbill/undotree",
  },
  {
    "brenoprata10/nvim-highlight-colors",
    config = function()
      require("nvim-highlight-colors").setup({})
    end,
  },
}
