-----------------------------------------------------------
-- Basic configuration (options/general keybindings/etc)
-----------------------------------------------------------

local M = {}

function M.setup()
  local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
  local opt = vim.opt  -- to set options

  opt.incsearch = true        -- Highlight every match, not just the first
  opt.cindent = true          -- Automatic C program indenting
  opt.number = true           -- Enable line numbers
  opt.relativenumber = true   -- Enable relative line numbers

  opt.tabstop = 4             -- Number of spaces that a <Tab> counts for
  opt.shiftwidth = 4          -- Number of spaces to use for autoindentation
  opt.expandtab = true        -- To use spaces when <Tab> is pressed

  opt.updatetime = 50         -- Decrease updatetime to 50ms for better UX

  opt.hidden = true           -- Hide buffers instead of closing them.

  opt.termguicolors = true    -- True color support

  cmd 'colorscheme gruvbox'   -- Set the color scheme

  opt.splitbelow = true       -- More natural split opening
  opt.splitright = true

  -- Transparency
  cmd 'au VimEnter * highlight Normal ctermbg=none guibg=none'
  cmd 'au VimEnter * highlight NonText ctermbg=none guibg=none'

  ----- Keybindings ------

  local map = require("jari.utils").map

  -- Keybinding helper function

  -- General mappings
  map('n', '<Leader><space>', ':noh<cr>')
  map('n', '<C-n>', ':NvimTreeToggle<cr>')

  -- Remap the window switching keys
  map('n', '<C-h>', '<C-w>h')
  map('n', '<C-j>', '<C-w>j')
  map('n', '<C-k>', '<C-w>k')
  map('n', '<C-l>', '<C-w>l')

  -- Copy paste stuff
  map('n', '<leader>p', '"+p')
  map('v', '<leader>p', '"_dP')
  map('n', '<leader>y', '"+y')
  map('v', '<leader>y', '"+y')

  -- Delete without putting in register
  map('n', '<leader>d', '"_g')
  map('v', '<leader>d', '"_g')

  -- Quickfix list navigation
  map('n', '<leader>j', ':cnext<cr>')
  map('n', '<leader>k', ':cp<cr>')

  -- Yank rest of line
  map('n', 'Y', 'y$')

  -- Undo break-points
  map('i', ',', ',<c-g>u')
  map('i', '.', '.<c-g>u')
  map('i', '[', '[<c-g>u')
  map('i', '!', '!<c-g>u')
  map('i', '?', '?<c-g>u')

  -- Visual selection base64 encoding/decoding
  map('v', '<leader>64d', 'c<c-r>=system(\'base64 --decode\', @")<cr><esc>')
  map('v', '<leader>64e', 'c<c-r>=system(\'base64\', @")<cr><esc>')
end

return M
