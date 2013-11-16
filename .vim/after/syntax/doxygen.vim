au! Syntax cpp,c,idl
au! Syntax *doxygen
" DoxyGen syntax hilighting extension for c/c++/idl/java
" Language:     doxygen on top of c, cpp, idl, java
" Maintainer:   Michael Geddes <michaelrgeddes@optushome.com.au>
" Author:       Michael Geddes
" Last Change:  12 December 2005
" Version:      1.15
"
" Copyright 2004 Michael Geddes
" Please feel free to use, modify & distribute all or part of this script,
" providing this copyright message remains.
" I would appreciate being acknowledged in any derived scripts, and would
" appreciate and welcome any updates, modifications or suggestions.

" NOTE:  Comments welcome!
"
" There are two variables that control the syntax hilighting produced by this
" script:
" doxygen_enhanced_colour  - Use the (non-standard) original colours designed for this hilighting.
" doxygen_my_rendering     - Disable the HTML bold/italic/underline rendering.
"
" A brief description without '.' or '!' will cause the end comment
" character to be marked as an error.  You can define the colour of this using
" the highlight doxygenErrorComment.
" A \link without an \endlink will cause an error hilight on the end-comment.
" This is defined by doxygenLinkError
"
" The variable g:doxygen_codeword_font can be set to the guifont for marking \c
" words - a 'typewriter' like font normally. Spaces must be escaped.  It can
" also be set to any hilight attribute. Alternatively, a hilight for doxygenCodeWord
" can be used to override it.
"
" By default, hilighting is done assumng you have the JAVADOC_AUTOBRIEF
" setting tunred on in your Doxygen configuration.  If you don't, you
" can set the variable g:doxygen_javadoc_autobrief to 0 to have the
" hilighting more accurately reflect the way Doxygen will interpret your
" comments.
"
" Usage:
"
" Installation Instructions
"
" 1. Create the directory ~/.vim/syntax and move doxygen.vim into it:
"
" cd
" mkdir -p .vim/syntax
" mv doxygen.vim .vim/syntax
"
" Some flavours of UNIX do not support mkdir -p.  In that case, just create the
" directories individually:
"
" mkdir .vim .vim/syntax
"
" 2. Add the following to your ~/.vimrc file to cause vim to use doxygen.vim
" syntax highlighting whenever editing pure Doxygen files.
"
" au BufNewFile,BufRead *.doxygen setfiletype doxygen
"
" Now vim will use the doxygen.vim syntax highlighting whenever editing files
" named *.doxygen.  If you use a different name for your pure Doxygen files,
" replace "*.doxygen" in the above line with the file name you use, such
" as "*.dox".
"
" 3. For programming language source files, doxygen.vim must be loaded last.
" Vim loads the scripts in the ~/.vim/after/syntax directory after it loads
" the normal language syntax.  Create the directory and make links to
" doxygen.vim:
"
" mkdir -p .vim/after/syntax
" cd .vim/after/syntax
" ln -s ../../syntax/doxygen.vim c.vim      (for C)
" ln -s ../../syntax/doxygen.vim cpp.vim    (for C++)
"
" And so on for each language for which you will use Doxygen.
" If you can't use ln, then create files c.vim, cpp.vim that source
" ../../syntax/doxygen.vim
"
" Alternatively, either:
" 1: create files .vim/syntax/c.vim  .vim/syntax/cpp.vim .vim/syntax/ which
"   load the original syntax before loading doxygen.vim syntax hilighting.
" or
" 2: Before :syntax on in your _vimrc, put
" let mysyntaxfile='<some_path>/doxygen_load.vim
" and then create the following file.
" -----------8<--------- <some_path>/doxygen_load.vim --------
" au! Syntax {cpp,c,idl}
" au Syntax {cpp,c,idl} runtime syntax/doxygen.vim
" ------------------------------------------------------------

"
" History:
" 1.1:
"   - Added support for @brief lines at the start, rather than automatic
"       brief (Suggested by Peter Wright)
"   - As an extension support brief comment on a single line followed by
"   multiline doxygen comment.
" 1.2
"   - Add a hilight group for @bug, default to TODO hilighting.(suggested by
"       Markus Trenkwalder)
"   - Fix brief comment on a single line being overzealous - (reported by Markus Trenkwalder)
" 1.3
"   - HTML Hilighting support fixed (reported by Brett Humphreys)
"   - HTML hilighting extended to support bold/italic/underline (coppied from
"       html.vim).
"   - Support a few more recent additions to doxygen.
"   - Support standard colour sets - use doxygen_enhanced_colour to use old
"       sets.
" 1.4
"   - Patches from Wu Yongwei
"     * Include '-' in inline \c \e maching.
"     * \see, \return are multiline desc.
"     * \throw can now handle std::alloc (colons were confusing it)
"   - Fixed support for <a href=> links.
"   - Reported by Wu Yongwei
"     * Handle [in,out] in \param.
"     * Handle non-terminating . in a brief description (eg A.B)
"     * allow leading asterisk inside HTML marks.
"     * Fix up <a> link hilighting when interupted by new-lines and comment
"     continuations.
"     * Handle the case where \c \ref etc are used at the beginning of a 'brief'
"     line.
"   - Fixed termination of multiline at start of new command.
"   - Include John McGehee's instructions.
" 1.5
"   - Make sure @c \c and friends are equivalent for the start of a brief
"     section.
"   - Allow @c \c and friends to cross lines. (Caveat, they can't be hard up
"     against a continuation '*' - it just gets tooo difficult).
"   - Highlight a missing \endlink as an error.
"   - Fix multiline desc without a '*'
" 1.6
"   - Fix up # support.
"   - Highlight \endlink properly.
"   - Don't mark */ as an error where there is no brief, or @{ is used.
" 1.7
"   - Ignore Errors when loading from idl.
"   - Try and match # and \c &c support to match what really happens. (Reported by Wu Yongwei)
"   - Don't go into doxygen mode for /**/
"   - Fix up syncing of brief after a \def or similar line - character
"   immediately following a leading asterisk were being hilighted long.
"   - Try and work out a better default font for \c
" 1.8
"   - Fix up some regions not marked as contained (code, verbatim, dot being
"   hilighted outside of the doxygen region) (Toby Allsopp)
"   - Only mark recognised HTML tags (Suggested by Mike Anderson)
" 1.9
"   - Allow javadoc style auto-brief to be disabled (Toby Allsopp)
"   - Move various definitions from single to multiline definitions (Toby Allsopp)
" 1.10
"   - Allow doxygen comments inside brackets (Suggested by Zygmunt Krynicki)
"   - Restore correct font selection (Wu Yongwei)
"   - Don't end brief when encountering ? or ! as this isn't what happens with doxygen.
"   - Make punctuation an option.
"   - Make short words end with a , eg \c word,  (Wu Yongwei)
" 1.11
"   - Thanks to Joseph Barker for pointing out that I had a syntax error in  1.10
" 1.12
"   - Fixed up ending of brief lines with respect to line @ commands and
"   end-comment. Not ending a brief no longer produces an error-comment.
" 1.13
"   - Fixed up  \c words ending in )  (Wu Yongwei)
" 1.14
"   - With auto-brief //!< followed by /** shouldn't supress the auto-brief in
"   the /**. (Reported by Markus Trenkwalder)
"   - Allow numbers in @link linkwords (Reported by Wu Yongwei)
"   - Don't treat # preceded by a word-end as a Hash-special (Reported by Wu Yongwei)
"   - include # (@c #include) in the small-specials allowed chars. (Wu  Yongwei)
"   - Hilight http[s] links (Wu Yongwei)
" 1.15 
"   - Words like `Class#Member' is highlighted together as a link. (Wu Yongwei)
"   - Use `doxygenHyperLink' instead of `doxygenHttpLink' and highlighted
"     http, https, and ftp protocols. (Wu Yongwei)
"   - Added the missing `doxygenSpecialArgumentWord' to make `\a' (not
"     the word after) appear the same way as `\c'. (Wu Yongwei)
"   - Some adjustments in font choosing on non-Windows
"     platforms. (Wu Yongwei)
"   - Removed Trailing Spaces (Wu Yongwei)
"   - Put Back the '#' hilighting from Wu Yongwei's script (Me)
"

if exists('b:suppress_doxygen')
  unlet b:suppress_doxygen
  finish
endif

if exists('b:current_syntax') && b:current_syntax =~ 'doxygen' && !exists('doxygen_debug_script')
  finish
endif

if ! exists('b:current_syntax') | let b:current_syntax='' | endif
let s:cpo_save = &cpo
set cpo&vim

" Start of Doxygen syntax hilighting:
"

" C/C++ Style line comments
syn region doxygenComment start=+/\*\(\*/\)\@![*!]+  end=+\*/+ contains=doxygenSyncStart,doxygenStart,doxygenTODO keepend
syn region doxygenCommentL start=+//[/!]<\@!+me=e-1 end=+$+ contains=doxygenStartL keepend skipwhite skipnl nextgroup=doxygenComment2
syn region doxygenCommentL start=+//[/!]<+me=e-2 end=+$+ contains=doxygenStartL keepend skipwhite skipnl
syn region doxygenCommentL start=+//@\ze[{}]+ end=+$+ contains=doxygenGroupDefine,doxygenGroupDefineSpecial

" Single line brief followed by multiline comment.
syn region doxygenComment2 start=+/\*\(\*/\)\@![*!]+ end=+\*/+ contained contains=doxygenSyncStart2,doxygenStart2,doxygenTODO keepend
" This helps with sync-ing as for some reason, syncing behaves differently to a normal region, and the start pattern does not get matched.
syn match doxygenSyncStart2 +[^*/]+ contained nextgroup=doxygenBody,doxygenPrev,doxygenStartSpecial,doxygenSkipComment,doxygenStartSkip2 skipwhite skipnl

" Skip empty lines at the start for when comments start on the 2nd/3rd line.
syn match doxygenStartSkip2 +^\s*\*[^/]+me=e-1 contained nextgroup=doxygenBody,doxygenStartSpecial,doxygenStartSkip skipwhite skipnl
syn match doxygenStartSkip2 +^\s*\*$+ contained nextgroup=doxygenBody,doxygenStartSpecial,,doxygenStartSkip skipwhite skipnl
syn match doxygenStart2 +/\*[*!]+ contained nextgroup=doxygenBody,doxygenPrev,doxygenStartSpecial,doxygenStartSkip2 skipwhite skipnl

" Match the Starting pattern (effectively creating the start of a BNF)
if !exists('g:doxygen_javadoc_autobrief') || g:doxygen_javadoc_autobrief
  syn match doxygenStart +/\*[*!]+ contained nextgroup=doxygenBrief,doxygenPrev,doxygenFindBriefSpecial,doxygenStartSpecial,doxygenStartSkip,doxygenPage skipwhite skipnl
else
  syn match doxygenStart +/\*[*!]+ contained nextgroup=doxygenBody,doxygenPrev,doxygenFindBriefSpecial,doxygenStartSpecial,doxygenStartSkip,doxygenPage skipwhite skipnl
endif
syn match doxygenStartL +//[/!]+ contained nextgroup=doxygenPrevL,doxygenBriefL,doxygenSpecial skipwhite

" This helps with sync-ing as for some reason, syncing behaves differently to a normal region, and the start pattern does not get matched.
syn match doxygenSyncStart +\ze[^*/]+ contained nextgroup=doxygenBrief,doxygenPrev,doxygenStartSpecial,doxygenFindBriefSpecial,doxygenStartSkip,doxygenPage skipwhite skipnl

" Match the first sentence as a brief comment
if ! exists('g:doxygen_end_punctuation')
  let g:doxygen_end_punctuation='[.]'
endif
exe 'syn region doxygenBrief contained start=+[\\@]\([pcbea]\>\|em\>\|ref\>\|link\>\|f\$\|[$\\&<>#]\)\|[^ \t\\@*]+ start=+\(^\s*\)\@<!\*/\@!+ start=+\<\k+ skip=+'.doxygen_end_punctuation.'\S+ end=+'.doxygen_end_punctuation.'+ end=+\(\s*\(\n\s*\*\=\s*\)[@\\]\([pcbea]\>\|em\>\|ref\>\|link\>\|f\$\|[$\\&<>#]\)\@!\)\@=+ contains=doxygenSmallSpecial,doxygenContinueComment,doxygenBriefEndComment,doxygenFindBriefSpecial,doxygenSmallSpecial,@doxygenHtmlGroup,doxygenTODO,doxygenOtherLink,doxygenHyperLink,doxygenHashLink  skipnl nextgroup=doxygenBody'

syn match doxygenBriefEndComment +\*/+ contained

exe 'syn region doxygenBriefL start=+@\k\@!\|[\\@]\([pcbea]\>\|em\>\|ref\>\|link\>\|f\$\|[$\\&<>#]\)\|[^ \t\\@]+ start=+\<+ skip=+'.doxygen_end_punctuation.'\S+ end=+'.doxygen_end_punctuation.'\|$+ contained contains=doxygenSmallSpecial,doxygenHyperLink,doxygenHashLink,@doxygenHtmlGroup keepend'

syn region doxygenBriefLine contained start=+\<\k+ end=+\(\n\s*\*\=\s*\([@\\]\([pcbea]\>\|em\>\|ref\>\|link\>\|f\$\|[$\\&<>#]\)\@!\)\|\s*$\)\@=+ contains=doxygenContinueComment,doxygenFindBriefSpecial,doxygenSmallSpecial,@doxygenHtmlGroup,doxygenTODO,doxygenOtherLink,doxygenHyperLink,doxygenHashLink  skipwhite keepend

" Match a '<' for applying a comment to the previous element.
syn match doxygenPrev +<+ contained nextgroup=doxygenBrief,doxygenSpecial,doxygenStartSkip skipwhite
syn match doxygenPrevL +<+ contained  nextgroup=doxygenBriefL,doxygenSpecial skipwhite

" These are anti-doxygen comments.  If there are more than two asterisks or 3 '/'s
" then turn the comments back into normal C comments.
syn region cComment start="/\*\*\*" end="\*/" contains=@cCommentGroup,cCommentString,cCharacter,cNumbersCom,cSpaceError
syn region cCommentL start="////" skip="\\$" end="$" contains=@cCommentGroup,cComment2String,cCharacter,cNumbersCom,cSpaceError

" Special commands at the start of the area:  starting with '@' or '\'
syn region doxygenStartSpecial contained start=+[@\\]\([pcbea]\>\|em\>\|ref\>\|link\>\|f\$\|[$\\&<>#]\)\@!+ end=+$+ end=+\*/+me=s-1,he=s-1  contains=doxygenSpecial nextgroup=doxygenSkipComment skipnl keepend
syn match doxygenSkipComment contained +^\s*\*/\@!+ nextgroup=doxygenBrief,doxygenStartSpecial,doxygenFindBriefSpecial,doxygenPage skipwhite

"syn region doxygenBodyBit contained start=+$+

" The main body of a doxygen comment.
syn region doxygenBody contained start=+.\|$+ matchgroup=doxygenEndComment end=+\*/+re=e-2,me=e-2 contains=doxygenContinueComment,doxygenTODO,doxygenSpecial,doxygenSmallSpecial,doxygenHyperLink,doxygenHashLink,@doxygenHtmlGroup

" These allow the skipping of comment continuation '*' characters.
syn match doxygenContinueComment contained +^\s*\*/\@!\s*+

" Catch a Brief comment without punctuation - flag it as an error but
" make sure the end comment is picked up also.
syn match doxygenErrorComment contained +\*/+


" Skip empty lines at the start for when comments start on the 2nd/3rd line.
if !exists('g:doxygen_javadoc_autobrief') || g:doxygen_javadoc_autobrief
  syn match doxygenStartSkip +^\s*\*[^/]+me=e-1 contained nextgroup=doxygenBrief,doxygenStartSpecial,doxygenFindBriefSpecial,doxygenStartSkip,doxygenPage skipwhite skipnl
  syn match doxygenStartSkip +^\s*\*$+ contained nextgroup=doxygenBrief,doxygenStartSpecial,doxygenFindBriefSpecial,doxygenStartSkip,doxygenPage skipwhite skipnl
else
  syn match doxygenStartSkip +^\s*\*[^/]+me=e-1 contained nextgroup=doxygenStartSpecial,doxygenFindBriefSpecial,doxygenStartSkip,doxygenPage,doxygenBody skipwhite skipnl
  syn match doxygenStartSkip +^\s*\*$+ contained nextgroup=doxygenStartSpecial,doxygenFindBriefSpecial,doxygenStartSkip,doxygenPage,doxygenBody skipwhite skipnl
endif

" Match an [@\]brief so that it moves to body-mode.
"
"
" syn match doxygenBriefLine  contained
syn match doxygenBriefSpecial contained +[@\\]+ nextgroup=doxygenBriefWord skipwhite
syn region doxygenFindBriefSpecial start=+[@\\]brief\>+ end=+\(\n\s*\*\=\s*\([@\\]\([pcbea]\>\|em\>\|ref\>\|link\>\|f\$\|[$\\&<>#]\)\@!\)\|\s*$\)\@=+ keepend contains=doxygenBriefSpecial nextgroup=doxygenBody keepend skipwhite skipnl contained


" Create the single word matching special identifiers.

fun! s:DxyCreateSmallSpecial( kword, name )

  let mx='[-:0-9A-Za-z_%=&+*/!~>|]\@<!\([-0-9A-Za-z_%=+*/!~>|#]\+[-0-9A-Za-z_%=+*/!~>|]\@!\|\\[\\<>&.]@\|[.,][0-9a-zA-Z_]\@=\|::\|([^)]*)\|&[0-9a-zA-Z]\{2,7};\)\+'
  exe 'syn region doxygenSpecial'.a:name.'Word contained start=+'.a:kword.'+ end=+\(\_s\+'.mx.'\)\@<=[-a-zA-Z_0-9+*/^%|~!=&\\]\@!+ skipwhite contains=doxygenContinueComment,doxygen'.a:name.'Word'
  exe 'syn match doxygen'.a:name.'Word contained "\_s\@<='.mx.'" contains=doxygenHtmlSpecial keepend'
endfun
call s:DxyCreateSmallSpecial('p', 'Code')
call s:DxyCreateSmallSpecial('c', 'Code')
call s:DxyCreateSmallSpecial('b', 'Bold')
call s:DxyCreateSmallSpecial('e', 'Emphasised')
call s:DxyCreateSmallSpecial('em', 'Emphasised')
call s:DxyCreateSmallSpecial('a', 'Argument')
call s:DxyCreateSmallSpecial('ref', 'Ref')
delfun s:DxyCreateSmallSpecial

syn match doxygenSmallSpecial contained +[@\\]\(\<[pcbea]\>\|\<em\>\|\<ref\>\|\<link\>\|f\$\|[$\\&<>#]\)\@=+ nextgroup=doxygenOtherLink,doxygenHyperLink,doxygenHashLink,doxygenFormula,doxygenSymbol,doxygenSpecial.*Word

" Now for special characters
syn match doxygenSpecial contained +[@\\]\(\<[pcbea]\>\|\<em\>\|\<ref\|\<link\>\>\|\<f\$\|[$\\&<>#]\)\@!+ nextgroup=doxygenParam,doxygenRetval,doxygenBriefWord,doxygenBold,doxygenBOther,doxygenOther,doxygenOtherTODO,doxygenOtherWARN,doxygenOtherBUG,doxygenPage,doxygenGroupDefine,doxygenCodeRegion,doxygenVerbatimRegion,doxygenDotRegion
" doxygenOtherLink,doxygenSymbol,doxygenFormula,doxygenErrorSpecial,doxygenSpecial.*Word
"
syn match doxygenGroupDefine contained +@\@<=[{}]+
syn match doxygenGroupDefineSpecial contained +@\ze[{}]+

syn match doxygenErrorSpecial contained +\s+

" Match Parmaters and retvals (hilighting the first word as special).
syn match doxygenParamDirection contained +\[\(\<in\>\|\<out\>\|,\)\+\]+ nextgroup=doxygenParamName skipwhite
syn keyword doxygenParam contained param nextgroup=doxygenParamName,doxygenParamDirection skipwhite
syn match doxygenParamName contained +[A-Za-z0-9_:]\++ nextgroup=doxygenSpecialMultilineDesc skipwhite
syn keyword doxygenRetval contained retval throw exception nextgroup=doxygenParamName skipwhite

" Match one line identifiers.
syn keyword doxygenOther contained addindex anchor
\ dontinclude endhtmlonly endlatexonly showinitializer hideinitializer
\ example htmlonly image include ingroup internal latexonly line
\ overload relates relatesalso sa skip skipline
\ until verbinclude version addtogroup htmlinclude copydoc dotfile
\ xmlonly endxmlonly
\ nextgroup=doxygenSpecialOnelineDesc

syn region doxygenCodeRegion contained matchgroup=doxygenOther start=+\<code\>+ matchgroup=doxygenOther end=+[\\@]\@<=\<endcode\>+ contains=doxygenCodeRegionSpecial,doxygenContinueComment,doxygenErrorComment
syn match doxygenCodeRegionSpecial contained +[\\@]\(endcode\>\)\@=+

syn region doxygenVerbatimRegion contained matchgroup=doxygenOther start=+\<verbatim\>+ matchgroup=doxygenOther end=+[\\@]\@<=\<endverbatim\>+ contains=doxygenVerbatimRegionSpecial,doxygenContinueComment,doxygenErrorComment
syn match doxygenVerbatimRegionSpecial contained +[\\@]\(endverbatim\>\)\@=+

let b:doxygen_syntax_save=b:current_syntax
unlet b:current_syntax
syn include @Dotx syntax/dot.vim
let b:current_syntax=b:doxygen_syntax_save
unlet b:doxygen_syntax_save
syn region doxygenDotRegion contained matchgroup=doxygenOther start=+\<dot\>+ matchgroup=doxygenOther end=+[\\@]\@<=\<enddot\>+ contains=doxygenDotRegionSpecial,doxygenErrorComment,doxygenContinueComment,@Dotx
syn match doxygenDotRegionSpecial contained +[\\@]\(enddot\>\)\@=+

" Match single line identifiers.
syn keyword doxygenBOther contained class enum file fn mainpage interface
\ namespace struct typedef union var def name
\ nextgroup=doxygenSpecialTypeOnelineDesc

syn keyword doxygenOther contained par nextgroup=doxygenHeaderLine
syn region doxygenHeaderLine start=+.+ end=+^+ contained skipwhite nextgroup=doxygenSpecialMultilineDesc

syn keyword doxygenOther contained arg author date deprecated li return see invariant note post pre remarks since test nextgroup=doxygenSpecialMultilineDesc
syn keyword doxygenOtherTODO contained todo attention nextgroup=doxygenSpecialMultilineDesc
syn keyword doxygenOtherWARN contained warning nextgroup=doxygenSpecialMultilineDesc
syn keyword doxygenOtherBUG contained bug nextgroup=doxygenSpecialMultilineDesc

" Handle \link, \endlink, hilighting the link-to and the link text bits separately.
syn region doxygenOtherLink matchgroup=doxygenOther start=+link+ end=+[\@]\@<=endlink\>+ contained contains=doxygenLinkWord,doxygenContinueComment,doxygenLinkError,doxygenEndlinkSpecial
syn match doxygenEndlinkSpecial contained +[\\@]\zeendlink\>+

syn match doxygenLinkWord "[_a-zA-Z:#()][_a-z0-9A-Z:#()]*\>" contained skipnl nextgroup=doxygenLinkRest,doxygenContinueLinkComment
syn match doxygenLinkRest +[^*@\\]\|\*/\@!\|[@\\]\(endlink\>\)\@!+ contained skipnl nextgroup=doxygenLinkRest,doxygenContinueLinkComment
syn match doxygenContinueLinkComment contained +^\s*\*\=[^/]+me=e-1 nextgroup=doxygenLinkRest
syn match doxygenLinkError "\*/" contained
" #Link hilighting.
syn match doxygenHashLink /\([a-zA-Z_][0-9a-zA-Z_]*\)\?#\(\.[0-9a-zA-Z_]\@=\|[a-zA-Z0-9_]\+\|::\|()\)\+/ contained contains=doxygenHashSpecial
syn match doxygenHashSpecial /#/ contained
syn match doxygenHyperLink /\(\s\|^\s*\*\?\)\@<=\(http\|https\|ftp\):\/\/[-0-9a-zA-Z_?&=+#%/.!':;@]\+/ contained

" Handle \page.  This does not use doxygenBrief.
syn match doxygenPage "[\\@]page\>"me=s+1 contained skipwhite nextgroup=doxygenPagePage
syn keyword doxygenPagePage page contained skipwhite nextgroup=doxygenPageIdent
syn region doxygenPageDesc  start=+.\++ end=+$+ contained skipwhite contains=doxygenSmallSpecial,@doxygenHtmlGroup keepend skipwhite skipnl nextgroup=doxygenBody
syn match doxygenPageIdent "\<[a-zA-Z0-9]\+\>" contained nextgroup=doxygenPageDesc

" Handle section
syn keyword doxygenOther defgroup section subsection subsubsection weakgroup contained skipwhite nextgroup=doxygenSpecialIdent
syn region doxygenSpecialSectionDesc  start=+.\++ end=+$+ contained skipwhite contains=doxygenSmallSpecial,@doxygenHtmlGroup keepend skipwhite skipnl nextgroup=doxygenContinueComment
syn match doxygenSpecialIdent "\<[a-zA-Z0-9]\+\>" contained nextgroup=doxygenSpecialSectionDesc

" Does the one-line description for the one-line type identifiers.
syn region doxygenSpecialTypeOnelineDesc  start=+.\++ end=+$+ contained skipwhite contains=doxygenSmallSpecial,@doxygenHtmlGroup keepend
syn region doxygenSpecialOnelineDesc  start=+.\++ end=+$+ contained skipwhite contains=doxygenSmallSpecial,@doxygenHtmlGroup keepend

" Handle the multiline description for the multiline type identifiers.
" Continue until an 'empty' line (can contain a '*' continuation) or until the
" next whole-line @ command \ command.
syn region doxygenSpecialMultilineDesc  start=+.\++ skip=+^\s*\(\*/\@!\s*\)\=\(\<\|[@\\]\<\([pcbea]\>\|em\>\|ref\|link\>\>\|f\$\|[$\\&<>#]\)\|[^ \t\\@*]\)+ end=+^+ contained contains=doxygenSpecialContinueComment,doxygenSmallSpecial,doxygenHyperLink,doxygenHashLink,@doxygenHtmlGroup  skipwhite keepend
syn match doxygenSpecialContinueComment contained +^\s*\*/\@!\s*+ nextgroup=doxygenSpecial skipwhite

" Handle special cases  'bold' and 'group'
syn keyword doxygenBold contained bold nextgroup=doxygenSpecialHeading
syn keyword doxygenBriefWord contained brief nextgroup=doxygenBriefLine skipwhite
syn match doxygenSpecialHeading +.\++ contained skipwhite
syn keyword doxygenGroup contained group nextgroup=doxygenGroupName skipwhite
syn keyword doxygenGroupName contained +\k\++ nextgroup=doxygenSpecialOnelineDesc skipwhite

" Handle special symbol identifiers  @$, @\, @$ etc
syn match doxygenSymbol contained +[$\\&<>#]+

" Simplistic handling of formula regions
syn region doxygenFormula contained matchgroup=doxygenFormulaEnds start=+f\$+ end=+[@\\]f\$+ contains=doxygenFormulaSpecial,doxygenFormulaOperator
syn match doxygenFormulaSpecial contained +[@\\]\(f[^$]\|[^f]\)+me=s+1 nextgroup=doxygenFormulaKeyword,doxygenFormulaEscaped
syn match doxygenFormulaEscaped contained "."
syn match doxygenFormulaKeyword contained  "[a-z]\+"
syn match doxygenFormulaOperator contained +[_^]+

syn region doxygenFormula contained matchgroup=doxygenFormulaEnds start=+f\[+ end=+[@\\]f]+ contains=doxygenFormulaSpecial,doxygenFormulaOperator,doxygenAtom
syn region doxygenAtom contained transparent matchgroup=doxygenFormulaOperator start=+{+ end=+}+ contains=doxygenAtom,doxygenFormulaSpecial,doxygenFormulaOperator

" Add TODO hilighting.
syn keyword doxygenTODO contained TODO README XXX FIXME

" Supported HTML subset.  Not perfect, but okay.
syn case ignore
syn region doxygenHtmlTag contained matchgroup=doxygenHtmlCh start=+\v\</=\ze([biuap]|em|strong|img|br|center|code|dfn|d[ldt]|hr|h[0-3]|li|[ou]l|pre|small|sub|sup|table|tt|var|caption|src|alt|longdesc|name|height|width|usemap|ismap|href|type)>+ skip=+\\<\|\<\k\+=\("[^"]*"\|'[^']*\)+ end=+>+ contains=doxygenHtmlCmd,doxygenContinueComment,doxygenHtmlVar
syn keyword doxygenHtmlCmd contained b i em strong u img a br p center code dfn dl dd dt hr h1 h2 h3 li ol ul pre small sub sup table tt var caption nextgroup=doxygenHtmlVar skipwhite
syn keyword doxygenHtmlVar contained src alt longdesc name height width usemap ismap href type nextgroup=doxygenHtmlEqu skipwhite
syn match doxygenHtmlEqu contained +=+ nextgroup=doxygenHtmlExpr skipwhite
syn match doxygenHtmlExpr contained +"\(\\.\|[^"]\)*"\|'\(\\.\|[^']\)*'+ nextgroup=doxygenHtmlVar skipwhite
syn case match
syn match doxygenHtmlSpecial contained "&\(copy\|quot\|[AEIOUYaeiouy]uml\|[AEIOUYaeiouy]acute\|[AEIOUaeiouy]grave\|[AEIOUaeiouy]circ\|[ANOano]tilde\|szlig\|[Aa]ring\|nbsp\|gt\|lt\|amp\);"

syn cluster doxygenHtmlGroup contains=doxygenHtmlCode,doxygenHtmlBold,doxygenHtmlUnderline,doxygenHtmlItalic,doxygenHtmlSpecial,doxygenHtmlTag,doxygenHtmlLink

syn cluster doxygenHtmlTop contains=@Spell,doxygenHtmlSpecial,doxygenHtmlTag,doxygenContinueComment
" Html Support
syn region doxygenHtmlLink contained start=+<[aA]\>\s*\(\n\s*\*\s*\)\=\(\(name\|href\)=\("[^"]*"\|'[^']*'\)\)\=\s*>+ end=+</[aA]>+me=e-4 contains=@doxygenHtmlTop
hi link doxygenHtmlLink Underlined

syn region doxygenHtmlBold contained start="\c<b\>" end="\c</b>"me=e-4 contains=@doxygenHtmlTop,doxygenHtmlBoldUnderline,doxygenHtmlBoldItalic
syn region doxygenHtmlBold contained start="\c<strong\>" end="\c</strong>"me=e-9 contains=@doxygenHtmlTop,doxygenHtmlBoldUnderline,doxygenHtmlBoldItalic
syn region doxygenHtmlBoldUnderline contained start="\c<u\>" end="\c</u>"me=e-4 contains=@doxygenHtmlTop,doxygenHtmlBoldUnderlineItalic
syn region doxygenHtmlBoldItalic contained start="\c<i\>" end="\c</i>"me=e-4 contains=@doxygenHtmlTop,doxygenHtmlBoldItalicUnderline
syn region doxygenHtmlBoldItalic contained start="\c<em\>" end="\c</em>"me=e-5 contains=@doxygenHtmlTop,doxygenHtmlBoldItalicUnderline
syn region doxygenHtmlBoldUnderlineItalic contained start="\c<i\>" end="\c</i>"me=e-4 contains=@doxygenHtmlTop
syn region doxygenHtmlBoldUnderlineItalic contained start="\c<em\>" end="\c</em>"me=e-5 contains=@doxygenHtmlTop
syn region doxygenHtmlBoldItalicUnderline contained start="\c<u\>" end="\c</u>"me=e-4 contains=@doxygenHtmlTop,doxygenHtmlBoldUnderlineItalic

syn region doxygenHtmlUnderline contained start="\c<u\>" end="\c</u>"me=e-4 contains=@doxygenHtmlTop,doxygenHtmlUnderlineBold,doxygenHtmlUnderlineItalic
syn region doxygenHtmlUnderlineBold contained start="\c<b\>" end="\c</b>"me=e-4 contains=@doxygenHtmlTop,doxygenHtmlUnderlineBoldItalic
syn region doxygenHtmlUnderlineBold contained start="\c<strong\>" end="\c</strong>"me=e-9 contains=@doxygenHtmlTop,doxygenHtmlUnderlineBoldItalic
syn region doxygenHtmlUnderlineItalic contained start="\c<i\>" end="\c</i>"me=e-4 contains=@doxygenHtmlTop,htmUnderlineItalicBold
syn region doxygenHtmlUnderlineItalic contained start="\c<em\>" end="\c</em>"me=e-5 contains=@doxygenHtmlTop,htmUnderlineItalicBold
syn region doxygenHtmlUnderlineItalicBold contained start="\c<b\>" end="\c</b>"me=e-4 contains=@doxygenHtmlTop
syn region doxygenHtmlUnderlineItalicBold contained start="\c<strong\>" end="\c</strong>"me=e-9 contains=@doxygenHtmlTop
syn region doxygenHtmlUnderlineBoldItalic contained start="\c<i\>" end="\c</i>"me=e-4 contains=@doxygenHtmlTop
syn region doxygenHtmlUnderlineBoldItalic contained start="\c<em\>" end="\c</em>"me=e-5 contains=@doxygenHtmlTop

syn region doxygenHtmlItalic contained start="\c<i\>" end="\c</i>"me=e-4 contains=@doxygenHtmlTop,doxygenHtmlItalicBold,doxygenHtmlItalicUnderline
syn region doxygenHtmlItalic contained start="\c<em\>" end="\c</em>"me=e-5 contains=@doxygenHtmlTop
syn region doxygenHtmlItalicBold contained start="\c<b\>" end="\c</b>"me=e-4 contains=@doxygenHtmlTop,doxygenHtmlItalicBoldUnderline
syn region doxygenHtmlItalicBold contained start="\c<strong\>" end="\c</strong>"me=e-9 contains=@doxygenHtmlTop,doxygenHtmlItalicBoldUnderline
syn region doxygenHtmlItalicBoldUnderline contained start="\c<u\>" end="\c</u>"me=e-4 contains=@doxygenHtmlTop
syn region doxygenHtmlItalicUnderline contained start="\c<u\>" end="\c</u>"me=e-4 contains=@doxygenHtmlTop,doxygenHtmlItalicUnderlineBold
syn region doxygenHtmlItalicUnderlineBold contained start="\c<b\>" end="\c</b>"me=e-4 contains=@doxygenHtmlTop
syn region doxygenHtmlItalicUnderlineBold contained start="\c<strong\>" end="\c</strong>"me=e-9 contains=@doxygenHtmlTop

syn region doxygenHtmlCode contained start="\c<code\>" end="\c</code>"me=e-7 contains=@doxygenHtmlTop

" Prevent the doxygen contained matches from leaking into the c groups.
syn cluster cParenGroup add=doxygen.*
syn cluster cParenGroup remove=doxygenComment,doxygenCommentL
syn cluster cPreProcGroup add=doxygen.*
syn cluster cMultiGroup add=doxygen.*
syn cluster rcParenGroup add=doxygen.*
syn cluster rcParenGroup remove=doxygenComment,doxygenCommentL
syn cluster rcGroup add=doxygen.*

" Trick to force special doxygen hilighting if the background changes (need to
" syn clear first)
if exists("did_doxygen_syntax_inits")
  if did_doxygen_syntax_inits != &background && synIDattr(highlightID('doxygen_Dummy'), 'fg', 'gui')==''
    command -nargs=+ SynColor hi <args>
    unlet did_doxygen_syntax_inits
  endif
else
    command -nargs=+ SynColor hi def <args>
endif

if !exists("did_doxygen_syntax_inits")
  command -nargs=+ SynLink hi def link <args>
  let did_doxygen_syntax_inits = &background
  hi doxygen_Dummy guifg=black

  fun! s:Doxygen_Hilights_Base()
    SynLink doxygenHtmlSpecial Special
    SynLink doxygenHtmlVar Type
    SynLink doxygenHtmlExpr String

    SynLink doxygenSmallSpecial SpecialChar

    SynLink doxygenSpecialCodeWord doxygenSmallSpecial
    SynLink doxygenSpecialBoldWord doxygenSmallSpecial
    SynLink doxygenSpecialEmphasisedWord doxygenSmallSpecial
    SynLink doxygenSpecialArgumentWord doxygenSmallSpecial

    " SynColor doxygenFormulaKeyword cterm=bold ctermfg=DarkMagenta guifg=DarkMagenta gui=bold
    SynLink doxygenFormulaKeyword Keyword
    "SynColor doxygenFormulaEscaped  ctermfg=DarkMagenta guifg=DarkMagenta gui=bold
    SynLink doxygenFormulaEscaped Special
    SynLink doxygenFormulaOperator Operator
    SynLink doxygenFormula Statement
    SynLink doxygenSymbol Constant
    SynLink doxygenSpecial Special
    SynLink doxygenFormulaSpecial Special
    "SynColor doxygenFormulaSpecial ctermfg=DarkBlue guifg=DarkBlue
  endfun
  call s:Doxygen_Hilights_Base()

  fun! s:Doxygen_Hilights()
    " Pick a sensible default for 'codeword'.
    let font=''
    if exists('g:doxygen_codeword_font')
      if g:doxygen_codeword_font !~ '\<\k\+='
        let font='font='.g:doxygen_codeword_font
      else
        let font=g:doxygen_codeword_font
      endif
    else
      " Try and pick a font (only some platforms have been tested).
      if has('gui_running')
        if has('gui_gtk2')
          if &guifont == ''
            let font="font='FreeSerif 12'"
          else
            let font="font='".substitute(&guifont, '^.\{-}\([0-9]\+\)$', 'FreeSerif \1','')."'"
          endif

        elseif has('gui_win32') || has('gui_win16') || has('gui_win95')
          if &guifont == ''
            let font='font=Lucida_Console:h10'
          else
            let font='font='.substitute(&guifont, '^[^:]*', 'Lucida_Console','')
          endif
        elseif has('gui_athena') || has('gui_gtk') || &guifont=~'^\(-[^-]\+\)\{14}'
          if &guifont == ''
            let font='font=-b&h-lucidatypewriter-medium-r-normal-*-*-140-*-*-m-*-iso8859-1'
          else
          " let font='font='.substitute(&guifont,'^\(-[^-]\+\)\{7}-\([0-9]\+\).*', '-b\&h-lucidatypewriter-medium-r-normal-*-*-\2-*-*-m-*-iso8859-1','')
          " The above line works, but it is hard to expect the combination of
          " the two fonts will look good.
          endif
        elseif has('gui_kde')
          " let font='font=Bitstream\ Vera\ Sans\ Mono/12/-1/5/50/0/0/0/0/0'
        endif
      endif
    endif
    if font=='' | let font='gui=bold' | endif
    exe 'SynColor doxygenCodeWord             term=bold cterm=bold '.font
    if (exists('g:doxygen_enhanced_color') && g:doxygen_enhanced_color) || (exists('g:doxygen_enhanced_colour') && g:doxygen_enhanced_colour)
      if &background=='light'
        SynColor doxygenComment ctermfg=DarkRed guifg=DarkRed
        SynColor doxygenBrief cterm=bold ctermfg=Cyan guifg=DarkBlue gui=bold
        SynColor doxygenBody ctermfg=DarkBlue guifg=DarkBlue
        SynColor doxygenSpecialTypeOnelineDesc cterm=bold ctermfg=DarkRed guifg=firebrick3 gui=bold
        SynColor doxygenBOther cterm=bold ctermfg=DarkMagenta guifg=#aa50aa gui=bold
        SynColor doxygenParam ctermfg=DarkGray guifg=#aa50aa
        SynColor doxygenParamName cterm=italic ctermfg=DarkBlue guifg=DeepSkyBlue4 gui=italic,bold
        SynColor doxygenSpecialOnelineDesc cterm=bold ctermfg=DarkCyan guifg=DodgerBlue3 gui=bold
        SynColor doxygenSpecialHeading cterm=bold ctermfg=DarkBlue guifg=DeepSkyBlue4 gui=bold
        SynColor doxygenPrev ctermfg=DarkGreen guifg=DarkGreen
      else
        SynColor doxygenComment ctermfg=LightRed guifg=LightRed
        SynColor doxygenBrief cterm=bold ctermfg=Cyan ctermbg=darkgrey guifg=LightBlue gui=Bold,Italic
        SynColor doxygenBody ctermfg=Cyan guifg=LightBlue
        SynColor doxygenSpecialTypeOnelineDesc cterm=bold ctermfg=Red guifg=firebrick3 gui=bold
        SynColor doxygenBOther cterm=bold ctermfg=Magenta guifg=#aa50aa gui=bold
        SynColor doxygenParam ctermfg=LightGray guifg=LightGray
        SynColor doxygenParamName cterm=italic ctermfg=LightBlue guifg=LightBlue gui=italic,bold
        SynColor doxygenSpecialOnelineDesc cterm=bold ctermfg=LightCyan guifg=LightCyan gui=bold
        SynColor doxygenSpecialHeading cterm=bold ctermfg=LightBlue guifg=LightBlue gui=bold
        SynColor doxygenPrev ctermfg=LightGreen guifg=LightGreen
      endif
    else
      SynLink doxygenComment SpecialComment
      SynLink doxygenBrief Statement
      SynLink doxygenBody Comment
      SynLink doxygenSpecialTypeOnelineDesc Statement
      SynLink doxygenBOther Constant
      SynLink doxygenParam SpecialComment
      SynLink doxygenParamName Underlined
      SynLink doxygenSpecialOnelineDesc Statement
      SynLink doxygenSpecialHeading Statement
      SynLink doxygenPrev SpecialComment
    endif
  endfun
  call s:Doxygen_Hilights()
  " This is still a proposal, but won't do any harm.
  au Syntax UserColor_reset nested call s:Doxygen_Hilights_Base()
  au Syntax UserColor_{on,reset,enable} nested call s:Doxygen_Hilights()

  SynLink doxygenBody                   Comment
  SynLink doxygenTODO                   Todo
  SynLink doxygenOtherTODO              Todo
  SynLink doxygenOtherWARN              Todo
  SynLink doxygenOtherBUG               Todo

  SynLink doxygenErrorSpecial           Error
  SynLink doxygenErrorEnd               Error
  SynLink doxygenErrorComment           Error
  SynLink doxygenLinkError              Error
  SynLink doxygenBriefSpecial           doxygenSpecial
  SynLink doxygenHashSpecial            doxygenSpecial
  SynLink doxygenGroupDefineSpecial     doxygenSpecial
  SynLink doxygenEndlinkSpecial         doxygenSpecial
  SynLink doxygenCodeRegionSpecial      doxygenSpecial
  SynLink doxygenVerbatimRegionSpecial  doxygenSpecial
  SynLink doxygenGroupDefine            doxygenParam

  SynLink doxygenSpecialMultilineDesc   doxygenSpecialOnelineDesc
  SynLink doxygenFormulaEnds            doxygenSpecial
  SynLink doxygenBold                   doxygenParam
  SynLink doxygenBriefWord              doxygenParam
  SynLink doxygenRetval                 doxygenParam
  SynLink doxygenOther                  doxygenParam
  SynLink doxygenStart                  doxygenComment
  SynLink doxygenStart2                 doxygenStart
  SynLink doxygenComment2               doxygenComment
  SynLink doxygenCommentL               doxygenComment
  SynLink doxygenContinueComment        doxygenComment
  SynLink doxygenSpecialContinueComment doxygenComment
  SynLink doxygenSkipComment            doxygenComment
  SynLink doxygenEndComment             doxygenComment
  SynLink doxygenStartL                 doxygenComment
  SynLink doxygenBriefEndComment        doxygenComment
  SynLink doxygenPrevL                  doxygenPrev
  SynLink doxygenBriefL                 doxygenBrief
  SynLink doxygenBriefLine              doxygenBrief
  SynLink doxygenHeaderLine             doxygenSpecialHeading
  SynLink doxygenStartSkip              doxygenContinueComment
  SynLink doxygenLinkWord               doxygenParamName
  SynLink doxygenLinkRest               doxygenSpecialMultilineDesc
  SynLink doxygenHyperLink              doxygenLinkWord
  SynLink doxygenHashLink               doxygenLinkWord

  SynLink doxygenPage                   doxygenSpecial
  SynLink doxygenPagePage               doxygenBOther
  SynLink doxygenPageIdent              doxygenParamName
  SynLink doxygenPageDesc               doxygenSpecialTypeOnelineDesc

  SynLink doxygenSpecialIdent           doxygenPageIdent
  SynLink doxygenSpecialSectionDesc     doxygenSpecialMultilineDesc

  SynLink doxygenSpecialRefWord         doxygenOther
  SynLink doxygenRefWord                doxygenPageIdent
  SynLink doxygenContinueLinkComment    doxygenComment

  SynLink doxygenHtmlCh                 Function
  SynLink doxygenHtmlCmd                Statement
  SynLink doxygenHtmlBoldItalicUnderline     doxygenHtmlBoldUnderlineItalic
  SynLink doxygenHtmlUnderlineBold           doxygenHtmlBoldUnderline
  SynLink doxygenHtmlUnderlineItalicBold     doxygenHtmlBoldUnderlineItalic
  SynLink doxygenHtmlUnderlineBoldItalic     doxygenHtmlBoldUnderlineItalic
  SynLink doxygenHtmlItalicUnderline         doxygenHtmlUnderlineItalic
  SynLink doxygenHtmlItalicBold              doxygenHtmlBoldItalic
  SynLink doxygenHtmlItalicBoldUnderline     doxygenHtmlBoldUnderlineItalic
  SynLink doxygenHtmlItalicUnderlineBold     doxygenHtmlBoldUnderlineItalic
  SynLink doxygenHtmlLink                    Underlined

  SynLink doxygenParamDirection              StorageClass


  if !exists("doxygen_my_rendering") && !exists("html_my_rendering")
    SynColor doxygenBoldWord             term=bold cterm=bold gui=bold
    SynColor doxygenEmphasisedWord       term=italic cterm=italic gui=italic
    SynLink  doxygenArgumentWord         doxygenEmphasisedWord
    SynLink  doxygenHtmlCode             doxygenCodeWord
    SynLink  doxygenHtmlBold             doxygenBoldWord
    SynColor doxygenHtmlBoldUnderline       term=bold,underline cterm=bold,underline gui=bold,underline
    SynColor doxygenHtmlBoldItalic          term=bold,italic cterm=bold,italic gui=bold,italic
    SynColor doxygenHtmlBoldUnderlineItalic term=bold,italic,underline cterm=bold,italic,underline gui=bold,italic,underline
    SynColor doxygenHtmlUnderline        term=underline cterm=underline gui=underline
    SynColor doxygenHtmlUnderlineItalic  term=italic,underline cterm=italic,underline gui=italic,underline
    SynColor doxygenHtmlItalic           term=italic cterm=italic gui=italic
  endif
  delcommand SynLink
  delcommand SynColor
endif

if &syntax=='idl'
  syn cluster idlCommentable add=doxygenComment,doxygenCommentL
endif

"syn sync clear
"syn sync maxlines=500
"syn sync minlines=50
if v:version >= 600
syn sync match doxygenComment groupthere cComment "/\@<!/\*"
syn sync match doxygenSyncComment grouphere doxygenComment "/\@<!/\*[*!]"
else
syn sync match doxygencComment groupthere cComment "/\*"
syn sync match doxygenSyncComment grouphere doxygenComment "/\*[*!]"
endif
"syn sync match doxygenSyncComment grouphere doxygenComment "/\*[*!]" contains=doxygenStart,doxygenTODO keepend
syn sync match doxygenSyncEndComment groupthere NONE "\*/"

if !exists('b:current_syntax') || b:current_syntax == ''
  let b:current_syntax = "doxygen"
else
  let b:current_syntax = b:current_syntax.'+doxygen'
endif

let &cpo = s:cpo_save
unlet s:cpo_save
" vim:et ts=2 sw=2
