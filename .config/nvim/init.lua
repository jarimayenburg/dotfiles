-- Install lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Initialize plugins
require('lazy').setup('plugins', {
  change_detection = {
    notify = false,
  }
})

local opt = vim.opt

-- Highlight every match, not just the first
-- Automatic C program indenting
-- Enable relative line numbers
vim.opt.incsearch = true
vim.opt.cindent = true
vim.opt.number = true
vim.opt.relativenumber = true

-- Number of spaces that a <Tab> counts for and number of spaces for autoindent.
-- Use spaces when <Tab> is pressed.
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Decrease update times for better UX
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Hide buffers instead of closing them.
vim.opt.hidden = true

-- True color support
vim.opt.termguicolors = true

-- More natural split opening
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Don't show the mode under the status line
vim.opt.showmode = false

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = false
vim.opt.smartcase = true

-- Set autocompletion menu to also show if there is only one option
-- and don't select any option by default.
vim.opt.completeopt = 'menuone,noselect'

-- Get rid of annoying swap files
vim.opt.swapfile = false

---------------- Keybindings -------------------

-- General mappings
local opts = { noremap = true, silent = true }

-- Remove highlightes
vim.keymap.set('n', '<leader><space>', ':noh<cr>', opts)

-- Remap the window switching keys
vim.keymap.set('n', '<C-h>', '<C-w>h', opts)
vim.keymap.set('n', '<C-j>', '<C-w>j', opts)
vim.keymap.set('n', '<C-k>', '<C-w>k', opts)
vim.keymap.set('n', '<C-l>', '<C-w>l', opts)

-- Copy paste stuff
vim.keymap.set('n', '<leader>p', '"+p', opts)
vim.keymap.set('n', '<leader>P', '"+P', opts)
vim.keymap.set('v', '<leader>p', '"_d"+P', opts)
vim.keymap.set('n', '<leader>y', '"+y', opts)
vim.keymap.set('n', '<leader>Y', '"+y$', opts)
vim.keymap.set('v', '<leader>y', '"+y', opts)
vim.keymap.set('n', '<leader>d', '"+d', opts)
vim.keymap.set('n', '<leader>D', '"+d$', opts)
vim.keymap.set('v', '<leader>d', '"+d', opts)

-- Yank rest of line
vim.keymap.set('n', 'Y', 'y$', opts)

-- Center screen on find next
vim.keymap.set('n', 'n', 'nzz', opts)
vim.keymap.set('n', 'N', 'Nzz', opts)

-- Undo break-points
vim.keymap.set('i', ',', ',<c-g>u', opts)
vim.keymap.set('i', '.', '.<c-g>u', opts)
vim.keymap.set('i', '[', '[<c-g>u', opts)
vim.keymap.set('i', '!', '!<c-g>u', opts)
vim.keymap.set('i', '?', '?<c-g>u', opts)

-- Go to next and previous in quickfix list
vim.keymap.set('n', 'gn', ':cn<cr>zz', opts)
vim.keymap.set('n', 'gp', ':cp<cr>zz', opts)

---------------- Autocommands -------------------

-- Transparency
vim.api.nvim_create_autocmd('VimEnter', {
  pattern = "*",
  command = "highlight Normal ctermbg=none guibg=none"
})
vim.api.nvim_create_autocmd('VimEnter', {
  pattern = "*",
  command = "highlight NeoTreeNormal ctermbg=none guibg=none"
})
vim.api.nvim_create_autocmd('VimEnter', {
  pattern = "*",
  command = "highlight NormalNC ctermbg=none guibg=none"
})
vim.api.nvim_create_autocmd('VimEnter', {
  pattern = "*",
  command = "highlight NeoTreeNormalNC ctermbg=none guibg=none"
})
vim.api.nvim_create_autocmd('VimEnter', {
  pattern = "*",
  command = "highlight Pmenu ctermbg=none guibg=none"
})
vim.api.nvim_create_autocmd('VimEnter', {
  pattern = "*",
  command = "highlight NonText ctermbg=none guibg=none"
})

-- Restart some daemons when their script changes
vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = vim.fn.expand('$HOME/.local/bin/statusbard'),
  callback = function () os.execute("pkill statusbard; statusbard >/dev/null 2>&1 &") end
})
