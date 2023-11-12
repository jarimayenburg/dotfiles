local function on_attach(_, bufnr)
    local nmap = function(keys, func)
        vim.keymap.set('n', keys, func, { buffer = bufnr, noremap = true, silent = true })
    end

    nmap('<leader>rn', vim.lsp.buf.rename)
    nmap('<leader>ca', vim.lsp.buf.code_action)

    nmap('gd', vim.lsp.buf.definition)
    nmap('gD', vim.lsp.buf.declaration)
    nmap('gr', require('telescope.builtin').lsp_references)
    nmap('gI', require('telescope.builtin').lsp_implementations)
    nmap('K', vim.lsp.buf.hover)
    nmap('<leader>e', vim.diagnostic.open_float)
    nmap('[e', vim.diagnostic.goto_prev)
    nmap(']e', vim.diagnostic.goto_next)
    nmap('<leader>q', vim.diagnostic.setloclist)
    nmap('<leader>f', vim.lsp.buf.format)
end

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local servers = {
  lua_ls = {
    settings = {
      Lua = {
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
      },
    }
  },
  rust_analyzer = {
    cmd = { "ra-multiplex" },
    settings = {
      ["rust-analyzer"] = {
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
      }
    }
  },
  jdtls = {},
  tsserver = {},
  gopls = {},
  pyright = {},
  intelephense = {},
}

return {
  on_attach = on_attach,
  capabilities = capabilities,
  servers = servers,
}
