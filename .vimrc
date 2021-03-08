call plug#begin('~/.vim/plugged')
" File browsing
Plug 'justinmk/vim-dirvish'
Plug 'tpope/vim-vinegar'

" Git
Plug 'tpope/vim-fugitive'

" Colors
Plug 'lifepillar/vim-solarized8'

" Fuzzy searching
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
" linting
Plug 'w0rp/ale'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-test/vim-test'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'mcfiredrill/vim-liquidsoap'
Plug 'mhinz/vim-grepper'
Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-surround'
call plug#end()

set mouse=a
set shortmess=I
set shiftwidth=2
set visualbell
set noerrorbells
set number
set noincsearch
"set synmaxcol=400                   " performance: don't highlight beyond 400 columns
"set colorcolumn=81                  " style: show the 81th line
set nowrap                          " never wrap text
set nobackup
set noswapfile
set wildignore+=node_modules
set splitright

syntax enable
set termguicolors
set background=dark
let g:solarized_contrast = "high"
let g:solarized_termtrans = 1
colorscheme solarized8

set statusline=%f\ \ %{fugitive#head()}
set shell=/bin/zsh

" Disable netrw
let loaded_netrwPlugin = 1
augroup my_dirvish_events
  autocmd FileType dirvish sort r /[^\/]$/
augroup END

let g:ale_lint_on_text_changed = 'never' " only lint files when i save
let g:ale_fix_on_save = 1
let g:ale_javascript_prettier_use_local_config = 1

let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

" autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')

nnoremap <C-p> :Files<CR>
nnoremap <C-k> :tabnext<CR>
nnoremap <C-j> :tabprevious<CR>
map <C-_> <Plug>NERDCommenterToggle
vmap <C-_>   <Plug>NERDCommenterToggle<CR>gv
" nnoremap <C-w> :tabclose<CR>

autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')
set clipboard=unnamed
if has("nvim") 
  set inccommand=nosplit
endif
au BufRead,BufNewFile *.liq set filetype=liquidsoap
let g:NERDCustomDelimiters = { 'liquidsoap':  { 'left': '#' } }

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

