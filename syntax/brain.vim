" Vim syntax file
" Language:	brain.txt

syn spell toplevel
syn case ignore
syn sync linebreaks=1

syn match projectName /^\S.*$/ contains=isTag,isDate,pendingWhat,wedge
syn match isDone	/^\s*- .*$/ contains=isDate,isTag,doneMark
syn match isPending /^\s*?.*/ contains=isTag,pendingWhat
syn match Comment /^\s*#.*$/  contains=isTag
syn match nextAction /^\s*>.*/ contains=isTag

syn match isDate    /\d\d\d\d-\d\d-\d\d/
syn match isTag /^+\S\S*\|\s+\S\S*/ contains=questionMark
syn match pendingWhat /^?\S\S*\|\s?\S\S*/ contains=questionMark

syn match questionMark /[?+]/ contained
syn match wedge /@$/ contained
syn match doneMark /^\s*-/ contained

" syn match noteBoundary /^\~\~\~.*$/ contained

syn region projectFold start="^\S.*[^@]$" skip="^\s\s*" end="^" fold transparent keepend
syn region doneFold start="^\s\s*-\s" skip="^\s\s*-\s" end="^" fold transparent
syn region note start="^\~\~\~ .*$" end="^\~\~\~\~*$" fold 
" contains=noteBoundary



hi projectName cterm=bold gui=bold
hi isPending ctermfg=darkgrey cterm=bold guifg=darkgrey
hi isDone ctermfg=darkgrey guifg=grey
hi link questionMark isPending
hi link isTag Type
hi link nextAction Constant
hi link isDate Special
hi link doneMark Special
hi link pendingWhat Statement
hi link wedge PreProc
hi link note NONE
hi link noteBoundary Identifier

hi! link Folded PreProc

function! BrainFoldText()
	let l = getline(v:foldstart)
	return l . " +-" . v:folddashes
endfunction

setlocal foldmethod=syntax
setlocal foldnestmax=2
"setlocal foldexpr=getline(v:lnum)[0]=~'\\s'
setlocal foldminlines=3
setlocal foldopen=block,hor,mark,percent,quickfix,tag,undo
setlocal foldtext=BrainFoldText()

map <buffer><expr> <A-space> "\u00a0"

" Toggle [n]ext action
nmap <silent><buffer> <localleader>n :s/^\(\s*\)\(>\?\s*\)/\=submatch(1) . ( submatch(2) == '' ? '> ' : '' )/
" [s]how next actions
nmap <buffer> <localleader>s :g/^[^# \t]\\|^\s*>
" [d]o task
nmap <silent><buffer> <localleader>d :silent! s/^\(\s*\)>\s*/\1/I=strftime("- %Y-%m-%d ")ddmz?^\S/^\S\\|^$P`z
" [f]inish project
nmap <silent><buffer> <localleader>f l?^\SI=strftime("- %Y-%m-%d ")
" toggle task on-[h]old
nmap <silent><buffer> <localleader>h :s/^\(\s*\)\(?\s\s*\)\?/\=submatch(1) . ( submatch(2) == '' ? '? ' : '' )/
" [w]aiting for someone
nmap <silent><buffer> <localleader>w :s/^\(\s*\)\(?\s\s*\)\?/\1? /a
" no longer [W]aiting
nmap <silent><buffer> <localleader>W :s/^\(\s*\)\(?\S*\s\s*\)\?/\1/
" toggle always [o]pen fold
nmap <silent><buffer> <localleader>o :silent! foldopen^l?^\S:s/^\(.\{-}\)\(\s*@\)\?$/\=submatch(1) . ( submatch(2) == '' ? ' @' : '' )/
" append non-breaking space (for + and ? tags)
"nmap <buffer> <localleader><space> a="\u00a0"

