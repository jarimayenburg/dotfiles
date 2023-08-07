-----------------------------------
-- Treesitter
-----------------------------------

local M = {}

function M.setup()
  require'nvim-treesitter.configs'.setup {
    ensure_installed = "all",
    autotag = {
      enable = true,
    },
    highlight = {
      enable = true,              -- false will disable the whole extension
    },
  }

  -- Use the HTML parser for XML files
  vim.treesitter.language.register("html", "xml")

  vim.api.nvim_set_keymap('n', '<leader>ht', ':TSBufToggle highlight<cr>', {noremap = true, silent = true})
end

return M
