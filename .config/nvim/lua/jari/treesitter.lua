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
end

return M
