local M = {}

function M.setup()
    -- Filetype associations --
    vim.cmd 'au BufRead,BufNewFile *.sh.tpl set ft=sh'

    -- Transparency --
    vim.cmd 'au VimEnter * highlight Normal ctermbg=none guibg=none'
    vim.cmd 'au VimEnter * highlight NonText ctermbg=none guibg=none'

    -- Golang --

    -- Run source.organizeImports on save
    vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = { "*.go" },
        callback = function()
            local params = vim.lsp.util.make_range_params(nil, vim.lsp.util._get_offset_encoding())
            params.context = { only = {"source.organizeImports"} }

            local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
            for _, res in pairs(result or {}) do
                for _, r in pairs(res.result or {}) do
                    if r.edit then
                        vim.lsp.util.apply_workspace_edit(r.edit, vim.lsp.util._get_offset_encoding())
                    else
                        vim.lsp.buf.execute_command(r.command)
                    end

                    vim.cmd 'undojoin'
                end
            end
        end,
    })
end

return M
