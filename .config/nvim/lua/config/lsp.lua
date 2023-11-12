local function on_attach(_, bufnr)
  local map = function(mode, keys, func)
    vim.keymap.set(mode, keys, func, { buffer = bufnr, noremap = true, silent = true })
  end

  map('n', '<leader>rn', vim.lsp.buf.rename)
  map('n', '<leader>ca', vim.lsp.buf.code_action)

  map('n', 'gd', vim.lsp.buf.definition)
  map('n', 'gD', vim.lsp.buf.declaration)
  map('n', 'gr', require('telescope.builtin').lsp_references)
  map('n', 'gI', require('telescope.builtin').lsp_implementations)
  map('n', 'K', vim.lsp.buf.hover)
  map('n', '<leader>e', vim.diagnostic.open_float)
  map('n', '[e', vim.diagnostic.goto_prev)
  map('n', ']e', vim.diagnostic.goto_next)
  map('n', '<leader>q', vim.diagnostic.setloclist)
  map('n', '<leader>f', vim.lsp.buf.format)
  map('n', '<leader>h', function() vim.lsp.inlay_hint(bufnr) end)
  map('i', '<c-h>', function() vim.lsp.inlay_hint(bufnr) end)

  map('n', '<leader>li', ':LspInfo<cr>')
  map('n', '<leader>ll', ':LspLog<cr>')
  map('n', '<leader>lr', ':LspRestart<cr>')
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
