local M = {}

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = 'rounded',
    source = 'always',
  },
})

local signs = { Error = 'E', Warn = 'W', Hint = 'H', Info = 'I' }
for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspAttach', { clear = true }),
  callback = function(ev)
    local bufnr = ev.buf

    local map = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, noremap = true, silent = true, desc = desc })
    end

    map('n', 'gd',          vim.lsp.buf.definition,                              'Go to definition')
    map('n', 'gD',          vim.lsp.buf.declaration,                             'Go to declaration')
    map('n', 'gr',          function() require('fzf-lua').lsp_references() end,  'References')
    map('n', 'gI',          function() require('fzf-lua').lsp_implementations() end, 'Implementations')
    map('n', 'K',           vim.lsp.buf.hover,                                   'Hover documentation')

    map('n', '<leader>rn',  vim.lsp.buf.rename,                                  'Rename symbol')
    map('n', '<leader>ca',  vim.lsp.buf.code_action,                             'Code action')
    map('v', '<leader>ca',  vim.lsp.buf.code_action,                             'Code action (visual)')
    map('n', '<leader>f',   function() vim.lsp.buf.format({ async = true }) end, 'Format buffer')

    map('n', '<leader>e',   vim.diagnostic.open_float,   'Float diagnostics')
    map('n', '[e',          vim.diagnostic.goto_prev,    'Prev diagnostic')
    map('n', ']e',          vim.diagnostic.goto_next,    'Next diagnostic')
    map('n', '<leader>q',   vim.diagnostic.setloclist,   'Diagnostics to quickfix')

    map('n', '<leader>h', function()
      vim.lsp.inlay_hint.enable(
        not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }),
        { bufnr = bufnr }
      )
    end, 'Toggle inlay hints')

    map('n', '<leader>li', ':checkhealth vim.lsp<cr>', 'LSP info')
    map('n', '<leader>lr', ':LspRestart<cr>',          'LSP restart')
    map('n', '<leader>ll', function()
      vim.cmd('tabnew ' .. vim.lsp.log.get_filename())
    end, 'LSP log')
  end,
})

function M.get_capabilities()
  local ok, blink = pcall(require, 'blink.cmp')
  if ok then
    return blink.get_lsp_capabilities()
  end
  return vim.lsp.protocol.make_client_capabilities()
end

return M
