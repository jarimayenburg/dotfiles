local actions = require('telescope.actions')
local map = require('jari.utils').map

-- Keybindings
map('n', '<leader>ps', ":lua require('telescope.builtin').grep_string({ search = vim.fn.input(\"Grep For > \")})<CR>")
map('n', '<C-p>', ":lua require('telescope.builtin').git_files()<CR>")
map('n', '<leader>pf', ":lua require('telescope.builtin').find_files()<CR>")
map('n', '<leader>pw', ":lua require('telescope.builtin').grep_string { search = vim.fn.expand(\"<cword>\") }<CR>")
map('n', '<leader>pb', ":lua require('telescope.builtin').buffers()<CR>")
map('n', '<leader>vh', ":lua require('telescope.builtin').help_tags()<CR>")

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
