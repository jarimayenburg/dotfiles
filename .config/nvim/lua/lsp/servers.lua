local M = {}

M.servers = {
  gopls = {},

  pyright = {},

  ts_ls = {},

  lua_ls = {
    settings = {
      Lua = {
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
        diagnostics = { globals = { 'vim' } },
        hint = { enable = true },
      },
    },
  },

  jsonls = {},

  bashls = {},

  lemminx = {},

  marksman = {},

  -- Use 'rust-analyzer@nightly' here if nightly is needed
  rust_analyzer = {
    settings = {
      ['rust-analyzer'] = {
        imports = {
          granularity = { group = 'module' },
          prefix = 'self',
        },
        cargo = {
          buildScripts = { enable = true },
        },
        procMacro = { enable = true },
      },
    },
  },
}

-- jdtls is excluded: handled manually via ftplugin/java.lua
M.ensure_installed = vim.tbl_keys(M.servers)

return M
