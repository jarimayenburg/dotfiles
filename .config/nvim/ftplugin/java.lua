if vim.b.jdtls_started then return end
vim.b.jdtls_started = true

local jdtls = require('jdtls')
local lsp_core = require('lsp')

local mason_data = vim.fn.stdpath('data') .. '/mason'
local lombok_jar = mason_data .. '/packages/jdtls/lombok.jar'
local jdtls_bin  = mason_data .. '/bin/jdtls'

local root_markers = { '.gradle', 'gradlew', 'mvnw', '.git' }
local root_dir     = jdtls.setup.find_root(root_markers)
local project_name = vim.fn.fnamemodify(root_dir, ':p:h:t')
local workspace    = vim.env.HOME .. '/.cache/jdtls/workspace/' .. project_name

jdtls.start_or_attach({
  cmd = {
    jdtls_bin,
    '--jvm-arg=-javaagent:' .. lombok_jar,
    '-data', workspace,
  },
  root_dir     = root_dir,
  capabilities = lsp_core.get_capabilities(),
  settings = {
    java = {
      signatureHelp = { enabled = true },
      jdt = {
        ls = { lombokSupport = { enabled = true } },
      },
    },
  },
  init_options = {
    bundles = {},
  },
})
