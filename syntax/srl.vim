" Vim syntax file
" Language: SRL text for SITS, optionally embedded in XHTML

runtime! autoload/htmlcomplete.vim
runtime! syntax/xhtml.vim

set omnifunc=htmlcomplete#CompleteTags

syn spell toplevel
syn case ignore
syn sync linebreaks=1

syn match srlSpecialChar /·[*?&|!=><;]/
syn match srlInvalidChar /·[^*?&|!=><;]/
syn match srlFormat /&[^>]/ contained contains=srlSpecialChar
syn match srlFieldName /[a-z]\{3,4\}?_[a-z]\{4\}\(\.[a-z]\{3,4\}\)?/

syn region srlField start="<<" end=">>" contains=srlFormat,srlSpecialChar,srlFieldName,srlInvalidChar
syn region srlCond start=/{{.*:/ end="}}" contains=srlField,srlSpecialChar,srlList,srlInvalidChar
syn region srlList start="\[\[" end="\]\]" contains=srlField,srlSpecialChar,srlCond,srlInvalidChar

map <buffer> <kPlus> ·
map <buffer> <kMultiply> ·*
map <buffer> <kDivide> ·?

hi link srlInvalidChar Error
hi link srlFieldName Statement
hi link srlSpecialChar Constant
hi link srlFormat PreProc
hi link srlField Type
hi link srlCond Special
hi link srlList Identifier
