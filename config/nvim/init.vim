set nocompatible

" ----------------------------------------------------------------------------------------
call plug#begin('~/.vim/plugged')

" colorschemes
Plug 'tomasr/molokai'
Plug 'morhetz/gruvbox'
Plug 'NLKNguyen/papercolor-theme'
Plug 'rafalbromirski/vim-aurora'

" bottom status/tab line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" productivity
Plug 'yggdroot/indentline'                             " visualize indentation levels
Plug 'tpope/vim-fugitive'
Plug 'ctrlpvim/ctrlp.vim' " fuzzy find files
Plug 'tomtom/tcomment_vim'
Plug 'ericcurtin/CurtineIncSw.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
"Plug 'junegunn/fzf.vim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'davidhalter/jedi-vim'
Plug 'tomlion/vim-solidity'
Plug 'jrozner/vim-antlr'
Plug 'tikhomirov/vim-glsl'
Plug 'fsharp/vim-fsharp'
"Plug 'fsharp/vim-fsharp', {'for': 'fsharp', 'do': 'make fsautocomplete'}

" file manager on the left side
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'unkiwii/vim-nerdtree-sync'

"Plug 'ryanoasis/vim-devicons' " XXX must be last plugin to be loaded
call plug#end()
" ----------------------------------------------------------------------------------------

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
set termguicolors

" Airline tweaks
"let g:airline_theme='gruvbox'
"let g:airline_statusline_ontop = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_section_z = 'HEX 0x%04B'

" Molokai (Monokai) color scheme
let g:rehash256 = 1
"let g:molokai_original = 1
"colorscheme molokai

let g:gruvbox_contrast_dark = 'hard'
colorscheme gruvbox

" Always enable preview window on the right with 60% width
let g:fzf_preview_window = 'right:60%'

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
nmap <C-T> :NERDTreeFocus<enter>
nmap <C-]> :noh<enter>

" tabbed windows (command mode)
nmap <S-T> :tabnew<enter>
nmap <S-H> :tabprev<enter>
nmap <S-L> :tabnext<enter>
nmap <S-C> :tabclose<enter>

" buffer management
nmap <C-H> :bp<enter>
nmap <C-L> :bn<enter>
nmap <C-K> :bd<enter>

let g:indentLine_char_list = ['|', '|', '|', '|']

" FSharp
au BufNewFile,BufRead *.fs set ts=4 sw=4 et

" Toggle between header/source files.
nnoremap <leader>fo :call CurtineIncSw()<CR>

" moving around buffers via Alt modifier
nmap <A-h> :wincmd h<enter>
nmap <A-j> :wincmd j<enter>
nmap <A-k> :wincmd k<enter>
nmap <A-l> :wincmd l<enter>

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
  elseif l:path =~ '/home/trapni/work/solidity'
    setlocal noexpandtab
    setlocal tabstop=4 shiftwidth=4
    setlocal colorcolumn=99
  elseif l:path =~ '/home/trapni/ethereum/solidity'
    setlocal noexpandtab
    setlocal tabstop=4 shiftwidth=4
    setlocal colorcolumn=99
  endif
endfunction
autocmd! BufReadPost,BufNewFile * call SetupEnvironment()
" }}}
" {{{ git (fugitive)
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit -v -q<CR>
nnoremap <leader>ga :Gcommit --amend<CR>
" nnoremap <leader>gt :Gcommit -v -q %<CR>
nnoremap <leader>gd :Gvdiffsplit<CR>
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
  \ 'coc-vimlsp',
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
nmap <silent> <Leader>cm :call CocActionAsync<cr>
nmap <silent> <leader>cf <Plug>(coc-fix-current)
nmap <silent> <Leader>cd <Plug>(coc-definition)
nmap <silent> <Leader>cy <Plug>(coc-type-definition)
nmap <silent> <Leader>ci <Plug>(coc-implementation)
nmap <silent> <Leader>cr <Plug>(coc-references)
nmap <silent> <Leader>cn <Plug>(coc-diagnostic-next)
nmap <silent> <Leader>cp <Plug>(coc-diagnostic-prev)

" show logging output in a vsplit view
nmap <silent> <Leader>co :CocCommand workspace.showOutput<cr>

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
let g:nerdtree_sync_cursorline = 1

" open NERDTree when no file is to be opened at sratup
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" }}}
" {{{ Debugging
packadd termdebug

" open up debug windows in vertical split
let g:termdebug_wide = 10


nmap <C-F5>  :Stop <CR>
nmap <F5>    :Run <CR>
nmap <F6>    :Continue <CR>
nmap <F9>    :Break <CR>
nmap <F8>    :Clear <CR>
nmap <F10>   :Over <CR>
nmap <F11>   :Step <CR>
nmap <F12>   :Finish <CR>
nmap <S-F10> :Finish <CR>

nmap <Leader>dr :Run <Cr>
nmap <Leader>ds :Stop <Cr>
nmap <Leader>dc :Continue <Cr>

nmap <Leader>db :Break <Cr>
nmap <Leader>dd :Clear <Cr>

nmap <Leader>dn :Over <Cr>
nmap <Leader>di :Step <Cr>
nmap <Leader>df :Finish<Cr>

" XXX example debug command:
"      :Termdebug ./path/to/binary [parameters ...]
" }}}

