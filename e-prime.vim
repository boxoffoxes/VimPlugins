

setlocal iskeyword+='
syn case ignore 
syn keyword EPrime be being been am is are was were maybe
syn match EPrime /\<\(isn't\|aren't\|wasn't\|weren't\|I'm\|you're\|we're\|they're\|he's\|she's\|it's\|there's\|here's\|where's\|how's\|what's\|who's\|that's\)\>/

hi EPrime gui=undercurl guisp=Yellow ctermfg=2
