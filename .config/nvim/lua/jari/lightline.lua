local M = {}

function M.setup()
  local g = vim.g

  g.lightline = {
    active = {
      left = {
        { 'mode', 'paste' },
        { 'gitbranch', 'cocstatus', 'readonly', 'filename', 'modified' }
      }
    },
    component_function = {
      gitbranch = 'FugitiveHead',
      cocstatus = 'coc#status'
    }
  }
end

return M
