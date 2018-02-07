set nocompatible
set noswapfile

syntax on

set backspace=indent,eol,start

set laststatus=2
set statusline=%f\ %l:%c\ [offset:\ %{line2byte(line('.'))-1+col('.')-1}]\ hex:\ 0x%02B

set colorcolumn=81
set textwidth=80
set wrapmargin=0
set formatoptions=cqt "tcron

call pathogen#infect()

set encoding=utf-8

au BufNewFile,BufRead *.md set syntax=markdown
au BufNewFile,BufRead *.coffee set syntax=coffee
au BufNewFile,BufRead nginx.conf set syntax=nginx

"colorscheme trapni
"colorscheme CodeFactoryv3
"colorscheme 256-jungle
"colorscheme 256-grayvim
"colorscheme 3dglasses

colorscheme Monokai
colorscheme Benokai " overrides some stuff (types!)

set nowrap

" indention/tabstop/shiftwidth
set tabstop=2
set shiftwidth=2
set expandtab
"set ai
"set smartindent

"filetype indent on
filetype plugin on

" enable folding
set foldenable
"set fdm=indent
set fdm=marker
"set fdm=syntax

" set <space> to toggle fold
nnoremap <space> za

" function shortcuts (command mode)
nmap <F2>  :w<enter>
nmap <F3> :NERDTreeToggle<enter>
nmap <F4> :NERDTreeFind<enter>
nmap <C-L> :NERDTreeFind<enter>
nmap <F9> :q<enter>
"nmap <C-J> :0read ~/.vim.header<enter>:3<enter>$a
nmap <C-J> :0read ~/.vim.header<enter>
nmap <C-H> :noh<enter>
nmap <F5> :bp<enter>
nmap <F6> :bn<enter>
nmap <F8> :mak<enter>

" tabbed windows (command mode)
nmap <S-H> :tabprev<enter>
nmap <S-L> :tabnext<enter>
nmap <S-T> :tabnew<enter>
nmap <S-C> :tabclose<enter>

nmap <F12> :!make<enter>

" function shortcuts (insert mode)
imap <F2>  <ESC>:w<enter>a
imap <F10> <ESC>:q<enter>

imap <S-Up> <ESC>v

" search (incremental, case insensitive except explicit caps)
set incsearch
"set ignorecase
set smartcase

" we're on big screens, and I need a vertical scroll offset for better
" readability
set scrolloff=8
set sidescrolloff=15
set sidescroll=1

" line numbering to take up to 5 spaces
set nu
set numberwidth=5

" spelling (en)
"set spell
"set spelllang=en
"set spellsuggest=9

set modelines=5
set modeline

set ai
set si
set cindent

" enable current cursor line/column highlighting
set cursorline
"set cursorcolumn

set hlsearch

" C++11 syntax highlighting fix (lambdas and initializers)
let c_no_curly_error=1

" ruby-debugger
let g:ruby_debugger_default_script = 'script/rails s'

" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo

let NERDTreeIgnore = [ '\.o$', '\.so.*', 'cmake_install.*', 'CMakeFiles', 'CMakeCache.*' ]

"set list
"set listchars=tab:――,trail:·
"highlight NonText ctermbg=red ctermfg=white
"highlight SpecialKey ctermbg=red ctermfg=white

" fuzzyfinder shortcuts (command mode)
"(buggy)nmap <C-L> :FufCoverageFile<CR>

au BufNewFile,BufRead Jenkinsfile set filetype=groovy
au BufNewFile,BufRead Makefile set ts=4 sw=4
au BufNewFile,BufRead *.sls setf jinja

" {{{ realtime auto completion (neocomplete)
let g:neocomplete#enable_at_startup = 1
" }}}
" {{{ git (fugitive)
nmap <C-G> :Gstatus<enter>
nmap <C-B> :Gblame<enter>
nmap <C-F> :Ggrep<Space>

nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit -v -q<CR>
nnoremap <leader>ga :Gcommit --amend<CR>
nnoremap <leader>gt :Gcommit -v -q %<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>ge :Gedit<CR>
nnoremap <leader>gr :Gread<CR>
nnoremap <leader>gw :Gwrite<CR><CR>
nnoremap <leader>gl :silent! Glog<CR>
nnoremap <leader>gp :Ggrep<Space>
nnoremap <leader>gm :Gmove<Space>
nnoremap <leader>gb :Git branch<Space>
nnoremap <leader>go :Git checkout<Space>
nnoremap <leader>gps :Dispatch! git push<CR>
nnoremap <leader>gpl :Dispatch! git pull<CR>

" }}}
" {{{ LLVM IR
au BufNewFile,BufRead *.bc set filetype=llvm
au BufNewFile,BufRead *.ll set filetype=llvm
" }}}
" {{{ x0 / Flow
let flow_x0 = 1
au BufNewFile,BufRead *.flow setf flow
" }}}
" {{{ C/C++
au FileType c,cpp,objc set ts=2
au FileType c,cpp,objc set sw=2

" let g:clang_format#style_options = {
"             \ "AccessModifierOffset": -4,
"             \ "AllowShortIfStatementsOnASingleLine": "false",
"             \ "AlwaysBreakTemplateDeclarations": "true",
"             \ "Standard": "C++11" }

" map to <Leader>cf in C++ code
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
" if you install vim-operator-user
autocmd FileType c,cpp,objc map <buffer><Leader>x <Plug>(operator-clang-format)
" Toggle auto formatting:
nmap <Leader>C :ClangFormatAutoToggle<CR>
" }}}
" {{{ Go language (vim-go)
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)
au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
au FileType go nmap <Leader>gb <Plug>(go-doc-browser)
au FileType go nmap <Leader>s <Plug>(go-implements)
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>e <Plug>(go-rename)
" }}}
" {{{ FuzzyFinder
"nmap <silent> <C-O> :FufFile<CR>
nmap <silent> <C-T> {:call fuf#setOneTimeVariables(['g:fuf_coveragefile_globPatterns', ['**/*.h', '**/*.cc', '**/*.cpp', '**/.md', '**/*.ac', '**/*.am', '**/*.pc.in', '**/*.conf', '**/*.jinja', '**/*.sls']]) \| FufCoverageFile<CR>}
nmap <Leader>fr :FufRenewCache<CR>
" }}}
