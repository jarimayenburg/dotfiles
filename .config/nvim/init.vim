" My personal vimrc file

" Plugins
call plug#begin()

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'vimwiki/vimwiki'
Plug 'morhetz/gruvbox'
Plug 'tmhedberg/matchit'
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdtree'
Plug 'ap/vim-css-color'
Plug 'tpope/vim-surround'
Plug 'ledger/vim-ledger'
"Plug 'Xuyuanp/nerdtree-git-plugin'

call plug#end()

" Some basic settings
syntax on
filetype plugin indent on
set incsearch cindent nocompatible number relativenumber

" Spaces instead of tabs
set tabstop=4 shiftwidth=4 expandtab

" More natural split opening. Opens splits to the right/bottom, instead of to
" the left
set splitbelow
set splitright

" Set the colorscheme
colorscheme gruvbox

" Transparency
highlight Normal ctermbg=none
highlight NonText ctermbg=none

" ==== Mappings ====
nnoremap <Leader><space> :noh<cr>
nnoremap <C-p> :GFiles<cr>
nnoremap <C-P> :Files<cr>
nnoremap <C-n> :NERDTreeToggle<cr>

" Remap the window switching keys
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Use <Tab> to trigger autocomplete
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<Tab>" :
    \ coc#refresh()

" YAML-files
autocmd FileType yaml setlocal ts=2 sw=2 sts=2 expandtab indentkeys-=0# indentkeys-=<:>

" == Plugin configuration ==

" Configuration for VimWiki
let g:vimwiki_list = [{'path': '~/Notes/src', 'path_html': '~/Notes/build', 'syntax': 'markdown', 'ext': '.md'}]
