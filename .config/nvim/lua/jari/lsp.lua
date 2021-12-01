local M = {}

function M.on_attach(_, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  -- LSP signatures as you type
  require('lsp_signature').on_attach()

  -- Enable jdtls commands
  require('jdtls.setup').add_commands()

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<super>k', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

function M.setup()
  local lsp = require('lspconfig')

  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

  local cmd = vim.cmd
  local opt = vim.opt
  local g = vim.g

  -- Auto completion
  cmd 'inoremap <expr> <Tab>   pumvisible() ? "\\<C-n>" : "\\<Tab>"'
  cmd 'inoremap <expr> <S-Tab> pumvisible() ? "\\<C-p>" : "\\<S-Tab>"'
  cmd "au BufEnter * lua require'completion'.on_attach()"

  opt.completeopt = "menuone,noinsert,noselect"
  g.completion_matching_strategy_list = {"exact", "substring", "fuzzy"}

  -- Java
  -- Disabled because it doesn't work with Bazel. Now using JDT.ls in ftplugin.
  -- local jls_binary = '/home/jari/Programs/java-language-server/dist/lang_server_linux.sh'
  -- lsp.java_language_server.setup{
  --   cmd = {jls_binary},
  --   on_attach = M.on_attach
  -- }

  -- Python
  lsp.pyright.setup{ on_attach = M.on_attach, capabilities = capabilities }

  -- Typescript
  lsp.tsserver.setup{ on_attach = M.on_attach, capabilities = capabilities  }

  -- Rust
  lsp.rust_analyzer.setup{ on_attach = M.on_attach, capabilities = capabilities  }

  -- Haskell
  lsp.hls.setup{ on_attach = M.on_attach, capabilities = capabilities  }

  -- YAML
  lsp.yamlls.setup{ on_attach = M.on_attach, capabilities = capabilities  }

  local sumneko_root_path = '/home/jari/Programs/lua-language-server'
  local sumneko_binary = sumneko_root_path.."/bin/Linux/lua-language-server"

  local runtime_path = vim.split(package.path, ';')
  table.insert(runtime_path, "lua/?.lua")
  table.insert(runtime_path, "lua/?/init.lua")

  require'lspconfig'.sumneko_lua.setup {
    on_attach = M.on_attach,
    capabilities = capabilities,
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
          -- Setup your lua path
          path = runtime_path,
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = {'vim'},
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    },
  }

  -- Bash
  lsp.bashls.setup{ on_attach = M.on_attach, capabilities = capabilities }

  -- PHP
  lsp.intelephense.setup{ on_attach = M.on_attach, capabilities = capabilities }
end

return M
