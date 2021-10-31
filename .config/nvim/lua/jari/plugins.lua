----------------------------------
-- Plugins
----------------------------------

local M = {}

function M.setup()
  local cmd = vim.cmd

  cmd 'autocmd BufWritePost plugins.lua source <afile> | PackerCompile'

  return require('packer').startup(function(use)
    use 'airblade/vim-gitgutter'
    use 'ap/vim-css-color'
    use 'editorconfig/editorconfig-vim'
    use 'folke/lsp-colors.nvim'
    use 'hoob3rt/lualine.nvim'
    use 'jiangmiao/auto-pairs'
    use 'kyazdani42/nvim-tree.lua'
    use 'kyazdani42/nvim-web-devicons'
    use 'ledger/vim-ledger'
    use 'lukas-reineke/indent-blankline.nvim'
    use 'mfussenegger/nvim-jdtls'
    use 'morhetz/gruvbox'
    use 'mustache/vim-mustache-handlebars'
    use 'neovim/nvim-lspconfig'
    use 'nvim-lua/completion-nvim'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-lua/popup.nvim'
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-treesitter/nvim-treesitter'
    use 'sheerun/vim-polyglot'
    use 'tmhedberg/matchit'
    use 'tpope/vim-commentary'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-surround'
    use 'tyru/open-browser.vim'
    use 'weirongxu/plantuml-previewer.vim'
    use {'nvim-telescope/telescope-fzy-native.nvim', run = 'make' }
  end)
end

return M
