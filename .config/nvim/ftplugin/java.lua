local home = os.getenv('HOME')

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = home .. '/.local/share/jdtls/workspaces/' .. project_name
local lombok_jar = home .. '/.local/lib/lombok/lombok.jar'
local bazel_eclipse_home = home .. '/.local/lib/bazel-eclipse'

local jdtls_dir = home .. '/.local/lib/jdtls'

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = {
    'java',
    '-javaagent:' .. lombok_jar,
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xms1g',
    '-jar', jdtls_dir .. '/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
    '-configuration', jdtls_dir .. '/config_linux',
    '-data', workspace_dir,
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
  },

  autostart = true,

  root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew', 'src'}),

  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
  settings = {
    java = {
        import = {
            bazel = {
                enabled = true
            }
        }
    }
  },

  -- Language server `initializationOptions`
  -- You need to extend the `bundles` with paths to jar files
  -- if you want to use additional eclipse.jdt.ls plugins.
  --
  -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
  --
  -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
  init_options = {
    bundles = {
        bazel_eclipse_home .. '/bundles/com.salesforce.b2eclipse.jdt.ls/target/com.salesforce.b2eclipse.jdt.ls-1.5.1-SNAPSHOT.jar',
        bazel_eclipse_home .. '/bundles/com.salesforce.bazel.eclipse.common/target/com.salesforce.bazel.eclipse.common-1.5.1-SNAPSHOT.jar',
        bazel_eclipse_home .. '/bundles/com.salesforce.bazel.eclipse.core/target/com.salesforce.bazel.eclipse.core-1.5.1-SNAPSHOT.jar',
        bazel_eclipse_home .. '/bundles/com.salesforce.bazel.eclipse.deps/target/com.salesforce.bazel.eclipse.deps-1.5.1-SNAPSHOT.jar',
        bazel_eclipse_home .. '/bundles/com.salesforce.bazel-java-sdk/target/com.salesforce.bazel-java-sdk-1.5.1-SNAPSHOT.jar',
    }
  },

  on_attach = require('jari.lsp').on_attach,

  capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
}

-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require('jdtls').start_or_attach(config)
