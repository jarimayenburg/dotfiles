return {
  'tpope/vim-sleuth',

  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {
      check_ts = true,
    },
  },

  {
    'numToStr/Comment.nvim',
    event = 'VeryLazy',
    opts = {},
  },

  {
    'kylechui/nvim-surround',
    version = '^3.0.0',
    event = 'VeryLazy',
    opts = {},
  },
}
