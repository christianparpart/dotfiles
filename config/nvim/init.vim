set nocompatible

call plug#begin('~/.vim/plugged')
Plug 'tomasr/molokai'
Plug 'yggdroot/indentline'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'ycm-core/YouCompleteMe'
Plug 'vim-airline/vim-airline'
"Plug 'fsharp/vim-fsharp', {'for': 'fsharp', 'do': 'make fsautocomplete'}
Plug 'fsharp/vim-fsharp'
Plug 'davidhalter/jedi-vim'
Plug 'ctrlpvim/ctrlp.vim' " fuzzy find files
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tomtom/tcomment_vim'
Plug 'ericcurtin/CurtineIncSw.vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'ryanoasis/vim-devicons' " XXX must be last plugin to be loaded
call plug#end()

set termguicolors

" Molokai (Monokai) color scheme
let g:molokai_original = 1
let g:rehash256 = 1
colorscheme molokai

"filetype indent on
filetype plugin on

syntax on
set noswapfile
set mouse=a
set backspace=indent,eol,start
set modelines=5
set modeline
set laststatus=2
"set statusline=%f\ %l:%c\ [offset:\ %{line2byte(line('.'))-1+col('.')-1}]\ hex:\ 0x%02B
set colorcolumn=110
set textwidth=100
set wrapmargin=0
set formatoptions=cqt "tcron
set nowrap
set encoding=utf-8
set foldenable
set fdm=marker
set scrolloff=8
set sidescrolloff=15
set sidescroll=1
set nu
set rnu
set numberwidth=5
set tabstop=4
set shiftwidth=4
set noexpandtab
set smarttab
set cursorline
"set cursorcolumn
set autoindent
set smartindent
set cindent
set hlsearch
set incsearch
set ignorecase
set smartcase
set autoread " automatically reload files upon change outside VIM

" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.nviminfo

set list
set listchars=tab:\|\ ,trail:·
"highlight NonText ctermbg=red ctermfg=white
"highlight SpecialKey ctermbg=red ctermfg=white

" spelling (en)
"set spell
"set spelllang=en
"set spellsuggest=9

" set <space> to toggle fold
nnoremap <space> za

" function shortcuts (command mode)
nmap <C-N> :NERDTreeToggle<enter>
nmap <C-L> :NERDTreeFocus<enter>
nmap <C-H> :noh<enter>

" tabbed windows (command mode)
nmap <S-H> :tabprev<enter>
nmap <S-L> :tabnext<enter>
nmap <S-T> :tabnew<enter>
nmap <S-C> :tabclose<enter>
nmap <A-L> :bn<enter>
nmap <A-H> :bp<enter>

let g:indentLine_char_list = ['|', '|', '|', '|']

" FSharp
au BufNewFile,BufRead *.fs set ts=4 sw=4 et

" Toggle between header/source files.
nnoremap <leader>fo :call CurtineIncSw()<CR>

" {{{ SetupEnvironment (tabstop, expandtab, ...)
au BufNewFile,BufRead Makefile set ts=4 sw=4 noet
au BufNewFile,BufRead *.sol set ts=4 sw=4 et
function! SetupEnvironment()
  let l:path = expand('%:p')
  if l:path =~ '/home/trapni/projects/contour'
    setlocal expandtab
    setlocal tabstop=4 shiftwidth=4
  elseif l:path =~ '/home/trapni/projects/klex'
    setlocal noexpandtab
    setlocal tabstop=4 shiftwidth=4
  elseif l:path =~ '/home/trapni/ethereum/solidity'
    setlocal noexpandtab
    setlocal tabstop=4 shiftwidth=4
    setlocal colorcolumn=99
  endif
endfunction
autocmd! BufReadPost,BufNewFile * call SetupEnvironment()
" }}}
" {{{ git (fugitive)
" nnoremap <leader>gs :Gstatus<CR>
" nnoremap <leader>gc :Gcommit -v -q<CR>
" nnoremap <leader>ga :Gcommit --amend<CR>
" nnoremap <leader>gt :Gcommit -v -q %<CR>
" nnoremap <leader>gd :Gdiff<CR>
" nnoremap <leader>ge :Gedit<CR>
" nnoremap <leader>gr :Gread<CR>
" nnoremap <leader>gw :Gwrite<CR><CR>
" nnoremap <leader>gl :silent! Glog<CR>
" nnoremap <leader>gp :Ggrep<Space>
" nnoremap <leader>gm :Gmove<Space>
" nnoremap <leader>gb :Git branch<Space>
" nnoremap <leader>go :Git checkout<Space>
" nnoremap <leader>gps :Dispatch! git push<CR>
" nnoremap <leader>gpl :Dispatch! git pull<CR>
" }}}
" {{{ CoC related
set cmdheight=2
set hidden
set updatetime=300
let g:coc_global_extensions = [
  \ 'coc-json',
  \ 'coc-pairs',
  \ 'coc-python',
  \ 'coc-snippets',
  \ 'coc-highlight',
  \ 'coc-fsharp',
  \ 'coc-texlab'
  \ ]

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

nn <silent> K :call CocActionAsync('doHover')<cr>
nmap <silent> <Leader>gn :call CocActionAsync('rename')<cr>
nmap <silent> <Leader>gd <Plug>(coc-definition)
nmap <silent> <Leader>gy <Plug>(coc-type-definition)
nmap <silent> <Leader>gi <Plug>(coc-implementation)
nmap <silent> <Leader>gr <Plug>(coc-references)
nmap <silent> <Leader>cn <Plug>(coc-diagnostic-next)
nmap <silent> <Leader>cp <Plug>(coc-diagnostic-prev)

au CursorHold * sil call CocActionAsync('highlight')
au CursorHoldI * sil call CocActionAsync('showSignatureHelp')
highlight CocErrorHighlight ctermfg=Red guibg=#ff0000
highlight CocHighlightText ctermbg=Blue guibg=#005599

autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

" extend statusline with CoC status
set statusline^=%{coc#status()})}
" }}}
" {{{ NERDTree
let NERDTreeIgnore = [ '\.o$', 'cmake_install.*', 'CMakeFiles', 'CMakeCache.*', 'build' ]

" sync open file with NERDTree
" " Check if NERDTree is open or active
function! IsNERDTreeOpen()        
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! SyncTree()
  if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction

" Highlight currently open buffer in NERDTree
autocmd BufEnter * call SyncTree()

" open NERDTree when no file is to be opened at sratup
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" }}}
