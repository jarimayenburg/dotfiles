return {
  -- Colorscheme
  {
    'sainnhe/gruvbox-material',
    priority = 1000,
    lazy = false,
    config = function()
      vim.g.gruvbox_material_background = 'medium'
      vim.g.gruvbox_material_foreground = 'original'
      vim.g.gruvbox_material_transparent_background = 1
      vim.g.gruvbox_material_diagnostic_virtual_text = 'colored'

      vim.cmd.colorscheme 'gruvbox-material'
    end
  },

  -- Git functionality
  'tpope/vim-fugitive',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- Auto pairing
  {
    "windwp/nvim-autopairs",
    dependencies = { 'hrsh7th/nvim-cmp' },
    config = function()
      require("nvim-autopairs").setup {}

      -- Automatically add `(` after selecting a function or method
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp = require('cmp')
      cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
      )
    end,
  },
  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        -- vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk,
        --   { buffer = bufnr, desc = 'Preview git hunk' })

        -- don't override the built-in and fugitive keymaps
        local gs = package.loaded.gitsigns
        vim.keymap.set({ 'n', 'v' }, ']c', function()
          if vim.wo.diff then return ']c' end
          vim.schedule(function() gs.next_hunk() end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = "Jump to next hunk" })
        vim.keymap.set({ 'n', 'v' }, '[c', function()
          if vim.wo.diff then return '[c' end
          vim.schedule(function() gs.prev_hunk() end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = "Jump to previous hunk" })
      end,
    },
  },

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = false,
        theme = 'gruvbox-material',
        component_separators = '|',
        section_separators = '',
      },
    },
  },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- Rust language support
  {
    'rust-lang/rust.vim',
    config = function ()
      -- Run rustfmt when a Rust file is saved
      vim.g.rustfmt_autosave = 1
    end
  },

  -- PlantUML support
  {
    'weirongxu/plantuml-previewer.vim',
    dependencies = {
      'aklt/plantuml-syntax',
      'tyru/open-browser.vim',
    }
  },

  -- Surround selections
  {
    'kylechui/nvim-surround',
    version = '*',
    event = "VeryLazy",
    config = function ()
      require('nvim-surround').setup()
    end
  },

  'towolf/vim-helm',

  -- For secure local configuration files (i.e. .nvim.lua, .nvimrc, .execrc)
  {
    'klen/nvim-config-local',
    opts = {
      -- Lookup config files in parent directories
      lookup_parents = true,

      silent = true,
    }
  },

  -- nvim integration for bacon (background Rust code checker)
  'Canop/nvim-bacon',
}
