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
            color_devicons = true,

            file_previewer   = require('telescope.previewers').vim_buffer_cat.new,
            grep_previewer   = require('telescope.previewers').vim_buffer_vimgrep.new,
            qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,

            mappings = {
                i = {
                    ["<C-x>"] = false,
                    ["<C-q>"] = actions.send_to_qflist,
                },
            },

            preview = {
                treesitter = false
            }
        },
        extensions = {
            fzy_native = {
                fuzzy = true,                    -- false will only do exact matching
                override_generic_sorter = false, -- don't override the generic sorter
                override_file_sorter = true,     -- override the file sorter
                case_mode = "ignore_case",       -- or "ignore_case" or "respect_case"
                                                 -- the default case_mode is "smart_case"
            }
        }
    }

    require('telescope').load_extension('fzy_native')
end

return M
