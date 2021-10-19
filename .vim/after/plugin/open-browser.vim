" configuration for open-browser plugin

if !exists('g:loaded_openbrowser')
    finish
endif

let g:openbrowser_search_engines = extend(
\   get(g:, 'openbrowser_search_engines', {}),
\   {
\       'github': 'http://github.com/search?q=fork%3Afalse+{query}',
\       'github-c': 'http://github.com/search?l=C&q=fork%3Afalse+language%3AC+{query}&type=Code',
\       'github-cpp': 'http://github.com/search?l=C%2B%2B&q=fork%3Afalse+language%3AC%2B%2B+{query}&type=Code',
\       'github-python': 'http://github.com/search?l=Python&q=fork%3Afalse+language%3APython+{query}&type=Code',
\       'github-ocaml': 'http://github.com/search?l=OCaml&q=fork%3Afalse+language%3AOCaml+{query}&type=Code',
\       'github-rust': 'http://github.com/search?l=Rust&q=fork%3Afalse+language%3APython+{query}&type=Code',
\       'github-vimscript': 'http://github.com/search?l=Vim+script&q=fork%3Afalse+language%3Avimscript+{query}&type=Code',
\       'grep-app': 'https://grep.app/search?q={query}&case=true',
\       'google': 'http://google.com/search?q={query}',
\       'google-translate': 'https://translate.google.com/?hl=es-419&sl=auto&tl=es&text={query}%0A&op=translate',
\       'debian-code-search': 'https://codesearch.debian.net/search?q={query}',
\       'cppreference': 'https://en.cppreference.com/mwiki/index.php?title=Special%3ASearch&search={query}',
\       'qt': 'https://doc.qt.io/qt-5/search-results.html?q={query}',
\       'python': 'http://docs.python.org/dev/search.html?q={query}&check_keywords=yes&area=default',
\       'rust': 'https://doc.rust-lang.org/std/index.html?search={query}',
\   },
\   'keep'
\)
let g:openbrowser_default_search = 'google'

" Search selected visually selected word with appropriate search engine.
nnoremap <silent> <leader>os <Plug>(openbrowser-smart-search)
nnoremap <silent> <leader>osg :call openbrowser#smart_search(expand('<cWORD>'), "google")<CR>
" Translate
nnoremap <silent> <leader>otr :call openbrowser#smart_search(expand('<cWORD>'), "google-translate")<CR>
" Github
nnoremap <silent> <leader>ogg :call openbrowser#smart_search(expand('<cWORD>'), "github")<CR>
nnoremap <silent> <leader>ogc :call openbrowser#smart_search(expand('<cWORD>'), "github-c")<CR>
nnoremap <silent> <leader>ogx :call openbrowser#smart_search(expand('<cWORD>'), "github-cpp")<CR>
nnoremap <silent> <leader>ogp :call openbrowser#smart_search(expand('<cWORD>'), "github-python")<CR>
nnoremap <silent> <leader>ogo :call openbrowser#smart_search(expand('<cWORD>'), "github-ocaml")<CR>
nnoremap <silent> <leader>ogr :call openbrowser#smart_search(expand('<cWORD>'), "github-rust")<CR>
nnoremap <silent> <leader>ogv :call openbrowser#smart_search(expand('<cWORD>'), "github-vimscript")<CR>
" grep.app
nnoremap <silent> <leader>osa :call openbrowser#smart_search(expand('<cWORD>'), "grep-app")<CR>
" Documentation
nnoremap <silent> <leader>osx :call openbrowser#smart_search(expand('<cWORD>'), "cppreference")<CR>
nnoremap <silent> <leader>osq :call openbrowser#smart_search(expand('<cWORD>'), "qt")<CR>
nnoremap <silent> <leader>osp :call openbrowser#smart_search(expand('<cWORD>'), "python")<CR>
nnoremap <silent> <leader>osr :call openbrowser#smart_search(expand('<cWORD>'), "rust")<CR>
