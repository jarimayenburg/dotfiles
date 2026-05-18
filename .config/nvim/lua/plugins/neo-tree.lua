return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    lazy = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
      {
        's1n7ax/nvim-window-picker',
        version = '2.*',
        opts = {
          filter_rules = {
            include_current_win = false,
            autoselect_one = true,
            bo = {
              filetype = { 'neo-tree', 'neo-tree-popup', 'notify' },
              buftype = { 'terminal', 'quickfix' },
            },
          },
        },
      },
    },
    keys = {
      { '<C-n>', '<cmd>Neotree toggle<cr>', desc = 'NeoTree toggle' },
    },
    opts = {
      window = {
        width = 30,
        mappings = {
          ['S']     = false,
          ['s']     = 'split_with_window_picker',
          ['<C-s>'] = 'split_with_window_picker',
          ['x']     = 'split_with_window_picker',
          ['v']     = 'vsplit_with_window_picker',
          ['<C-v>'] = 'vsplit_with_window_picker',
        },
      },
      filesystem = {
        window = {
          mappings = {
            ['<bs>'] = 'close_node',
            ['.']    = false,
            ['o']    = 'open',
            ['oc']   = false,
            ['od']   = false,
            ['og']   = false,
            ['om']   = false,
            ['on']   = false,
            ['os']   = false,
            ['ot']   = false,
          },
        },
        filtered_items = {
          show_hidden_count = false,
          hide_dotfiles = false,
          hide_gitignored = true,
        },
        group_empty_dirs = true,
        hijack_netrw_behavior = 'open_current',
        use_libuv_file_watcher = true,
        follow_current_file = { enabled = true },
      },
    },
  },
}
