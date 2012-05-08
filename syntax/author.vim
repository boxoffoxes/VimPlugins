" Vim syntax file
" Language:	SRL Author

"syn spell toplevel
syn case ignore
"syn sync linebreaks=1

syn match ref /$\S*/
syn region dqStr start='"' end='"' contains=sqStr,bqStr
syn region sqStr start='\'' end='\'' contains=dqStr,bqStr
syn region bqStr start='`' end='`' contains=sqStr,dqStr

syn match id /[^=]*/ contained
syn match def /\S*\s*=/ contains=id
"syn match app /[a-z0-9]\+\s*[^=]/

hi link ref Type
hi link dqStr String
hi link bqStr Special
hi link sqStr Identifier
hi link id Define

"hi hasPriW ctermfg=darkgrey cterm=bold guifg=darkgrey



