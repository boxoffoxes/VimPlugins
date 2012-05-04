" Vim syntax file
" Language:	todo.txt

syn spell toplevel
" syn case ignore
syn sync linebreaks=1

syn match inProject / +\S\S*/
syn match inContext / @\S\S*/
syn match isDate    /\d\d\d\d-\d\d-\d\d/

syn match hasPriA   /^(A) .*/ contains=inProject,inContext,isDate
syn match hasPriB   /^(B) .*/ contains=inProject,inContext,isDate
syn match hasPriC   /^(C) .*/ contains=inProject,inContext,isDate
syn match hasPriW   /^(W) .*/ contains=inProject,inContext,isDate
syn match hasPri    /^([D-VXYZ]) .*/ contains=inProject,inContext,isDate
syn match isDone    /^x .*/ " contains=inProject,inContext


hi isDone ctermfg=grey guifg=grey
hi CursorLine cterm=bold gui=bold
hi link inProject Constant
hi link inContext Identifier
hi link hasPriA Todo
hi link hasPriB Statement
hi link hasPriC PreProc
hi hasPriW ctermfg=darkgrey guifg=darkgrey
hi link hasPri Special
hi link isDate Type

setlocal cursorline


" [n]ext task
nmap <buffer> <localleader>n /^[^x]
" [d]one task
nmap <silent> <buffer> <localleader>d I=strftime("x %Y-%m-%d ")
" [a]dd new task
nmap <buffer> <localleader>a Go
" [h]ighlight project under cursor
nmap <buffer> <localleader>h :exe printf('match Error /+\<%s\>/', expand('<cword>'))
" [p]rioritise task
nmap <buffer> <localleader>p I( ) hhr
" de[P]rioritise task
nmap <buffer> <localleader>P :s/^(.) //
" [t]ick daily task
nmap <buffer> <localleader>t A.:silent! s/\(\.\.\.\.\)\.$/\1:/
" clear [T]icker
nmap <buffer> <localleader>T :silent! s/\( (\d*) \)\?\([.:]*\)$/\=" (" . strlen(submatch(2)) . ") " /



" next [m]arked
" nmap <buffer> <localleader>m /^[^=\-# \t].*\*$
" [N]ext done
" nmap <buffer> <localleader>N /^[-=] 
" [f]inish working on task for now
" nmap <silent> <buffer> <localleader>f <localleader>W<localleader>TyyGp``I=strftime("- [%Y-%m-%d] ")
" [F]inish task
" nmap <silent> <buffer> <localleader>F <localleader>W<localleader>TI=strftime("= [%Y-%m-%d] ")
" [c]omplete periodic task
"nmap <silent> <buffer> <localleader>c I=strftime("+ [%Y-%m-%d]
"")
" [d]ismiss
" nmap <silent> <buffer> <localleader>d I	
" [p]rev incomplete task
" nmap <buffer> <localleader>p ?^[^=\-# \t]
" [P]rev complete task
" nmap <buffer> <localleader>P ?^[=\-] 
" [t]ag active task
" nmap <silent> <buffer> <localleader>t <localleader>W^:s/\([^<]\)$/\1 <<<<</
" un[T]ag active task
" nmap <silent> <buffer> <localleader>T :silent! s/\s*<*$//
" [h]ighlight
" nmap <silent> <buffer> <localleader>h :s/\v\s?(\**)$/ \1*/
" [H]ighlight removal
" nmap <silent> <buffer> <localleader>H :s/\v ?\*$//
" [u]ndo
" nmap <buffer> <localleader>u :s/^[-=] \[[^\[]*\] //
" [A]rchive (sort completed to the top of the file, then dismissed, then waiting.
" nmap <silent> <buffer> <localleader>A :sort /^[=\-] /
" [w]aiting for someone
" nmap <buffer> <localleader>w I gI>
" un[W]ait the next waiting task
" nmap <buffer> <localleader>W :silent! s/^>\S\+\s\+//