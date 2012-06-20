" Vim syntax file
" Language:	brain.txt

syn spell toplevel
syn case ignore
syn sync linebreaks=1

syn match projectName /^\S.*$/ contains=isTag,isDate,pendingWhat
syn match isDone	/^\s*[-] .*$/ contains=isDate,isTag
syn match isPending /^\s*?.*/ contains=isTag,pendingWhat
syn match Comment /^\s*#.*$/  contains=isTag
syn match nextAction /^\s*>.*/ contains=isTag

syn match isDate    /\d\d\d\d-\d\d-\d\d/
syn match isTag /+\S\S*/
syn match pendingWhat /?\S\S*/

syn region projectFold start="^\S" skip="^\s\s*" end="^" fold transparent

hi projectName cterm=bold gui=bold
hi isPending ctermfg=darkgrey cterm=bold guifg=darkgrey
hi isDone ctermfg=darkgrey guifg=grey
hi link isTag Identifier
hi link nextAction PreProc
hi link isDate Type
hi link pendingWhat Statement

setlocal foldmethod=syntax
"setlocal foldnestmax=2
"setlocal foldexpr=getline(v:lnum)[0]=~'\\s'
"setlocal foldminlines=3
setlocal foldopen=block,hor,mark,percent,quickfix,tag,undo

" Set [n]ext action
nmap <buffer> <localleader>n I> dd?^\Sp
" [s]how next actions
nmap <buffer> <localleader>s :g/^[^# \t]\\|^\s*>
" [d]o task
nmap <silent><buffer> <localleader>d :silent! s/^\(\s*\)>\s*/\1/I=strftime("- %Y-%m-%d ")dd/^\S\\|^$P

" next [m]arked
"nmap <buffer> <localleader>m /^[^=\-# \t].*\*$
" [N]ext done
"nmap <buffer> <localleader>N /^[-=] 
" [f]inish working on task for now
"nmap <silent> <buffer> <localleader>f <localleader>W<localleader>TyyGp``I=strftime("- [%Y-%m-%d] ")<localleader>n
" [F]inish task
"nmap <silent> <buffer> <localleader>F <localleader>W<localleader>TI=strftime("= [%Y-%m-%d] ")<localleader>n
" [c]omplete periodic task
"nmap <silent> <buffer> <localleader>c I=strftime("+ [%Y-%m-%d]
"")<localleader>n
" [d]ismiss
"nmap <silent> <buffer> <localleader>d I	
" [p]rev incomplete task
"nmap <buffer> <localleader>p ?^[^=\-# \t]
" [P]rev complete task
"nmap <buffer> <localleader>P ?^[=\-] 
" [a]dd new task
"nmap <buffer> <localleader>a Go
" [t]ag active task
"nmap <silent> <buffer> <localleader>t <localleader>W^:s/\([^<]\)$/\1 <<<<</
" un[T]ag active task
"nmap <silent> <buffer> <localleader>T :silent! s/\s*<*$//
" [h]ighlight
"nmap <silent> <buffer> <localleader>h :s/\v\s?(\**)$/ \1*/
" [H]ighlight removal
"nmap <silent> <buffer> <localleader>H :s/\v ?\*$//
" [u]ndo
"nmap <buffer> <localleader>u :s/^[-=] \[[^\[]*\] //<localleader>N
" [A]rchive (sort completed to the top of the file, then dismissed, then waiting.
"nmap <silent> <buffer> <localleader>A :sort /^[=\-] /:sort /^\s\+/:sort /^>/gg/^[=\-]VGdggp
" [w]aiting for someone
"nmap <buffer> <localleader>w I gI>
" un[W]ait the next waiting task
"nmap <buffer> <localleader>W :silent! s/^>\S\+\s\+//
