" .............................................................................
" SirVer/ultisnips
" .............................................................................
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsListSnippets="<c-tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"


" let g:UltiSnipsJumpForwardTrigger="<tab>"
" let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" let g:UltiSnipsExpandTrigger="<tab>"
" list all snippets for current filetype
" let g:UltiSnipsListSnippets="<c-s>"

let g:UltiSnipsSnippetDirectories=["UltiSnips", $HOME.'/.vim/ultisnips/']

let s:dir = $HOME.'/.vim/ultisnips/'
if !isdirectory(s:dir)
    call mkdir(s:dir, 'p', 0700)
endif

let g:UltiSnipsSnippetStorageDirectoryForUltiSnipsEdit=s:dir
