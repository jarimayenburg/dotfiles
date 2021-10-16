----------------------------------
-- Plugins
----------------------------------

local M = {}

function M.setup()
  local cmd = vim.cmd

  cmd 'autocmd BufWritePost plugins.lua source <afile> | PackerCompile'

  return require('packer').startup(function(use)
    use 'nvim-treesitter/nvim-treesitter'
    use 'neovim/nvim-lspconfig'
    use 'folke/lsp-colors.nvim'
    use "lukas-reineke/indent-blankline.nvim"
    use 'mfussenegger/nvim-jdtls'
    use 'nvim-lua/completion-nvim'
    use 'morhetz/gruvbox'
    use 'tmhedberg/matchit'
    use 'airblade/vim-gitgutter'
    use 'itchyny/lightline.vim'
    use 'ap/vim-css-color'
    use 'tpope/vim-surround'
    use 'ledger/vim-ledger'
    use 'tpope/vim-fugitive'
    use 'mustache/vim-mustache-handlebars'
    use 'tpope/vim-commentary'
    use 'sheerun/vim-polyglot'
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use 'editorconfig/editorconfig-vim'
    use 'jiangmiao/auto-pairs'
    use 'weirongxu/plantuml-previewer.vim'
    use 'tyru/open-browser.vim'
    use {'kyazdani42/nvim-tree.lua', requires = 'kyazdani42/nvim-web-devicons'}
  end)
end

return M
