local M = {}

local opts = {
    cmd = {},
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
}

function M.setup()
    local pkg_status, jdtls = pcall(require, "jdtls")
    if not pkg_status then
        vim.notify("unable to load nvim-jdtls", vim.log.levels.ERROR)
        return {}
    end

    local lombok_jar = vim.fn.stdpath("data") .. "/mason/packages/jdtls/lombok.jar"
    local jdtls_bin = vim.fn.stdpath("data") .. "/mason/bin/jdtls"

    local root_markers = { ".gradle", "gradlew", ".git" }
    local root_dir = jdtls.setup.find_root(root_markers)
    local home = os.getenv("HOME")
    local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
    local workspace_dir = home .. "/.cache/jdtls/workspace/" .. project_name

    opts.cmd = {
        jdtls_bin,
        "--jvm-arg=-javaagent:" .. lombok_jar,
        "-data", workspace_dir,
    }

    opts.on_attach = require('config.lsp').on_attach
    opts.capabilities = require('config.lsp').capabilities

    return opts
end

return M
