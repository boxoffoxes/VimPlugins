" Vim syntax file
" Language:	Funeral

"syn spell toplevel
"syn case ignore
"syn sync linebreaks=1

"syn match ref /$\S*/
syn region String start='"' end='"'
syn region bqStr start='`' end='`' contains=String

syn match Comment /--.*/
"syn match quoted /'"[^"]*"/
syn match quoted /'\S*/
syn match quoted /[\[\]]/ 
syn match Character /\../

syn keyword Special def True False
syn keyword Conditional ifte doif and or TEST

hi link ref Type
hi link quoted Type
hi link bqStr PreProc

"hi hasPriW ctermfg=darkgrey cterm=bold guifg=darkgrey



