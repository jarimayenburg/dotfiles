return {
  'stevearc/oil.nvim',
  tag = "v2.8.0",
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
