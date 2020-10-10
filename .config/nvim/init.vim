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
Plug 'preservim/nerdtree'
Plug 'ap/vim-css-color'
Plug 'tpope/vim-surround'
Plug 'ledger/vim-ledger'
Plug 'tpope/vim-fugitive'
"Plug 'Xuyuanp/nerdtree-git-plugin'

call plug#end()

" ==== Basic settings ====
syntax on
filetype plugin indent on
set incsearch cindent nocompatible number relativenumber

" Spaces instead of tabs
set tabstop=4 shiftwidth=4 expandtab

" Decrease updatetime to 100ms for better user experience
set updatetime=100

" More natural split opening. Opens splits to the right/bottom, instead of to
" the left
set splitbelow
set splitright

" Set the colorscheme
colorscheme gruvbox

" Transparency
highlight Normal ctermbg=none
highlight NonText ctermbg=none

" ==== General mappings ====
nnoremap <Leader><space> :noh<cr>
"nnoremap <C-p> :GFiles<cr>
nnoremap <C-P> :GFiles<cr>
nnoremap <C-n> :NERDTreeToggle<cr>

" Remap the window switching keys
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" ==== COC ====

" Don't pass messages to |ins-completion-menu|
set shortmess+=c

" Use <Tab> to trigger autocomplete
inoremap <silent><expr> <Tab>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<Tab>" :
    \ coc#refresh()

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~ '\s'
endfunction

" Use <c-space> to trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim', 'help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocActionAsync('doHover')
    endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)

" Add NeoVim's native statusline support.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Use auocmd to force lightline update.
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

" ==== Lightline ====

" Add COC status and Git branch to Lightline
let g:lightline = {
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'gitbranch', 'cocstatus', 'readonly', 'filename', 'modified' ] ]
  \ },
  \ 'component_function': {
  \   'gitbranch': 'FugitiveHead',
  \   'cocstatus': 'coc#status'
  \ },
\ }

" YAML-files
autocmd FileType yaml setlocal ts=2 sw=2 sts=2 expandtab indentkeys-=0# indentkeys-=<:>

" == Plugin configuration ==

" Configuration for VimWiki
let g:vimwiki_list = [{'path': '~/Notes/src', 'path_html': '~/Notes/build', 'syntax': 'markdown', 'ext': '.md'}]
