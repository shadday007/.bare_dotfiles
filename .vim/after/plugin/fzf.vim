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
nnoremap <silent> <leader>f :FzfFiles<CR>
nnoremap <silent> <leader>F :FzfFiles /<CR>
nnoremap <silent> <leader>p :FzfMru<CR>
nnoremap <silent> <leader>b :FzfBuffers<CR>
nnoremap <silent> <leader>l :FzfBLines<CR>
nnoremap <silent> <leader>` :FzfMarks<CR>
nnoremap <silent> <leader>; :FzfCommands<CR>

" NOTE:Fzf BTags generates tags for the current buffer on a fly despite having project-wide 'tags'
nnoremap <silent> <leader>] :FzfBTags<CR>
nnoremap <silent> <leader>} :FzfTags<CR>
nnoremap <silent> <F1>      :FzfHelptags<CR>
inoremap <silent> <F1> <ESC>:FzfHelptags<CR>
cnoremap <silent> <expr> <C-p> getcmdtype() == ":" ? "<C-u>:FzfHistory:\<CR>" : "\<ESC>:FzfHistory/\<CR>"
cnoremap <silent> <C-_> <C-u>:FzfCommands<CR>

" MRU files. Adopted from 'pbogut/fzf-mru.vim'
" Native's "v:oldfiles" does not work, since v:oldfiles is read only on Vim startup
command! FzfMru call fzf#run(fzf#wrap(fzf#vim#with_preview({
      \ 'source':  fzf_mru#mrufiles#source(),
      \ 'options': ['--preview-window', 'noborder', '-m', '--prompt', 'MRU> ', '+s', '--preview-window', 'right:50%' ] })))
command! -nargs=0 RefreshFzfMru call fzf_mru#mrufiles#refresh()

" Override 'FzfCommands' command to fuzzy search only by 2nd column (command name)
" <Enter> to pick command but not execute, <C-x> to execute immediately
command! -nargs=0 FzfCommands call fzf#vim#commands({ 'options': ['--nth', '2'] })

