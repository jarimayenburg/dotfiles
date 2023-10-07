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
    local servers = {
      lua_ls = {
        Lua = {
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
        },
      },
      rust_analyzer = {
        imports = {
          granularity = {
            group = "module"
          },
          prefix = "self"
        },
        cargo = {
          buildScripts = {
            enable = true
          }
        },
        procMacro = {
          enable = true
        },
      },
      jdtls = {},
      tsserver = {},
      gopls = {},
      pyright = {},
      intelephense = {},
    }

    -- Setup neovim lua configuration
    require('neodev').setup()

    -- Ensure the servers above are installed
    local mason_lspconfig = require 'mason-lspconfig'

    mason_lspconfig.setup {
      ensure_installed = vim.tbl_keys(servers),
    }

    mason_lspconfig.setup_handlers {
      function(server_name)
        -- jdtls is loaded through ftplugin instead
        if server_name == "jdtls" then
          return
        end

        require('lspconfig')[server_name].setup {
          capabilities = require('config.lsp').capabilities,
          on_attach = require('config.lsp').on_attach,
          settings = servers[server_name],
          filetypes = (servers[server_name] or {}).filetypes,
        }
      end
    }
  end
}
