local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

autocmd('ColorScheme', {
  group = augroup('TransparentBg', { clear = true }),
  pattern = '*',
  callback = function()
    for _, hl in ipairs({ 'Normal', 'NeoTreeNormal', 'NeoTreeNormalNC', 'NormalNC', 'NonText', 'Pmenu' }) do
      vim.api.nvim_set_hl(0, hl, { bg = 'NONE', ctermbg = 'NONE' })
    end
  end,
})

autocmd('BufWritePost', {
  group = augroup('StatusbardRestart', { clear = true }),
  pattern = vim.fn.expand('$HOME') .. '/.local/bin/statusbard',
  callback = function()
    os.execute('pkill statusbard; statusbard >/dev/null 2>&1 &')
  end,
})

autocmd('TextYankPost', {
  group = augroup('YankHighlight', { clear = true }),
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 150 })
  end,
})
