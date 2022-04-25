" .............................................................................
" SirVer/ultisnips
" .............................................................................
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsListSnippets="<S-tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsSnippetDirectories=["UltiSnips", $HOME.'/.vim/ultisnips/']

let s:dir = $HOME.'/.vim/ultisnips/'
if !isdirectory(s:dir)
    call mkdir(s:dir, 'p', 0700)
endif

let g:UltiSnipsSnippetStorageDirectoryForUltiSnipsEdit=s:dir

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
