return {
  {
    'ray-x/go.nvim',
    dependencies = {
      'ray-x/guihua.lua',
      'neovim/nvim-lspconfig',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('go').setup({
        lsp_cfg     = false,
        lsp_keymaps = false,
        diagnostic  = false,
        goimports   = 'gopls',
        gofmt       = 'gopls',
      })
      vim.api.nvim_create_autocmd('BufWritePre', {
        pattern  = '*.go',
        group    = vim.api.nvim_create_augroup('GoFormat', { clear = true }),
        callback = function() require('go.format').goimports() end,
      })
    end,
    ft    = { 'go', 'gomod' },
    build = ':lua require("go.install").update_all_sync()',
  },

  {
    'rust-lang/rust.vim',
    ft = 'rust',
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },

  {
    'towolf/vim-helm',
    ft = { 'helm', 'yaml' },
  },

  {
    'terrastruct/d2-vim',
    ft = 'd2',
  },
}
