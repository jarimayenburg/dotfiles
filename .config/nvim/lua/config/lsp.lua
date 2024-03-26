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
        workspace = {
          checkThirdParty = false,
          library = vim.api.nvim_get_runtime_file("", true),
        },
        diagnostics = {
          globals = { "vim" },
        },
        telemetry = { enable = false },
      },
    }
  },
  rust_analyzer = {
    tag = "nightly",
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
          enable = true,
        }
      }
    }
  },
  jdtls = {
    autostart = true,
    settings = {
        java = {
            signatureHelp = { enabled = true },
            jdt = {
                ls = {
                    lombokSupport = {
                        enabled = true
                    }
                }
            }
        },
    },
    -- jdtls is loaded through ftplugin instead
    setup = function(server)
      local jdtls = require('jdtls')

      local lombok_jar = vim.fn.stdpath("data") .. "/mason/packages/jdtls/lombok.jar"
      local jdtls_bin = vim.fn.stdpath("data") .. "/mason/bin/jdtls"

      local root_markers = { ".gradle", "gradlew", ".git" }
      local root_dir = jdtls.setup.find_root(root_markers)
      local home = os.getenv("HOME")
      local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
      local workspace_dir = home .. "/.cache/jdtls/workspace/" .. project_name

      server.cmd = {
        jdtls_bin,
        "--jvm-arg=-javaagent:" .. lombok_jar,
        "-data", workspace_dir,
      }

      server = vim.tbl_deep_extend("keep", server, {
        on_attach = on_attach,
        capabilities = capabilities,
      })

      jdtls.start_or_attach(server)
    end,
  },
  tsserver = {},
  gopls = {},
  pyright = {},
  intelephense = {},
}

local M = {}

-- List of the names and optionally tags (versions) of all configured servers
---@type string[]
M.servers = {}
for name, server in pairs(servers) do
  if server.tag then
    name = name .. "@" .. server.tag
  end

  table.insert(M.servers, name)
end

-- Set up a server using `lspconfig` or the server's own `setup` function if it's
-- configured with one
M.setup_server = function(server_name, config)
  local server = servers[server_name] or {}

  server = vim.tbl_deep_extend("force", server, config or {});

  local setup = server.setup

  -- Remove our own keys that shouldn't be passed on to lspconfig
  server.setup = nil
  server.tag = nil

  -- If the server has a setup override, use that instead
  if setup then
    return setup(server)
  end

  server = vim.tbl_deep_extend("keep", server, {
    capabilities = capabilities,
    on_attach = on_attach,
  })

  require('lspconfig')[server_name].setup(server)
end

return M
