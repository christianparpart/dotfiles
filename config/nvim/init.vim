set nocompatible
" vim:et:ts=4:sw=4

let g:coc_default_semantic_highlight_groups = 1

" BOOTSTRAP NOTES:
"     pip install cmake-language-server

call plug#begin('~/.vim/plugged') " {{{ 

Plug 'morhetz/gruvbox'                      " colorschemes
Plug 'lifepillar/vim-gruvbox8'
Plug 'mkarmona/materialbox'
Plug 'sainnhe/sonokai'
Plug 'joshdick/onedark.vim'
Plug 'glepnir/spaceline.vim'                " bottom/top status/tab line

""" productivity
Plug 'machakann/vim-highlightedyank'                    " shortly highlights what was yanked
Plug 'yggdroot/indentline'                              " visualize indentation levels
Plug 'tpope/vim-fugitive'                               " git in vim
Plug 'tomtom/tcomment_vim'                              " toggle comments using `gc`
Plug 'editorconfig/editorconfig-vim'                    " auto-load .editorconfig files
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }     " Fuzzy finder
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}         " LSP plugin
Plug 'puremourning/vimspector'                          " advanced debugging
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'tikhomirov/vim-glsl'              " OpenGL shading language (GLSL)
Plug 'PProvost/vim-ps1'                 " PowerShell
Plug 'scrooloose/nerdtree'              " file manager on the left side
Plug 'Xuyuanp/nerdtree-git-plugin'      " -> Extending with git functionas
Plug 'unkiwii/vim-nerdtree-sync'        " -> keep tree in sync with document

""" Dart/Flutter
" Plug 'dart-lang/dart-vim-plugin'
" Plug 'thosakwe/vim-flutter'
" Plug 'natebosch/vim-lsc'
" Plug 'natebosch/vim-lsc-dart'

Plug 'ryanoasis/vim-devicons'           " XXX This must be the last plugin to be loaded!
call plug#end()
" }}}

" Do not hide anything.
set conceallevel=0

filetype plugin on

syntax on

set autoindent
set autoread                    " automatically reload files upon change outside VIM
set backspace=indent,eol,start
set cindent
set colorcolumn=80 " 110
set cursorline
set diffopt+=vertical           " vertical diff'ing (see Gdiffsplit)
set encoding=utf-8
set fdm=marker
set foldenable
set formatoptions=cqt "tcron
set hlsearch
set incsearch
set laststatus=2
set modeline
set modelines=5
set mouse=a
set noexpandtab
set noswapfile
set nowrap
set nu
set numberwidth=5
set rnu
set scrolloff=8
set shiftwidth=4
set sidescroll=1
set sidescrolloff=15
set smartindent
set smarttab
set tabstop=4
set termguicolors
set textwidth=100
set wrapmargin=0

" {{{ macros
" apply macro stored in q
nmap <silent> <Space> @q

nmap <silent> <C-Space> @@
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
" let g:airline#extensions#tabline#left_alt_sep = '│'
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
"colorscheme gruvbox8_hard
"colorscheme gruvbox
"colorscheme materialbox

" Sonokai colorscheme configuration
"let g:sonokai_transparent_background = 1
" let g:sonokai_enable_italic = 1
" let g:sonokai_style = 'shusia'
" colorscheme sonokai

let g:onedark_terminal_italics = 1
let g:onedark_hide_endofbuffer = 1
colorscheme onedark

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
"nmap <silent> <C-Space> :Commands<cr>
nmap <silent> <C-M> :Commands<cr>
nmap <silent> <leader>cc :Commands<cr>
" }}}

let g:indentLine_char_list = ['│', '│', '│', '│']
set list
set listchars=tab:\│\ ,trail:·
highlight NonText ctermbg=red ctermfg=white
highlight SpecialKey ctermbg=red ctermfg=white

" set <space> to toggle fold
nnoremap <A-f> za

" disable highlighting of last search
nmap <C-]> :noh<enter>

nmap <C-N> :NERDTreeToggle<enter>

" tabbed windows (command mode)
nmap <S-T> :tabnew<enter>
nmap <S-H> :tabprev<enter>
nmap <S-L> :tabnext<enter>
nmap <S-C> :tabclose<enter>

" buffer management
nmap <C-H> :bp<enter>
nmap <C-L> :bn<enter>
nmap <C-K> :bd<enter>

" moving around buffers via Alt modifier
nmap <A-h> :wincmd h<CR>
nmap ˙     :wincmd h<CR>

nmap <A-j> :wincmd j<CR>
nmap ∆     :wincmd j<CR>

nmap <A-k> :wincmd k<CR>
nmap ˚     :wincmd k<CR>

nmap <A-l> :wincmd l<CR>
nmap ¬     :wincmd l<CR>


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
if has('nvim')
    lua <<EOF
    require'nvim-treesitter.configs'.setup {
      ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
      highlight = {
        enable = true,              -- false will disable the whole extension
        disable = { "c", "cpp", "rust" },  -- list of language that will be disabled
      },
    }
EOF
endif
" }}}
" {{{ Git-fugitive 
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit -v -q<CR>
nnoremap <leader>ga :Gcommit --amend<CR>
" nnoremap <leader>gt :Gcommit -v -q %<CR>
nnoremap <leader>gd :Gvdiffsplit<CR>

" In diff view to stage a chunk
vnoremap <Leader>dp :diffput<CR>
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
set cmdheight=1
set hidden
set updatetime=50 " wanna be awesome (use 300 or 750 if the CPU won't make it, but 50 is awesome)
let g:coc_global_extensions = [
  \ 'coc-clangd',
  \ 'coc-flutter',
  \ 'coc-format-json',
  \ 'coc-fsharp',
  \ 'coc-highlight',
  \ 'coc-json',
  \ 'coc-pairs',
  \ 'coc-pyright',
  \ 'coc-snippets',
  \ 'coc-texlab',
  \ 'coc-vimlsp',
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

nmap <silent> <Leader>fo :CocCommand clangd.switchSourceHeader<cr>

highlight CocWarningHighlight gui=undercurl guisp=#FFFF00
highlight CocErrorHighlight   gui=undercurl guisp=#FF0000
highlight CocHighlightText    guibg=#005599
highlight Error               gui=undercurl guisp=#FF0000

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
let NERDTreeIgnore = [ '\.o$', 'cmake_install.*', 'CMakeFiles', 'CMakeCache.*' ]
let g:nerdtree_sync_cursorline = 1

" open NERDTree when no file is to be opened at sratup
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" }}}
" {{{ Vimspector
let g:vimspector_install_gadgets = [ 'debugpy', 'vscode-cpptools', 'CodeLLDB' ]
let g:vimspector_enable_mappings = 'HUMAN'
"let g:vimspector_enable_mappings = 'VISUAL_STUDIO'
"packadd! vimspector
nmap <silent> <Leader>dR :VimspectorReset<cr>
nmap <silent> <Leader>dp <Plug>VimspectorPause
nmap <silent> <Leader>dc <Plug>VimspectorContinue
nmap <silent> <Leader>dr <Plug>VimspectorRestart
nmap <silent> <Leader>dt <Plug>VimspectorRunToCursor
" Evaluate expression under cursor (or visual) in popup
nmap <silent> <Leader>de <Plug>VimspectorBalloonEval
" }}}
" {{{ Quickfix window navigation (qn = next, qp = prev)
nmap <silent> <Leader>qn :cn<CR>
nmap <silent> <Leader>qp :cp<CR>
" }}}

augroup mygroup
    " clear my personal config group
    au!

    " semantic word highlighting
    autocmd CursorHold * silent call CocActionAsync('highlight')

    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder silent call CocActionAsync('showSignatureHelp')
    "autocmd CursorHoldI * sil call CocActionAsync('showSignatureHelp')

    autocmd BufNewFile,BufRead *.terminfo set syntax=terminfo
    autocmd BufNewFile,BufRead *.sol set filetype=solidity

    nnoremap <leader>hi :%!xxd<CR>
    nnoremap <leader>ho :%!xxd -r<CR>

    " Auto-format JSON upon save.
    "autocmd FileType json autocmd BufWritePre <buffer> %!python -m json.tool 2>/dev/null || echo <buffer>

    autocmd FileType json nnoremap <Leader>ff :CocCommand formatJson<CR>
augroup end

"set bg=light
