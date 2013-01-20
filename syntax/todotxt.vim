" Vim syntax file
" Language:	todo.txt

syn spell toplevel
" syn case ignore
syn sync linebreaks=1

syn match isKeyword /\(if\|then\)/ contained
syn match inProject /+\S\S*/
syn match inContext /@\S\S*/
syn match isDate    /\d\d\d\d-\d\d-\d\d/
syn match ticker    /\( (\d\+)\)\? [.:]*$/

syn match hasPriA   /^(A) .*/ contains=inProject,inContext,isDate
syn match hasPriB   /^(B) .*/ contains=inProject,inContext,isDate
syn match hasPriC   /^(C) .*/ contains=inProject,inContext,isDate
syn match hasPriW   /^([WZ]) .*/ contains=inProject,inContext,isDate
syn match hasPri    /^([D-VXY]) .*/ contains=inProject,inContext,isDate
syn match isDone    /^x .*/ contains=isDate
syn match isIfThen  /\(^if\| if\) .* then / contains=isKeyword,inProject,inContext,isDate


hi isDone ctermfg=darkgrey guifg=grey
hi CursorLine cterm=bold gui=bold
hi link inProject Constant
hi link inContext Identifier
hi link hasPriA Todo
hi link hasPriB Statement
hi link hasPriC PreProc
hi hasPriW ctermfg=darkgrey cterm=bold guifg=darkgrey
hi link hasPri Special
hi link isDate Type
hi link ticker Type
hi link isKeyword PreProc

setlocal cursorline
setlocal foldmethod=expr
setlocal foldexpr=getline(v:lnum)=~'x\\s'
setlocal foldminlines=10
setlocal foldopen=block,hor,mark,percent,quickfix,tag,undo


" [n]ext task
nmap <buffer> <localleader>n /^[^x]
" [D]o-and-re-add task
nmap <silent> <buffer> <localleader>D yy<localleader>PI=strftime("x %Y-%m-%d ")Gp``<localleader>n
" [d]one task
nmap <silent> <buffer> <localleader>d <localleader>PI=strftime("x %Y-%m-%d ")<localleader>n
" [a]dd new task
nmap <buffer> <localleader>a Go
" [h]ighlight project under cursor
nmap <buffer> <localleader>h :exe printf('match Error /+\<%s\>/', expand('<cword>'))
" [p]rioritise task
nmap <buffer> <localleader>p I( ) hhr
" de[P]rioritise task
nmap <buffer> <localleader>P :silent! s/^(.) //
" [t]ick ongoing task
nmap <buffer> <localleader>t A.:silent! s/\(\.\.\.\.\)\.$/\1:/
" clear [T]icker
nmap <buffer> <localleader>T :silent! s/\( (\(\d*\)) \)\?\([.:]*\)$/\=" (" . max( [ submatch(2), strlen(submatch(3)) ] ) . ") " /
" [A]rchive (sort completed to the top of the file, then dismissed, then waiting.
nmap <silent> <buffer> <localleader>A :sort /^x /:sort /^(Z) /gg/^x VGdggp



" next [m]arked
" nmap <buffer> <localleader>m /^[^=\-# \t].*\*$
" [N]ext done
" nmap <buffer> <localleader>N /^[-=] 
" [f]inish working on task for now
" nmap <silent> <buffer> <localleader>f <localleader>W<localleader>TyyGp``I=strftime("- [%Y-%m-%d] ")<localleader>n
" [F]inish task
" nmap <silent> <buffer> <localleader>F <localleader>W<localleader>TI=strftime("= [%Y-%m-%d] ")<localleader>n
" [c]omplete periodic task
"nmap <silent> <buffer> <localleader>c I=strftime("+ [%Y-%m-%d]
"")<localleader>n
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
" nmap <buffer> <localleader>u :s/^[-=] \[[^\[]*\] //<localleader>N
" [A]rchive (sort completed to the top of the file, then dismissed, then waiting.
" nmap <silent> <buffer> <localleader>A :sort /^[=\-] /:sort /^\s\+/:sort /^>/gg/^[=\-]VGdggp
" [w]aiting for someone
" nmap <buffer> <localleader>w I gI>
" un[W]ait the next waiting task
" nmap <buffer> <localleader>W :silent! s/^>\S\+\s\+//
