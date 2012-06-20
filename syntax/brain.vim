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
syn match pendingWhat /?\S\S*/ contains=questionMark
syn match questionMark /?/ contained

syn region projectFold start="^\S" skip="^\s\s*" end="^" fold transparent keepend
syn region doneFold start="^\s\s*-\s" skip="^\s\s*-\s" end="^" fold transparent

hi projectName cterm=bold gui=bold
hi isPending ctermfg=darkgrey cterm=bold guifg=darkgrey
hi isDone ctermfg=darkgrey guifg=grey
hi link questionMark isPending
hi link isTag Identifier
hi link nextAction PreProc
hi link isDate Type
hi link pendingWhat Statement

function! BrainFoldText()
	let l = getline(v:foldstart)
	return l . " +-" . v:folddashes
endfunction

setlocal foldmethod=syntax
"setlocal foldnestmax=2
"setlocal foldexpr=getline(v:lnum)[0]=~'\\s'
"setlocal foldminlines=3
setlocal foldopen=block,hor,mark,percent,quickfix,tag,undo
setlocal foldtext=BrainFoldText()

" Set [n]ext action
nmap <buffer> <localleader>n I> dd?^\Sp
" [s]how next actions
nmap <buffer> <localleader>s :g/^[^# \t]\\|^\s*>
" [d]o task
nmap <silent><buffer> <localleader>d :silent! s/^\(\s*\)>\s*/\1/I=strftime("- %Y-%m-%d ")dd?^\S/^\S\\|^$P

