local lsp = require('lspconfig')
local map = require('jari.utils').map

local cmd = vim.cmd
local opt = vim.opt
local g = vim.g

-- Auto completion
cmd 'inoremap <expr> <Tab>   pumvisible() ? "\\<C-n>" : "\\<Tab>"'
cmd 'inoremap <expr> <S-Tab> pumvisible() ? "\\<C-p>" : "\\<S-Tab>"'
cmd "au BufEnter * lua require'completion'.on_attach()"

opt.completeopt = "menuone,noinsert,noselect"
g.completion_matching_strategy_list = {"exact", "substring", "fuzzy"}

local function on_attach(_, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<super>k', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

-- Python
lsp.pyright.setup{ on_attach = on_attach }

-- Java
lsp.jdtls.setup{
    cmd = { "/usr/bin/java", "-Declipse.application=org.eclipse.jdt.ls.core.id1", "-Dosgi.bundles.defaultStartLevel=4", "-Declipse.product=org.eclipse.jdt.ls.core.product", "-Dlog.protocol=true", "-Dlog.level=ALL", "-Xms1g", "-Xmx2G", "-jar", "/home/jari/Programs/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/plugins/org.eclipse.equinox.launcher_1.6.200.v20210416-2027.jar", "-configuration", "/home/jari/Programs/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/config_linux", "-data", "/home/jari/.workspace", "--add-modules=ALL-SYSTEM", "--add-opens java.base/java.util=ALL-UNNAMED", "--add-opens java.base/java.lang=ALL-UNNAMED" },
    cmd_env = {
      GRADLE_HOME = "/usr/share/gradle-7.1",
      JAR = "/home/jari/Programs/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/plugins/org.eclipse.equinox.launcher_1.6.200.v20210416-2027.jar",
      JDTLS_CONFIG = "/home/jari/Programs/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/config_linux",
      WORKSPACE = "$HOME/.workspace"
    },
    on_attach = on_attach
}

-- Typescript
lsp.tsserver.setup{ on_attach = on_attach }

-- Rust
lsp.rust_analyzer.setup{ on_attach = on_attach }

-- Haskell
lsp.hls.setup{ on_attach = on_attach }

-- YAML
lsp.yamlls.setup{ on_attach = on_attach }

-- Lua
local sumneko_root_path = '/home/jari/Programs/lua-language-server'
local sumneko_binary = sumneko_root_path .. "/bin/Linux/lua-language-server"
require'lspconfig'.sumneko_lua.setup {
    on_attach = on_attach,
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                path = vim.split(package.path, ';'),
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'},
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = {
                    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                    [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                },
            },
        },
    },
}

-- Bash
lsp.bashls.setup{ on_attach = on_attach }
