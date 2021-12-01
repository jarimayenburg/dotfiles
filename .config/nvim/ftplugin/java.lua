local home = os.getenv('HOME')

-- Java
require('jdtls').start_or_attach{
  cmd = {home .. "/.local/bin/jdtls"},
  -- flags = {
  --   allow_incremental_sync = true,
  -- },
  -- settings = {
  --   java = {
  --     signatureHelp = { enabled = true };
  --     contentProvider = { preferred = 'fernflower' };
  --     completion = {
  --       favoriteStaticMembers = {
  --         "org.hamcrest.MatcherAssert.assertThat",
  --         "org.hamcrest.Matchers.*",
  --         "org.hamcrest.CoreMatchers.*",
  --         "org.junit.jupiter.api.Assertions.*",
  --         "java.util.Objects.requireNonNull",
  --         "java.util.Objects.requireNonNullElse",
  --         "org.mockito.Mockito.*"
  --       }
  --     };
  --     sources = {
  --       organizeImports = {
  --         starThreshold = 9999;
  --         staticStarThreshold = 9999;
  --       };
  --     };
  --     codeGeneration = {
  --       toString = {
  --         template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
  --       }
  --     }
  --   }
  -- },
  on_attach = require('jari.lsp').on_attach,
  capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
  root_dir = require('jdtls.setup').find_root({'.git',  'gradlew', 'pom.xml', 'BUILD'})
}
