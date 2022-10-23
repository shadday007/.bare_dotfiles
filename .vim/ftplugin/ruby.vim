" Vim will load/evaluate code in order to provide completions.
let g:rubycomplete_buffer_loading = 1

" Vim can parse the entire buffer to add a list of
" classes to the completion results.
let g:rubycomplete_classes_in_global = 1

" - Vim can detect and load the Rails environment for files within a rails
" project. The feature is disabled by default, to enable it add >
let g:rubycomplete_rails = 1

" Optimizations required if you plan on open Ruby files.
setglobal regexpengine=1
setglobal ttyfast
