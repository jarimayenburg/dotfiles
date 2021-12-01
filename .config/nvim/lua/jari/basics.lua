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

  opt.showmode = false        -- Don't show the mode under the status line

  opt.completeopt = 'menu,menuone,noselect'

  ----- Keybindings ------

  -- General mappings
  local opts = {noremap = true, silent = true}
  vim.api.nvim_set_keymap('n', '<Leader><space>', ':noh<cr>', opts)
  vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<cr>', opts)

  -- Remap the window switching keys
  vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', opts)
  vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', opts)
  vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', opts)
  vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', opts)

  -- Copy paste stuff
  vim.api.nvim_set_keymap('n', '<leader>p', '"+p', opts)
  vim.api.nvim_set_keymap('v', '<leader>p', '"_dP', opts)
  vim.api.nvim_set_keymap('n', '<leader>y', '"+y', opts)
  vim.api.nvim_set_keymap('v', '<leader>y', '"+y', opts)

  -- Delete without putting in register
  vim.api.nvim_set_keymap('n', '<leader>d', '"_g', opts)
  vim.api.nvim_set_keymap('v', '<leader>d', '"_g', opts)

  -- Quickfix list navigation
  vim.api.nvim_set_keymap('n', '<leader>j', ':cnext<cr>', opts)
  vim.api.nvim_set_keymap('n', '<leader>k', ':cp<cr>', opts)

  -- Yank rest of line
  vim.api.nvim_set_keymap('n', 'Y', 'y$', opts)

  -- Undo break-points
  vim.api.nvim_set_keymap('i', ',', ',<c-g>u', opts)
  vim.api.nvim_set_keymap('i', '.', '.<c-g>u', opts)
  vim.api.nvim_set_keymap('i', '[', '[<c-g>u', opts)
  vim.api.nvim_set_keymap('i', '!', '!<c-g>u', opts)
  vim.api.nvim_set_keymap('i', '?', '?<c-g>u', opts)

  -- Visual selection base64 encoding/decoding
  vim.api.nvim_set_keymap('v', '<leader>64d', 'c<c-r>=system(\'base64 --decode\', @")<cr><esc>', opts)
  vim.api.nvim_set_keymap('v', '<leader>64e', 'c<c-r>=system(\'base64\', @")<cr><esc>', opts)

  ----- Autocommands -----

  -- Filetype associations
  cmd 'au BufRead,BufNewFile *.sh.tpl set ft=sh'

  -- Transparency
  cmd 'au VimEnter * highlight Normal ctermbg=none guibg=none'
  cmd 'au VimEnter * highlight NonText ctermbg=none guibg=none'
end

return M
