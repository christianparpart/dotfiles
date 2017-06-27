" my 256-color VIM color scheme
" Maintainer:  Christian Parpart <trapni@gentoo.org>
" Last Change:  2012-07-20

hi clear

let colors_name = "trapni"

" Normal should come first
"hi Normal     ctermfg=Gray ctermbg=200 guifg=White guibg=Black
hi Normal     ctermfg=252 guifg=#d0d0d0 ctermbg=234 guibg=#1c1c1c cterm=none gui=none
hi Cursor     guifg=bg     guibg=fg
hi lCursor    guifg=NONE   guibg=Cyan

" active cursor-line
hi Cursorline cterm=NONE ctermbg=237

" Line numbering on the left side
hi LineNr     cterm=bold ctermfg=247 ctermbg=233 guifg=#9e9e9e guibg=#121212

" Note: we never set 'term' because the defaults for B&W terminals are OK
hi DiffAdd    ctermbg=LightBlue    guibg=LightBlue
hi DiffChange ctermbg=LightMagenta guibg=LightMagenta
hi DiffDelete ctermfg=Blue         ctermbg=LightCyan gui=bold guifg=Blue guibg=LightCyan
hi DiffText   ctermbg=Red          cterm=bold gui=bold guibg=Red

hi Directory  ctermfg=Blue      guifg=Blue
hi ErrorMsg   ctermfg=Yellow    ctermbg=196  guibg=Red      guifg=Yellow
hi ModeMsg    cterm=bold        gui=bold
hi MoreMsg    ctermfg=DarkGreen gui=bold guifg=SeaGreen
hi NonText    ctermfg=Blue      gui=bold guifg=gray guibg=white
hi Pmenu      guibg=LightBlue
hi PmenuSel   ctermfg=White     ctermbg=DarkBlue  guifg=White  guibg=DarkBlue
hi Question   ctermfg=DarkGreen    gui=bold guifg=SeaGreen
hi SpecialKey ctermfg=DarkBlue     guifg=Blue
hi StatusLine cterm=bold     ctermbg=blue ctermfg=yellow guibg=gold guifg=blue
hi StatusLineNC  cterm=bold     ctermbg=blue ctermfg=black  guibg=gold guifg=blue
hi Title      ctermfg=Yellow  gui=bold guifg=Yellow
hi VertSplit  cterm=NONE            ctermfg=33 ctermbg=NONE gui=reverse
hi Visual     ctermbg=NONE          cterm=reverse gui=reverse guifg=Grey guibg=fg
hi VisualNOS  cterm=underline,bold  gui=underline,bold
hi WarningMsg ctermfg=DarkRed     guifg=Red
hi WildMenu   ctermfg=Black     ctermbg=Yellow    guibg=Yellow guifg=Black

" Text Search
hi Search     ctermfg=Black   ctermbg=Yellow  guifg=Black guibg=Yellow
hi IncSearch  cterm=reverse     gui=reverse

" Programming Syntax Highlighting
hi Comment        cterm=NONE ctermfg=Cyan        gui=NONE guifg=red2
hi SpecialComment cterm=NONE ctermfg=202        gui=NONE guifg=red2
hi Constant       cterm=NONE ctermfg=Green      gui=NONE guifg=LightCyan
hi Identifier     cterm=NONE ctermfg=DarkCyan   gui=NONE guifg=cyan4
hi PreProc        cterm=bold ctermfg=69         gui=bold guifg=magenta3
hi Special        cterm=NONE ctermfg=LightRed   gui=NONE guifg=deeppink
hi Statement      cterm=bold ctermfg=Red        gui=bold guifg=blue
hi Type           cterm=bold ctermfg=LightMagenta gui=bold guifg=Yellow
hi StorageClass   cterm=bold ctermfg=220 
hi Operator       cterm=bold ctermfg=Yellow
hi Todo           cterm=bold ctermfg=196        ctermbg=White

" code folding
hi FoldColumn ctermfg=Blue     ctermbg=Grey     guibg=Grey      guifg=DarkBlue
hi Folded     ctermbg=NONE   ctermfg=151 guibg=LightGrey guifg=DarkBlue

" {{{ vim trailer
" vim: ts=2:sw=2:et
" }}}
