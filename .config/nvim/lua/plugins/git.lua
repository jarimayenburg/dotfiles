return {
  'tpope/vim-fugitive',

  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add          = { text = '+' },
        change       = { text = '~' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
        end
        local expr_map = function(mode, lhs, rhs)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, expr = true, silent = true })
        end

        expr_map({ 'n', 'v' }, ']c', function()
          if vim.wo.diff then return ']c' end
          vim.schedule(function() gs.next_hunk() end)
          return '<Ignore>'
        end)
        expr_map({ 'n', 'v' }, '[c', function()
          if vim.wo.diff then return '[c' end
          vim.schedule(function() gs.prev_hunk() end)
          return '<Ignore>'
        end)

        map('n', '<leader>hs', gs.stage_hunk,   'Stage hunk')
        map('n', '<leader>hr', gs.reset_hunk,   'Reset hunk')
        map('n', '<leader>hp', gs.preview_hunk, 'Preview hunk')
        map('n', '<leader>hb', gs.blame_line,   'Blame line')
      end,
    },
  },
}
