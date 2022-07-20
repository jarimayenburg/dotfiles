-----------------------------------
-- Treesitter
-----------------------------------

local M = {}

function M.setup()
  require'nvim-treesitter.configs'.setup {
    ensure_installed = "all",
    highlight = {
      enable = true,              -- false will disable the whole extension
    },
  }

  vim.api.nvim_set_keymap('n', '<leader>ht', ':TSBufToggle highlight<cr>', {noremap = true, silent = true})
end

return M
