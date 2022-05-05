----------------------------------
-- Plugins
----------------------------------

local M = {}

function M.setup()
  vim.api.nvim_exec(
    [[
    call plug#begin(stdpath('data') . '/plugged')
      Plug 'L3MON4D3/LuaSnip'
      Plug 'airblade/vim-gitgutter'
      Plug 'andreshazard/vim-freemarker'
      Plug 'ap/vim-css-color'
      Plug 'bazelbuild/vim-bazel'
      Plug 'editorconfig/editorconfig-vim'
      Plug 'folke/lsp-colors.nvim'
      Plug 'google/vim-maktaba'
      Plug 'hoob3rt/lualine.nvim'
      Plug 'hrsh7th/cmp-buffer'
      Plug 'hrsh7th/cmp-cmdline'
      Plug 'hrsh7th/cmp-nvim-lsp'
      Plug 'hrsh7th/cmp-path'
      Plug 'hrsh7th/nvim-cmp'
      Plug 'jiangmiao/auto-pairs'
      Plug 'kyazdani42/nvim-tree.lua'
      Plug 'kyazdani42/nvim-web-devicons'
      Plug 'ledger/vim-ledger'
      Plug 'lukas-reineke/indent-blankline.nvim'
      Plug 'mfussenegger/nvim-jdtls'
      Plug 'morhetz/gruvbox'
      Plug 'mustache/vim-mustache-handlebars'
      Plug 'neovim/nvim-lspconfig'
      Plug 'nvim-lua/completion-nvim'
      Plug 'nvim-lua/plenary.nvim'
      Plug 'nvim-lua/popup.nvim'
      Plug 'nvim-telescope/telescope-fzy-native.nvim', { 'run': 'make' }
      Plug 'nvim-telescope/telescope.nvim'
      Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
      Plug 'prettier/vim-prettier'
      Plug 'rafamadriz/friendly-snippets'
      Plug 'ray-x/lsp_signature.nvim'
      Plug 'sheerun/vim-polyglot'
      Plug 'tmhedberg/matchit'
      Plug 'towolf/vim-helm'
      Plug 'tpope/vim-commentary'
      Plug 'tpope/vim-fugitive'
      Plug 'tpope/vim-surround'
      Plug 'tyru/open-browser.vim'
      Plug 'vimwiki/vimwiki'
      Plug 'weirongxu/plantuml-previewer.vim'
    call plug#end()
    ]], false)
end

return M
