local M = {}

function M.setup()
    local actions = require('telescope.actions')

    -- Keybindings
    local opts = {noremap = true, silent = true}
    vim.api.nvim_set_keymap('n', '<leader>ps', ":lua require('telescope.builtin').grep_string({ search = vim.fn.input(\"Grep For > \")})<CR>", opts)
    vim.api.nvim_set_keymap('n', '<C-p>', ":lua require('telescope.builtin').git_files()<CR>", opts)
    vim.api.nvim_set_keymap('n', '<leader>pf', ":lua require('telescope.builtin').find_files()<CR>", opts)
    vim.api.nvim_set_keymap('n', '<leader>pw', ":lua require('telescope.builtin').grep_string { search = vim.fn.expand(\"<cword>\") }<CR>", opts)
    vim.api.nvim_set_keymap('n', '<leader>pb', ":lua require('telescope.builtin').buffers()<CR>", opts)
    vim.api.nvim_set_keymap('n', '<leader>vh', ":lua require('telescope.builtin').help_tags()<CR>", opts)

    -- Telescope configuration
    require('telescope').setup {
        defaults = {
            file_sorter = require('telescope.sorters').get_fzy_sorter,
            color_devicons = true,

            file_previewer   = require('telescope.previewers').vim_buffer_cat.new,
            grep_previewer   = require('telescope.previewers').vim_buffer_vimgrep.new,
            qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,

            mappings = {
                i = {
                    ["<C-x>"] = false,
                    ["<C-q>"] = actions.send_to_qflist,
                },
            }
        },
        extensions = {
            fzy_native = {
                override_generic_sorter = false,
                override_file_sorter = true,
            }
        }
    }

    require('telescope').load_extension('fzy_native')
end

return M
