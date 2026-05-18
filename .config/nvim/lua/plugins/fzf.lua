return {
  {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local fzf = require('fzf-lua')

      fzf.setup({
        winopts = {
          height = 0.85,
          width  = 0.80,
          preview = { layout = 'flex' },
        },
        grep = {
          rg_opts = '--column --line-number --no-heading --color=always --smart-case --hidden --glob "!**/.git/*"',
        },
        files = {
          rg_opts = '--color=never --files --hidden --follow --glob "!**/.git/*"',
          fd_opts = '--type f --hidden --follow --exclude .git',
        },
      })

      local o = { silent = true }
      vim.keymap.set('n', '<C-p>',      fzf.git_files,   vim.tbl_extend('force', o, { desc = 'Git files' }))
      vim.keymap.set('n', '<leader>tf', fzf.files,       vim.tbl_extend('force', o, { desc = 'Find files' }))
      vim.keymap.set('n', '<leader>ts', fzf.live_grep,   vim.tbl_extend('force', o, { desc = 'Live grep' }))
      vim.keymap.set('n', '<leader>tw', fzf.grep_cword,  vim.tbl_extend('force', o, { desc = 'Grep word under cursor' }))
      vim.keymap.set('n', '<leader>tb', fzf.buffers,     vim.tbl_extend('force', o, { desc = 'Buffers' }))
      vim.keymap.set('n', '<leader>th', fzf.help_tags,   vim.tbl_extend('force', o, { desc = 'Help tags' }))
    end,
  },
}
