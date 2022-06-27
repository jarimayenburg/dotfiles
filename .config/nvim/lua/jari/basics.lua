-----------------------------------------------------------
-- Basic configuration (options/general keybindings/etc)
-----------------------------------------------------------

local M = {}

function M.setup()
    local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
    local opt = vim.opt  -- to set options

    opt.incsearch = true        -- Highlight every match, not just the first
    opt.cindent = true          -- Automatic C program indenting
    opt.number = true           -- Enable line numbers
    opt.relativenumber = true   -- Enable relative line numbers

    opt.tabstop = 4             -- Number of spaces that a <Tab> counts for
    opt.shiftwidth = 4          -- Number of spaces to use for autoindentation
    opt.expandtab = true        -- To use spaces when <Tab> is pressed

    opt.updatetime = 50         -- Decrease updatetime to 50ms for better UX

    opt.hidden = true           -- Hide buffers instead of closing them.

    opt.termguicolors = true    -- True color support

    cmd 'colorscheme gruvbox'   -- Set the color scheme

    opt.splitbelow = true       -- More natural split opening
    opt.splitright = true

    opt.showmode = false        -- Don't show the mode under the status line

    opt.completeopt = 'menu,menuone,noselect'

    ----- Keybindings ------

    -- Set leader to be space
    vim.g.mapleader = "<Space>"

    -- General mappings
    local opts = {noremap = true, silent = true}
    vim.api.nvim_set_keymap('n', '<Leader><space>', ':noh<cr>', opts)

    -- Reload config
    vim.api.nvim_set_keymap('n', '<leader>r', ':so ~/.config/nvim/init.lua<cr>', opts)

    -- Open filetree
    vim.api.nvim_set_keymap('n', '<C-n>', ':Ex<cr>', opts)

    -- Remap the window switching keys
    vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', opts)
    vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', opts)
    vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', opts)
    vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', opts)

    -- Copy paste stuff
    vim.api.nvim_set_keymap('n', '<leader>p', '"+p', opts)
    vim.api.nvim_set_keymap('n', '<leader>P', '"+P', opts)
    vim.api.nvim_set_keymap('v', '<leader>p', '"_dP', opts)
    vim.api.nvim_set_keymap('n', '<leader>y', '"+y', opts)
    vim.api.nvim_set_keymap('n', '<leader>Y', '"+y$', opts)
    vim.api.nvim_set_keymap('v', '<leader>y', '"+y', opts)

    -- Delete without putting in register
    vim.api.nvim_set_keymap('n', '<leader>d', '"_g', opts)
    vim.api.nvim_set_keymap('v', '<leader>d', '"_g', opts)

    -- Yank rest of line
    vim.api.nvim_set_keymap('n', 'Y', 'y$', opts)

    -- Center screen on find next
    vim.api.nvim_set_keymap('n', 'n', 'nzz', opts)
    vim.api.nvim_set_keymap('n', 'N', 'Nzz', opts)

    -- Undo break-points
    vim.api.nvim_set_keymap('i', ',', ',<c-g>u', opts)
    vim.api.nvim_set_keymap('i', '.', '.<c-g>u', opts)
    vim.api.nvim_set_keymap('i', '[', '[<c-g>u', opts)
    vim.api.nvim_set_keymap('i', '!', '!<c-g>u', opts)
    vim.api.nvim_set_keymap('i', '?', '?<c-g>u', opts)

    -- Visual selection base64 encoding/decoding
    vim.api.nvim_set_keymap('v', '<leader>64d', 'c<c-r>=system(\'base64 --decode\', @")<cr><esc>', opts)
    vim.api.nvim_set_keymap('v', '<leader>64e', 'c<c-r>=system(\'base64\', @")<cr><esc>', opts)

    ----- Autocommands -----

    -- Filetype associations --
    vim.cmd 'au BufRead,BufNewFile *.sh.tpl set ft=sh'

    -- Transparency --
    vim.cmd 'au VimEnter * highlight Normal ctermbg=none guibg=none'
    vim.cmd 'au VimEnter * highlight NonText ctermbg=none guibg=none'

    -- Run source.organizeImports on save for Golang files
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
