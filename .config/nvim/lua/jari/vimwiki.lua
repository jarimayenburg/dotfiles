local M = {}

function M.setup()
    -- Set the Vimwiki locations
    vim.api.nvim_set_var('vimwiki_list', {
        {
            path = '~/Repos/personal/wiki/src',
            path_html = '~/Repos/personal/wiki/dist'
        }
    })
end

return M
