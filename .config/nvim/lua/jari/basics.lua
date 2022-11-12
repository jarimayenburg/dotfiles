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

  ----- Globals -----

  -- Disable netrw
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1

  -- Run rustfmt when a Rust file is saved
  vim.g.rustfmt_autosave = 1

  ----- Keybindings ------

  -- General mappings
  local opts = {noremap = true, silent = true}
  vim.api.nvim_set_keymap('n', '<Leader><space>', ':noh<cr>', opts)

  -- Open filetree
  vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<cr>', opts)

  -- Remap the window switching keys
  vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', opts)
  vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', opts)
  vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', opts)
  vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', opts)

  -- Copy paste stuff
  vim.api.nvim_set_keymap('n', '<Leader>p', '"+p', opts)
  vim.api.nvim_set_keymap('n', '<Leader>P', '"+P', opts)
  vim.api.nvim_set_keymap('v', '<Leader>p', '"_d"+P', opts)
  vim.api.nvim_set_keymap('n', '<Leader>y', '"+y', opts)
  vim.api.nvim_set_keymap('n', '<Leader>Y', '"+y$', opts)
  vim.api.nvim_set_keymap('v', '<Leader>y', '"+y', opts)

  -- Delete without putting in register
  vim.api.nvim_set_keymap('n', '<Leader>d', '"_g', opts)
  vim.api.nvim_set_keymap('v', '<Leader>d', '"_g', opts)

  -- Yank rest of line
  vim.api.nvim_set_keymap('n', 'Y', 'y$', opts)

  -- Center screen on find next
  vim.api.nvim_set_keymap('n', 'n', 'nzz', opts)
  vim.api.nvim_set_keymap('n', 'N', 'Nzz', opts)

  -- Undo break-points
  vim.api.nvim_set_keymap('i', ',', ',<c-g>u', opts)
  vim.api.nvim_set_keymap('i', '.', '.<c-g>u', opts)
  vim.api.nvim_set_keymap('i', '[', '[<c-g>u', opts)
  vim.api.nvim_set_keymap('i', '!', '!<c-g>u', opts)
  vim.api.nvim_set_keymap('i', '?', '?<c-g>u', opts)

  -- Visual selection base64 encoding/decoding
  vim.api.nvim_set_keymap('v', '<Leader>64d', 'c<c-r>=system(\'base64 --decode\', @")<cr><esc>', opts)
  vim.api.nvim_set_keymap('v', '<Leader>64e', 'c<c-r>=system(\'base64 -w 0\', @")<cr><esc>', opts)

  ----- Autocommands -----

  -- Filetype associations --
  vim.api.nvim_create_autocmd('BufRead,BufNewFile', {
    pattern = "*.sh.tpl",
    command = "set ft=sh"
  })

  -- Transparency --
  vim.api.nvim_create_autocmd('VimEnter', {
    pattern = "*",
    command = "highlight Normal ctermbg=none guibg=none"
  })

  vim.api.nvim_create_autocmd('VimEnter', {
    pattern = "*",
    command = "highlight NonText ctermbg=none guibg=none"
  })
end

return M
