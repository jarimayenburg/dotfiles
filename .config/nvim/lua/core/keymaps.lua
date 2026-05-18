local map = function(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, desc = desc })
end

map('n', '<leader><space>', ':noh<cr>', 'Clear search highlights')

map('n', '<C-h>', '<C-w>h', 'Window left')
map('n', '<C-j>', '<C-w>j', 'Window down')
map('n', '<C-k>', '<C-w>k', 'Window up')
map('n', '<C-l>', '<C-w>l', 'Window right')

map('n', '<leader>p', '"+p',    'Paste from clipboard')
map('n', '<leader>P', '"+P',    'Paste before from clipboard')
map('n', '<leader>y', '"+y',    'Yank to clipboard')
map('n', '<leader>Y', '"+y$',   'Yank line to clipboard')
map('v', '<leader>y', '"+y',    'Yank selection to clipboard')
map('n', '<leader>d', '"+d',    'Delete to clipboard')
map('n', '<leader>D', '"+d$',   'Delete to end to clipboard')
map('v', '<leader>d', '"+d',    'Delete selection to clipboard')

map('n', 'Y', 'y$', 'Yank to end of line')

map('n', 'n', 'nzz', 'Next match (centered)')
map('n', 'N', 'Nzz', 'Prev match (centered)')

vim.keymap.set('i', ',', ',<c-g>u')
vim.keymap.set('i', '.', '.<c-g>u')
vim.keymap.set('i', '[', '[<c-g>u')
vim.keymap.set('i', '!', '!<c-g>u')
vim.keymap.set('i', '?', '?<c-g>u')

map('n', 'gn', ':cn<cr>zz', 'Next quickfix')
map('n', 'gp', ':cp<cr>zz', 'Prev quickfix')
