" My personal vimrc file

" Plugins
call plug#begin()

" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'junegunn/fzf'
" Plug 'junegunn/fzf.vim'
Plug 'neovim/nvim-lspconfig'
Plug 'tomcur/completion-nvim', {'branch': 'fix-floating-focus'}
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
Plug 'mustache/vim-mustache-handlebars'
Plug 'tpope/vim-commentary'
Plug 'sheerun/vim-polyglot'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'editorconfig/editorconfig-vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'jiangmiao/auto-pairs'

call plug#end()

" ==== Lua modules ====
lua require("jari")

" ==== Basic settings ====
syntax on
filetype plugin indent on
set incsearch cindent nocompatible number relativenumber

" Spaces instead of tabs
set tabstop=4 shiftwidth=4 expandtab

" Decrease updatetime to 50ms for better user experience
set updatetime=50

" Hide buffers instead of closing them. Prevents the "E37 No write since last
" change error"
set hidden

" True colors
set t_8f=\[[38;2;%lu;%lu;%lum
set t_8b=\[[48;2;%lu;%lu;%lum
set termguicolors

" Set the colorscheme
colorscheme gruvbox

" More natural split opening. Opens splits to the right/bottom, instead of to
" the left
set splitbelow
set splitright

" Transparency
highlight Normal ctermbg=none guibg=none
highlight NonText ctermbg=none guibg=none

" ==== General mappings ====
nnoremap <Leader><space> :noh<cr>
nnoremap <C-n> :NERDTreeToggle<cr>

" Remap the window switching keys
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" YAML indentation
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" Copy paste stuff
nnoremap <leader>p "+p
vnoremap <leader>p "_dP
nnoremap <leader>y "+y
vnoremap <leader>y "+y

" Delete without putting in register
nnoremap <leader>d "_g
vnoremap <leader>d "_g

" Quickfix list navigation
nnoremap <leader>j :cnext<cr>
nnoremap <leader>k :cp<cr>

" Visual selection base64 encoding/decoding
vnoremap <leader>64d c<c-r>=system('base64 --decode', @")<cr><esc>
vnoremap <leader>64e c<c-r>=system('base64', @")<cr><esc>

" ==== autocmd's ====

" YAML-files
autocmd FileType yaml setlocal ts=2 sw=2 sts=2 expandtab indentkeys-=0# indentkeys-=<:>

" ==== Telescope ====
nnoremap <leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
nnoremap <C-p> :lua require('telescope.builtin').git_files()<CR>
nnoremap <Leader>pf :lua require('telescope.builtin').find_files()<CR>

nnoremap <leader>pw :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>
nnoremap <leader>pb :lua require('telescope.builtin').buffers()<CR>
nnoremap <leader>vh :lua require('telescope.builtin').help_tags()<CR>

" ==== NVIM LSP ====

" Auto completion configuration
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

set completeopt=menuone,noinsert,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

" Enable keybindings and completion
lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys 
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<super>k', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "pyright", "rust_analyzer", "tsserver" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end

require'lspconfig'.pyright.setup{
    on_attach = on_attach
}

require'lspconfig'.java_language_server.setup{
    cmd = {"/home/jari/Programs/java-language-server/dist/lang_server_linux.sh"},
    on_attach = on_attach
}
EOF

" Enable autocompletion for all buffers
autocmd BufEnter * lua require'completion'.on_attach()

" ==== COC ====

" " Don't pass messages to |ins-completion-menu|
" set shortmess+=c

" " Use <Tab> to trigger autocomplete
" inoremap <silent><expr> <Tab>
"     \ pumvisible() ? "\<C-n>" :
"     \ <SID>check_back_space() ? "\<Tab>" :
"     \ coc#refresh()

" function! s:check_back_space() abort
"     let col = col('.') - 1
"     return !col || getline('.')[col - 1] =~ '\s'
" endfunction

" " Use <c-space> to trigger completion
" inoremap <silent><expr> <c-space> coc#refresh()

" " Make <CR> \uto-select the first completion item and notify coc.nvim to
" " format on enter, <cr> could be remapped by other vim plugin
" inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
"                               \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" " Use K to show documentation in preview window
" nnoremap <silent> K :call <SID>show_documentation()<CR>

" function! s:show_documentation()
"     if (index(['vim', 'help'], &filetype) >= 0)
"         execute 'h '.expand('<cword>')
"     else
"         call CocActionAsync('doHover')
"     endif
" endfunction

" " Highlight the symbol and its references when holding the cursor.
" autocmd CursorHold * silent call CocActionAsync('highlight')

" " Use `[g` and `]g` to navigate diagnostics
" " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
" nmap <silent>[g <Plug>(coc-diagnostic-next)
" nmap <silent>]g <Plug>(coc-diagnostic-prev)

" " Symbol renaming
" nmap <leader>rn <Plug>(coc-rename)

" " Formatting selected code.
" xmap <leader>f <Plug>(coc-format-selected)
" nmap <leader>f <Plug>(coc-format-selected)

" " Applying codeAction to the selected region.
" " Example: `<leader>aap` for current paragraph
" xmap <leader>a  <Plug>(coc-codeaction-selected)
" nmap <leader>a  <Plug>(coc-codeaction-selected)

" " Remap keys for applying codeAction to the current buffer.
" nmap <leader>ac  <Plug>(coc-codeaction)
" " Apply autofix (quickfix)
" nmap <leader>qf <Plug>(coc-fix-current)

" " Add NeoVim's native statusline support.
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" " Use auocmd to force lightline update.
" autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

" " GoTo code navigation.
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)

" " Mappings for CoCList
" " Show all diagnostics.
" nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" " Manage extensions.
" nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" " Show commands.
" nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" " Find symbol of current document.
" nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" " Search workspace symbols.
" nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" " Do default action for next item.
" nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" " Do default action for previous item.
" nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" " Resume latest coc list.
" nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

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

" ==== VimWiki ====

let g:vimwiki_list = [{'path': '~/Notes/src', 'path_html': '~/Notes/build', 'syntax': 'markdown', 'ext': '.md'}]

" ==== Treesitter ====

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
  },
}
EOF
