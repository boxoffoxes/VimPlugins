" Vim syntax file
" Language:	Autofocus

syn spell toplevel
syn case ignore
syn sync linebreaks=1

syn match inProject / +\S\S*/
syn match inContext / @\S\S*/
syn match waitingFor /^>\S\S*/ "contains=todaysDate

syn match isWaiting /^>\S\S*.*$/ contains=inContext,inProject,waitingFor
syn match markOne	/^.* \*$/ contains=inProject,inContext,waitingFor
syn match markTwo	/^.* \*\*$/ contains=inProject,inContext,waitingFor
syn match markThree	/^.* \*\*\*$/ contains=inProject,inContext,waitingFor
syn match markFour	/^.* \*\*\*\*\**$/ contains=inProject,inContext,waitingFor

syn match inProgress	/^.* <\+$/ contains=inProject,inContext
syn match isDone	/^[-=] .*$/
syn match isDismissed	/^\s.*$/ contains=inProject,inContext,waitingFor
syn match isDivider	/^$/
syn match Comment	/^#.*$/

" syn match todaysDate /\=strftime("%F")/

hi link inProgress Todo
hi link waitingFor Todo

hi link inProject Constant
hi link inContext Identifier

hi link markOne Type
hi link markTwo Statement
hi link markThree Special
hi link markFour Error
" hi link todaysDate Error

hi isDone ctermfg=grey guifg=grey
hi link isDismissed PreProc
hi CursorLine cterm=bold gui=bold

hi isWaiting ctermfg=darkgrey guifg=darkgrey

setlocal cursorline
setlocal foldmethod=expr
setlocal foldexpr=getline(v:lnum)[0]=~'[=\-]'
setlocal foldminlines=10
setlocal foldopen=block,hor,mark,percent,quickfix,tag,undo

" [n]ext
nmap <buffer> <localleader>n /^[^=\-# \t]
" next [m]arked
nmap <buffer> <localleader>m /^[^=\-# \t].*\*$
" [N]ext done
nmap <buffer> <localleader>N /^[-=] 
" [f]inish working on task for now
nmap <silent> <buffer> <localleader>f <localleader>W<localleader>TyyGp``I=strftime("- [%Y-%m-%d] ")<localleader>n
" [F]inish task
nmap <silent> <buffer> <localleader>F <localleader>W<localleader>TI=strftime("= [%Y-%m-%d] ")<localleader>n
" [c]omplete periodic task
"nmap <silent> <buffer> <localleader>c I=strftime("+ [%Y-%m-%d]
"")<localleader>n
" [d]ismiss
nmap <silent> <buffer> <localleader>d I	
" [p]rev incomplete task
nmap <buffer> <localleader>p ?^[^=\-# \t]
" [P]rev complete task
nmap <buffer> <localleader>P ?^[=\-] 
" [a]dd new task
nmap <buffer> <localleader>a Go
" [t]ag active task
nmap <silent> <buffer> <localleader>t <localleader>W^:s/\([^<]\)$/\1 <<<<</
" un[T]ag active task
nmap <silent> <buffer> <localleader>T :silent! s/\s*<*$//
" [h]ighlight
nmap <silent> <buffer> <localleader>h :s/\v\s?(\**)$/ \1*/
" [H]ighlight removal
nmap <silent> <buffer> <localleader>H :s/\v ?\*$//
" [u]ndo
nmap <buffer> <localleader>u :s/^[-=] \[[^\[]*\] //<localleader>N
" [A]rchive (sort completed to the top of the file, then dismissed, then waiting.
nmap <silent> <buffer> <localleader>A :sort /^[=\-] /:sort /^\s\+/:sort /^>/gg/^[=\-]VGdggp
" [w]aiting for someone
nmap <buffer> <localleader>w I gI>
" un[W]ait the next waiting task
nmap <buffer> <localleader>W :silent! s/^>\S\+\s\+//
