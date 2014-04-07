
" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded

" Read the C syntax to start with
if version < 600
  so <sfile>:p:h/doxygen.vim
else
  runtime! syntax/doxygen.vim
  unlet b:current_syntax
endif

" C++11 modifications

syn keyword cpp0xConstant      nullptr
syn keyword cpp0xStorageClass  constexpr noexcept override final
syn keyword cpp0xType          decltype

hi link cpp0xConstant      Constant
hi link cpp0xStorageClass  StorageClass
hi link cpp0xType          Type
