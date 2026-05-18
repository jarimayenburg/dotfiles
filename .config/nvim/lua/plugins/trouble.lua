return {
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    cmd = 'Trouble',
    keys = {
      { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>',                                  desc = 'Diagnostics (Trouble)' },
      { '<leader>xw', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',                     desc = 'Workspace diagnostics (Trouble)' },
      { '<leader>xd', '<cmd>Trouble diagnostics toggle filter.buf=0 scope=document<cr>',      desc = 'Document diagnostics (Trouble)' },
      { '<leader>xl', '<cmd>Trouble loclist toggle<cr>',                                      desc = 'Location list (Trouble)' },
      { '<leader>xq', '<cmd>Trouble qflist toggle<cr>',                                       desc = 'Quickfix list (Trouble)' },
    },
    opts = {},
  },
}
