return {
  -- LSP Configuration & Plugins
  'neovim/nvim-lspconfig',
  dependencies = {
    -- Automatically install LSPs to stdpath for neovim
    { 'williamboman/mason.nvim', config = true },
    'williamboman/mason-lspconfig.nvim',

    -- Useful status updates for LSP
    -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
    { 'j-hui/fidget.nvim',       tag = 'legacy', opts = {} },

    -- Additional lua configuration, makes nvim stuff amazing!
    'folke/neodev.nvim',

    'nvim-telescope/telescope.nvim',

    -- Java language server (JDT.ls) extensions
    'mfussenegger/nvim-jdtls',
  },
  config = function()
    -- Setup neovim lua configuration
    require('neodev').setup()

    -- Ensure the servers above are installed
    local mason_lspconfig = require 'mason-lspconfig'

    local lsp_config = require('config.lsp')

    mason_lspconfig.setup {
      ensure_installed = vim.tbl_keys(lsp_config.servers),
    }

    mason_lspconfig.setup_handlers {
      function(server_name)
        -- jdtls is loaded through ftplugin instead
        if server_name == "jdtls" then
          return
        end

        require('lspconfig')[server_name].setup {
          capabilities = lsp_config.capabilities,
          on_attach = lsp_config.on_attach,
          settings = lsp_config.servers[server_name],
          filetypes = (lsp_config.servers[server_name] or {}).filetypes,
        }
      end
    }
  end
}
