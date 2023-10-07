return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.3',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'nvim-treesitter/nvim-treesitter',
    { 'nvim-telescope/telescope-fzy-native.nvim', build = 'make' },
  },
  config = function()
    local telescope = require('telescope')
    local config = require('telescope.config')
    local actions = require('telescope.actions')

    local vimgrep_arguments = { unpack(config.values.vimgrep_arguments) }

    -- I want to search hidden/dot files
    table.insert(vimgrep_arguments, "--hidden")

    -- I don't want to search in the .git directory
    table.insert(vimgrep_arguments, "--glob")
    table.insert(vimgrep_arguments, "!**/.git/*")

    -- Keybindings
    local opts = { silent = true }
    vim.keymap.set('n', '<leader>ts',
      function() require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ") }) end, opts)
    vim.keymap.set('n', '<C-p>', require('telescope.builtin').git_files, opts)
    vim.keymap.set('n', '<leader>tf', require('telescope.builtin').find_files, opts)
    vim.keymap.set('n', '<leader>tw',
      function() require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") } end, opts)
    vim.keymap.set('n', '<leader>tb', require('telescope.builtin').buffers, opts)
    vim.keymap.set('n', '<leader>th', require('telescope.builtin').help_tags, opts)

    -- Telescope configuration
    telescope.setup {
      defaults = {
        color_devicons    = true,

        file_previewer    = require('telescope.previewers').vim_buffer_cat.new,
        grep_previewer    = require('telescope.previewers').vim_buffer_vimgrep.new,
        qflist_previewer  = require('telescope.previewers').vim_buffer_qflist.new,

        vimgrep_arguments = vimgrep_arguments,

        mappings          = {
          i = {
            ["<C-x>"] = false,
            ["<C-q>"] = actions.send_to_qflist,
          },
        },

        preview           = {
          treesitter = false
        }
      },
      pickers = {
        find_files = {
          find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" }
        }
      },
      extensions = {
        fzy_native = {
          fuzzy = true,                    -- false will only do exact matching
          override_generic_sorter = false, -- don't override the generic sorter
          override_file_sorter = true,     -- override the file sorter
          case_mode = "ignore_case",       -- or "ignore_case" or "respect_case"
          -- the default case_mode is "smart_case"
        },
      }
    }

    telescope.load_extension('fzy_native')
  end
}
