return {
  'stevearc/oil.nvim',
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons'
  },
  keys = {
    { '-', '<cmd>Oil<cr>' }
  },
  opts = {
    default_file_explorer = true,
  },
}
