set nocompatible

set laststatus=2
set statusline=%f\ %l:%c\ [offset:\ %{line2byte(line('.'))-1+col('.')-1}]\ hex:\ 0x%02B

call pathogen#infect() 

set encoding=utf-8

" flow and x0
let flow_x0 = 1
au BufNewFile,BufRead *.flow		setf flow

augroup filetype
  " LLVM IR
  au BufNewFile,BufRead *.bc        set filetype=llvm
  au BufNewFile,BufRead *.ll        set filetype=llvm
augroup END


" CMake 
au BufNewFile,BufRead CMakeLists.txt set et
au BufNewFile,BufRead CMakeLists.txt set ts=2
au BufNewFile,BufRead CMakeLists.txt set sw=2

" Scala
au BufNewFile,BufRead *.scala		set et
au BufNewFile,BufRead *.scala		set ts=2
au BufNewFile,BufRead *.scala		set sw=2

" POD documentation
au BufNewFile,BufRead *.pod			set et
au BufNewFile,BufRead *.pod			set ts=2
au BufNewFile,BufRead *.pod			set sw=2

" ruby and rails
au BufNewFile,BufRead *.yml			set et
au BufNewFile,BufRead *.yml			set ts=2
au BufNewFile,BufRead *.yml			set sw=2
au BufNewFile,BufRead *.erb			set et
au BufNewFile,BufRead *.erb			set ts=2
au BufNewFile,BufRead *.erb			set sw=2
au BufNewFile,BufRead *.rb			set et
au BufNewFile,BufRead *.rb			set ts=2
au BufNewFile,BufRead *.rb			set sw=2

au BufNewFile,BufRead *.md			set syntax=markdown
au BufNewFile,BufRead *.md			set et
au BufNewFile,BufRead *.md			set ts=2
au BufNewFile,BufRead *.md			set sw=2

" puppet
au BufNewFile,BufRead *.pp			set et
au BufNewFile,BufRead *.pp			set ts=2
au BufNewFile,BufRead *.pp			set sw=2

" CoffeScript
au BufNewFile,BufRead *.coffee		set et
au BufNewFile,BufRead *.coffee		set ts=2
au BufNewFile,BufRead *.coffee		set sw=2
au BufNewFile,BufRead *.coffee		set syntax=coffee

au BufNewFile,BufRead *.rs		    set et
au BufNewFile,BufRead *.rs		    set ts=2
au BufNewFile,BufRead *.rs		    set sw=2

colorscheme trapni

set nowrap

" indention/tabstop/shiftwidth
set tabstop=4
set shiftwidth=4
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

" fugitive
nmap <C-G> :Gstatus<enter>

" fuzzyfinder shortcuts (command mode)
"(buggy)nmap <C-L> :FufCoverageFile<CR>
nmap <C-T> :FufFile<CR>

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

" enable current cursor line highlighting
"set cursorline

" spelling (en)
"set spell
"set spelllang=en
"set spellsuggest=9

set modelines=5
set modeline

set ai
set si
set cindent

set cursorline

set hlsearch

" C++11 syntax highlighting fix (lambdas and initializers)
let c_no_curly_error=1

" ruby-debugger
let g:ruby_debugger_default_script = 'script/rails s'

" Clang code-completion support. This is somewhat experimental!

" A path to a clang executable.
let g:clang_path = "clang++"

" A list of options to add to the clang commandline, for example to add
" include paths, predefined macros, and language options.
let g:clang_opts = [
  \ "-x","c++",
  \ "-D__STDC_LIMIT_MACROS=1","-D__STDC_CONSTANT_MACROS=1",
  \ "-Iinclude" ]

function! ClangComplete(findstart, base)
   if a:findstart == 1
      " In findstart mode, look for the beginning of the current identifier.
      let l:line = getline('.')
      let l:start = col('.') - 1
      while l:start > 0 && l:line[l:start - 1] =~ '\i'
         let l:start -= 1
      endwhile
      return l:start
   endif

   " Get the current line and column numbers.
   let l:l = line('.')
   let l:c = col('.')

   " Build a clang commandline to do code completion on stdin.
   let l:the_command = shellescape(g:clang_path) .
                     \ " -cc1 -code-completion-at=-:" . l:l . ":" . l:c
   for l:opt in g:clang_opts
      let l:the_command .= " " . shellescape(l:opt)
   endfor

   " Copy the contents of the current buffer into a string for stdin.
   " TODO: The extra space at the end is for working around clang's
   " apparent inability to do code completion at the very end of the
   " input.
   " TODO: Is it better to feed clang the entire file instead of truncating
   " it at the current line?
   let l:process_input = join(getline(1, l:l), "\n") . " "

   " Run it!
   let l:input_lines = split(system(l:the_command, l:process_input), "\n")

   " Parse the output.
   for l:input_line in l:input_lines
      " Vim's substring operator is annoyingly inconsistent with python's.
      if l:input_line[:11] == 'COMPLETION: '
         let l:value = l:input_line[12:]

        " Chop off anything after " : ", if present, and move it to the menu.
        let l:menu = ""
        let l:spacecolonspace = stridx(l:value, " : ")
        if l:spacecolonspace != -1
           let l:menu = l:value[l:spacecolonspace+3:]
           let l:value = l:value[:l:spacecolonspace-1]
        endif

        " Chop off " (Hidden)", if present, and move it to the menu.
        let l:hidden = stridx(l:value, " (Hidden)")
        if l:hidden != -1
           let l:menu .= " (Hidden)"
           let l:value = l:value[:l:hidden-1]
        endif

        " Handle "Pattern". TODO: Make clang less weird.
        if l:value == "Pattern"
           let l:value = l:menu
           let l:pound = stridx(l:value, "#")
           " Truncate the at the first [#, <#, or {#.
           if l:pound != -1
              let l:value = l:value[:l:pound-2]
           endif
        endif

         " Filter out results which don't match the base string.
         if a:base != ""
            if l:value[:strlen(a:base)-1] != a:base
               continue
            end
         endif

        " TODO: Don't dump the raw input into info, though it's nice for now.
        " TODO: The kind string?
        let l:item = {
          \ "word": l:value,
          \ "menu": l:menu,
          \ "info": l:input_line,
          \ "dup": 1 }

        " Report a result.
        if complete_add(l:item) == 0
           return []
        endif
        if complete_check()
           return []
        endif

      elseif l:input_line[:9] == "OVERLOAD: "
         " An overload candidate. Use a crazy hack to get vim to
         " display the results. TODO: Make this better.
         let l:value = l:input_line[10:]
         let l:item = {
           \ "word": " ",
           \ "menu": l:value,
           \ "info": l:input_line,
           \ "dup": 1}

        " Report a result.
        if complete_add(l:item) == 0
           return []
        endif
        if complete_check()
           return []
        endif

      endif
   endfor


   return []
endfunction ClangComplete

" This to enables the somewhat-experimental clang-based
" autocompletion support.
set omnifunc=ClangComplete
