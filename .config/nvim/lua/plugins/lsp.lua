return {
  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    opts = {
      PATH = 'append',
    },
  },

  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'williamboman/mason.nvim' },
    config = function()
      local servers = require('lsp.servers')
      require('mason-lspconfig').setup({
        ensure_installed = servers.ensure_installed,
        automatic_enable = {
          exclude = { 'jdtls' },
        },
      })
    end,
  },

  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
      'saghen/blink.cmp',
    },
    config = function()
      local lsp_core = require('lsp')
      local servers = require('lsp.servers')

      vim.lsp.config('*', {
        capabilities = lsp_core.get_capabilities(),
      })

      for name, config in pairs(servers.servers) do
        if next(config) ~= nil then
          vim.lsp.config(name, config)
        end
      end
    end,
  },

  {
    'j-hui/fidget.nvim',
    opts = {
      notification = {
        window = { winblend = 0 },
      },
    },
  },

  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        'lazy.nvim',
      },
    },
  },

  {
    'ray-x/lsp_signature.nvim',
    event = 'LspAttach',
    opts = {
      toggle_key = '<C-s>',
      toggle_key_flip_floatwin_setting = true,
      hint_enable = false,
      handler_opts = { border = 'rounded' },
    },
  },

  { 'mfussenegger/nvim-jdtls', ft = 'java' },
}
