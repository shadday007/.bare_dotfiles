if !exists('g:loaded_fzf')
    finish
endif

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" File path completion in Insert mode using fzf
" Enhance native <C-x> insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-buffer-line)

" Mappings
nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>F :Files /<CR>
nnoremap <silent> <leader>p :Mru<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>l :BLines<CR>
nnoremap <silent> <leader>` :Marks<CR>
nnoremap <silent> <leader>; :Commands<CR>

" NOTE: BTags generates tags for the current buffer on a fly despite having project-wide 'tags'
nnoremap <silent> <leader>] :BTags<CR>
nnoremap <silent> <leader>} :Tags<CR>
nnoremap <silent> <F1>      :Helptags<CR>
inoremap <silent> <F1> <ESC>:Helptags<CR>
cnoremap <silent> <expr> <C-p> getcmdtype() == ":" ? "<C-u>:History:\<CR>" : "\<ESC>:History/\<CR>"
cnoremap <silent> <C-_> <C-u>:Commands<CR>

