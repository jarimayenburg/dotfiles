-------------------------------------
-- My NVIM configuration Lua module
-------------------------------------

local M = {}

function M.setup()
  require("jari.plugins").setup()
  require("jari.basics").setup()
  require("jari.lualine").setup()
  require("jari.lsp").setup()
  require("jari.cmp").setup()
  require("jari.telescope").setup()
  require("jari.treesitter").setup()
  require('jari.vimwiki').setup()
end

return M
