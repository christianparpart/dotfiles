set nocompatible
" vim:et:ts=4:sw=4

" ----------------------------------------------------------------------------------------
call plug#begin('~/.vim/plugged')

""" colorschemes
"Plug 'tomasr/molokai'
"Plug 'chriskempson/base16-vim'
"Plug 'NLKNguyen/papercolor-theme'
"Plug 'rafalbromirski/vim-aurora'
Plug 'morhetz/gruvbox'
Plug 'lifepillar/vim-gruvbox8'

""" bottom/top status/tab line
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
"Plug 'hardcoreplayers/spaceline.vim'
Plug 'glepnir/spaceline.vim'

""" productivity
Plug 'yggdroot/indentline'                              " visualize indentation levels
Plug 'tpope/vim-fugitive'                               " git in vim
Plug 'tomtom/tcomment_vim'                              " toggle comments using `gc`
Plug 'ericcurtin/CurtineIncSw.vim'                      " toggle between header/implementation files
Plug 'editorconfig/editorconfig-vim'                    " auto-load .editorconfig files
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }     " Fuzzy finder
Plug 'junegunn/fzf.vim'
"Plug '~/.fzf'

Plug 'neoclide/coc.nvim', {'branch': 'release'}         " LSP plugin
Plug 'puremourning/vimspector'                          " advanced debugging

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

"Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update

"Plug 'davidhalter/jedi-vim'                            " Python
Plug 'tomlion/vim-solidity'                             " Solidity
"Plug 'jrozner/vim-antlr'                               " ANTLR
Plug 'tikhomirov/vim-glsl'                             " OpenGL shading language (GLSL)
"Plug 'fsharp/vim-fsharp'                               " F#
"Plug 'fsharp/vim-fsharp', {'for': 'fsharp', 'do': 'make fsautocomplete'}
Plug 'PProvost/vim-ps1'

""" file manager on the left side
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'unkiwii/vim-nerdtree-sync'

""" Dart/Flutter
" Plug 'dart-lang/dart-vim-plugin'
" Plug 'thosakwe/vim-flutter'
" Plug 'natebosch/vim-lsc'
" Plug 'natebosch/vim-lsc-dart'

" XXX This must be the last plugin to be loaded!
Plug 'ryanoasis/vim-devicons'
call plug#end()
" ----------------------------------------------------------------------------------------

" Do not hide anything.
set conceallevel=0

" vim-lsc (&dart/flutter) related
set shortmess-=F
"let g:lsc_server_commands = {'dart': 'dart_language_server'}
"let g:flutter_command = "/snap/bin/flutter"

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
set colorcolumn=80 " 110
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
"set ignorecase
"set smartcase
set autoread " automatically reload files upon change outside VIM
set termguicolors

""" {{{ lsc dart/flutter
" Use all the defaults (recommended):
let g:lsc_auto_map = v:true

" Apply the defaults with a few overrides:
let g:lsc_auto_map = {'defaults': v:true, 'FindReferences': '<leader>r'}

" Setting a value to a blank string leaves that command unmapped:
let g:lsc_auto_map = {'defaults': v:true, 'FindImplementations': ''}

" ... or set only the commands you want mapped without defaults.
" Complete default mappings are:
let g:lsc_auto_map = {
    \ 'GoToDefinition': '<C-]>',
    \ 'GoToDefinitionSplit': ['<C-W>]', '<C-W><C-]>'],
    \ 'FindReferences': 'gr',
    \ 'NextReference': '<C-n>',
    \ 'PreviousReference': '<C-p>',
    \ 'FindImplementations': 'gI',
    \ 'FindCodeActions': 'ga',
    \ 'Rename': 'gR',
    \ 'ShowHover': v:true,
    \ 'DocumentSymbol': 'go',
    \ 'WorkspaceSymbol': 'gS',
    \ 'SignatureHelp': 'gm',
    \ 'Completion': 'completefunc',
    \}
""" }}}
" {{{ macros
" apply macro stored in q
nmap <silent> <Space> @q
" }}}
" {{{ spaceline tweaks
"let g:spaceline_seperate_style = 'arrow'
"let g:spaceline_seperate_style = 'curve'
" }}}
" {{{ Airline tweaks
let g:airline_theme='gruvbox'
let g:airline_statusline_ontop = 1
let g:airline_powerline_fonts = 1
" let g:airline#extensions#tabline#left_sep = ' '
" let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#enabled = 1            " show tabs or all buffers if only one tab open
let g:airline_section_z = 'U+%04B'                      " show current character symbol in hex

" maybe this one can be removed again once I've got a better -more crisp- monitor.
" this line helps me better seeing airline's top bar
let g:airline_theme = "bubblegum"
" airline_tabfill xxx ctermfg=7 ctermbg=18
" }}}
" {{{ colorscheme
let g:gruvbox_filetype_hi_groups = 1    " Set to 1 to include syntax highlighting definitions for several filetypes.
let g:gruvbox_plugin_hi_groups = 1      " Set to 1 to include syntax highlighting definitions for a number of popular plugins
"let g:gruvbox_transp_bg = 1             " gransparent background
set background=dark                     " required to ensure it's using the dark theme
colorscheme gruvbox8_hard
"colorscheme gruvbox

" disable background
"hi Normal guibg=NONE ctermbg=NONE
" }}}
" {{{ fzf customization
" Always enable preview window on the right with 60% width
let g:fzf_preview_window = 'right:60%'
let $FZF_DEFAULT_OPTS='--reverse'

function! s:my_fzf_handler(lines) abort
  if empty(a:lines)
    return
  endif
  let cmd = get({ 'ctrl-t': 'tabedit',
                \ 'ctrl-x': 'split',
                \ 'ctrl-v': 'vsplit' }, remove(a:lines, 0), 'e')
  for item in a:lines
    execute cmd escape(item, ' %#\')
  endfor
endfunction

nnoremap <silent> <C-P> :call fzf#run({
  \ 'source': 'git ls-files',
  \ 'options': '--expect=ctrl-t,ctrl-x,ctrl-v',
  \ 'window':  {'width': 0.9, 'height': 0.6},
  \ 'sink*':   function('<sid>my_fzf_handler')})<cr>

nnoremap <silent> <C-T> :call fzf#run({
  \ 'options': '--expect=ctrl-t,ctrl-x,ctrl-v',
  \ 'window':  {'width': 0.9, 'height': 0.6},
  \ 'sink*':   function('<sid>my_fzf_handler')})<cr>

" TODO: try ripgrep here
" command! -bang -nargs=* GGrep
"   \ call fzf#vim#grep(
"   \   'git grep --line-number -- '.shellescape(<q-args>), 0,
"   \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

"nmap <silent> <C-T> :FZF<enter>
"nmap <silent> <C-P> :call fzf#run({'source': 'git ls-files', 'sink': 'e', 'window': {'width': 0.9, 'height': 0.6}})<cr>
nmap <silent> <leader>ff :Buffers<cr>
nmap <silent> <leader>fg :Rg<cr>
nmap <silent> <leader>fm :Marks<cr>
nmap <silent> <leader>fl :BLines<cr>
nmap <silent> <leader>fc :BCommits<cr>
nmap <silent> <C-Space> :Commands<cr>
" }}}

" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "1000 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
"set viminfo='10,\"1000,:20,%,n~/.nviminfo

set list
set listchars=tab:\|\ ,trail:·
highlight NonText ctermbg=red ctermfg=white
highlight SpecialKey ctermbg=red ctermfg=white

" spelling (en)
"set spell
"set spelllang=en
"set spellsuggest=9

" set <space> to toggle fold
nnoremap <S-F> za

" function shortcuts (command mode)
nmap <C-]> :noh<enter>
"
nmap <C-N> :NERDTreeToggle<enter>
""nmap <C-T> :NERDTreeFocus<enter>

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

vnoremap <Leader>dp :diffput<CR>

" vertical diff'ing (see Gdiffsplit)
set diffopt+=vertical

" {{{ Telescope
" Find files using Telescope command-line sugar.
nnoremap <leader>tc <cmd>Telescope command_history<cr>
nnoremap <leader>tt <cmd>Telescope commands<cr>
nnoremap <leader>tf <cmd>Telescope find_files<cr>
nnoremap <leader>tg <cmd>Telescope live_grep<cr>
nnoremap <leader>tb <cmd>Telescope buffers<cr>
nnoremap <leader>th <cmd>Telescope help_tags<cr>
nnoremap <leader>tr <cmd>Telescope file_browser<cr>
nnoremap <leader>tm <cmd>Telescope marks<cr>
nnoremap <leader>tp <cmd>Telescope man_pages<cr>
nnoremap <leader>tq <cmd>Telescope quickfix<cr>
nnoremap <Leader>td :lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({}))<cr>

" }}}

" {{{ TreeSitter
" lua <<EOF
" require'nvim-treesitter.configs'.setup {
"   ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
"   highlight = {
"     enable = true,              -- false will disable the whole extension
"     disable = { "c", "rust" },  -- list of language that will be disabled
"   },
" }
" EOF
" }}}
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit -v -q<CR>
nnoremap <leader>ga :Gcommit --amend<CR>
" nnoremap <leader>gt :Gcommit -v -q %<CR>
nnoremap <leader>gd :Gvdiffsplit<CR>
vnoremap <leader>ga :diffput<CR>
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
  \ 'coc-flutter',
  \ 'coc-pairs',
  \ 'coc-python',
  \ 'coc-snippets',
  \ 'coc-highlight',
  \ 'coc-vimlsp',
  \ 'coc-fsharp',
  \ 'coc-json',
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

nn <silent> I :call CocActionAsync('doHover')<cr>
nmap <silent> <Leader>cm :call CocActionAsync<cr>
nmap <silent> <leader>cf <Plug>(coc-fix-current)
nmap <silent> <Leader>cd <Plug>(coc-definition)
nmap <silent> <Leader>cy <Plug>(coc-type-definition)
nmap <silent> <Leader>ci <Plug>(coc-implementation)
nmap <silent> <Leader>cr <Plug>(coc-references)
nmap <silent> <Leader>cn <Plug>(coc-diagnostic-next)
nmap <silent> <Leader>cp <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>cm <Plug>(coc-rename)

nmap <silent> <Leader>gp :GFiles<CR>

" show logging output in a vsplit view
nmap <silent> <Leader>co :CocCommand workspace.showOutput<cr>

au CursorHold * sil call CocActionAsync('highlight')
au CursorHoldI * sil call CocActionAsync('showSignatureHelp')
highlight CocErrorHighlight ctermfg=Red guibg=#ff0000
highlight CocHighlightText ctermbg=Blue guibg=#005599

autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

" extend statusline with CoC status
set statusline^=%{coc#status()})}

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
    " Recently vim can merge signcolumn and number column into one
    set signcolumn=number
else
    set signcolumn=yes
endif
" }}}
" {{{ NERDTree
let NERDTreeIgnore = [ '\.o$', 'cmake_install.*', 'CMakeFiles', 'CMakeCache.*', 'build' ]
let g:nerdtree_sync_cursorline = 1

" open NERDTree when no file is to be opened at sratup
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" }}}
" {{{ Debugging
" " open up debug windows in vertical split
" let g:termdebug_wide = 10
"
" packadd termdebug
"
" " open up debug windows in vertical split
" let g:termdebug_wide = 10
"
" nmap <C-F5>  :Stop <CR>
" nmap <F5>    :Continue <CR>
" nmap <F6>    :Run <CR>
" nmap <F9>    :Break <CR>
" nmap <F8>    :Clear <CR>
" nmap <F10>   :Over <CR>
" nmap <F11>   :Step <CR>
" nmap <F12>   :Finish <CR>
" nmap <S-F10> :Finish <CR>
"
" nmap <Leader>dr :Run <Cr>
" nmap <Leader>ds :Stop <Cr>
" nmap <Leader>dc :Continue <Cr>
"
" nmap <Leader>db :Break <Cr>
" nmap <Leader>dd :Clear <Cr>
"
" nmap <Leader>dn :Over <Cr>
" nmap <Leader>di :Step <Cr>
" nmap <Leader>df :Finish<Cr>

" XXX example debug command:
"      :Termdebug ./path/to/binary [parameters ...]
" }}}
" {{{ Vimspector
let g:vimspector_enable_mappings = 'HUMAN'
"let g:vimspector_enable_mappings = 'VISUAL_STUDIO'
packadd! vimspector
nmap <silent> <Leader>dR :VimspectorReset<cr>
" }}}
" {{{ Quickfix window navigation (qn = next, qp = prev)
nmap <silent> <Leader>qn :cn<CR>
nmap <silent> <Leader>qp :cp<CR>
" }}}

augroup personal
  au!
  autocmd BufNewFile,BufRead *.terminfo set syntax=terminfo
augroup END

"set bg=light
