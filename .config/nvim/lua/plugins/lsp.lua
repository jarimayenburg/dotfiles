return {
  -- LSP Configuration & Plugins
  'neovim/nvim-lspconfig',
  dependencies = {
    -- Automatically install LSPs to stdpath for neovim
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',

    -- Useful status updates for LSP
    -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
    { 'j-hui/fidget.nvim', opts = {} },

    -- Additional lua configuration, makes nvim stuff amazing!
    'folke/neodev.nvim',

    'nvim-telescope/telescope.nvim',

    -- Java language server (JDT.ls) extensions
    'mfussenegger/nvim-jdtls',

    -- Signature hints on functions, structs, etc.
    { 'ray-x/lsp_signature.nvim', event = "VeryLazy" }
  },
  config = function()
    require('neodev').setup()
    require('mason').setup()

    local mason_lspconfig = require 'mason-lspconfig'

    local lsp_config = require('config.lsp')

    mason_lspconfig.setup {
      ensure_installed = lsp_config.servers,
      handlers = {
        lsp_config.setup_server,
        -- jdtls is loaded through ftplugin instead
        jdtls = function () end
      }
    }

    require('lsp_signature').setup({
      toggle_key = '<C-s>',
    })
  end
}
