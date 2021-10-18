" Leader key
let g:mapleader = "\<Space>"
let g:maplocalleader = ','

" If the local leader is a comma, map double-tap comma to its original
" function in the relevant modes so that I can still use it quickly without
" relying on mapping 'timeout'.
"
if maplocalleader ==# ','
  noremap ,,
        \ ,
  sunmap ,,
endif

nnoremap <Leader>v :next $MYVIMRC<CR>

" Remove all trailing whitespaces
nnoremap <silent> <leader>rs :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

" Copy and paste from the system clipboard, and avoid indentation issues:
noremap <leader>y "+y
noremap <leader>p "+p

" Move visual selection up and down a line:
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Quickly re-select either the last pasted or changed text:
noremap gV `[v`]

" Format a paragraph or visual selection to 80 character lines:
" Taken from: https://github.com/nickjj/dotfiles/blob/599f90a959f58c4ba3b771c9d933f2eeb83eef94/.vimrc#L305
nnoremap <Leader>g gqap 
xnoremap <Leader>g gqa

" Run the recorded macro on a range of lines:
" Credit goes to https://github.com/stoeffel/.dotfiles/blob/master/vim/visual-at.vim
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

function! ExecuteMacroOverVisualRange()
    echo "@".getcmdline()
    execute ":'<,'>normal @".nr2char(getchar())
endfunction

" swapping the colon and semi-colon keys means 1 less keypress:
nnoremap ; :
nnoremap : ;


" Nicer Navigation

" Allows the cursor to move up and down naturally by display, lines instead of file lines:
nnoremap j gj
nnoremap k gk

" Make yanking with capital Y behave like the other capital letters, and yank until the end of the line:
nnoremap Y y$

" Press space to go down 10 lines, control + space to go up 10 lines:
noremap <Space> 10j
noremap <C-Space> 10k

" if there's an issue with ctrl-space, you can use <C-@> or <Nul>
" Ref: https://stackoverflow.com/a/24983736
noremap <C-@> 10k

" File and Buffer Navigation (but better)

" Press space twice to switch between your last two buffers, use it all the time for superfast switching:
nnoremap <leader><leader> <c-^>

" Switch buffers with Left and Right arrow keys:
nnoremap <left> :bp<cr>
nnoremap <right> :bn<cr>

" Tom Ryder vimrc
" Press your 'leader' key + enter to clear search highlighting:
" nnoremap <silent> <leader><CR> :noh<CR>

" I end up hitting CTRL-L to clear or redraw the screen in interactive shells
" and tools like Mutt and Vim pretty often.  It feels natural to me to stack
" issuing a :nohlsearch command to stop highlighting searches on top of this.
"
" This gets by far the most use in normal mode, but I’d like it to work in
" insert and visual modes, too, where it’s occasionally useful, especially on
" things like mobile phone terminal emulators that can be choppy and require
" a lot of redrawing.
"
" For each of these, we end the mapping with a CTRL-L in normal mode, thereby
" extending rather than replacing Vim’s normal behavior.
"
nnoremap <C-L>
      \ :<C-U>nohlsearch<CR><C-L>

" The insert mode wrapper for normal CTRL-L uses i_CTRL-O to issue a single
" normal mode command.  We intentionally use ‘:normal’ rather than ‘:normal!’
" so that the mapping works recursively.  I tried using <C-O><C-L> with :imap
" for this, but it didn’t work.  Maybe i_CTRL-O doesn’t respect mappings.
" I couldn’t find any documentation about it.
"
inoremap <C-L>
      \ <C-O>:execute "normal \<C-L>"<CR>

" We use :vmap here rather than :xmap to have the mapping applied for select
" mode as well as visual mode.  This is because CTRL-L doesn’t reflect
" a printable character, and so we don't shadow anything by making it work,
" even though I don’t actually use select mode directly very much.
"
vmap <C-L>
      \ <Esc><C-L>gv

"" Leader,C toggles highlighted cursor column; works in visual mode
nnoremap <Leader>C
      \ :<C-U>set cursorcolumn! cursorcolumn?<CR>

" Toggle spell check.
nnoremap <Leader>o :setlocal spell!<CR>

" Open Netwr
nnoremap <leader>df :Lexplore %:p:h<CR>
nnoremap <Leader>da :Lexplore<CR>

" Change Font size
" nnoremap <F12> :call fonts#FontSizePlus()<cr>
" nnoremap <S-F12> :call fonts#FontSizeMinus()<cr>
" nnoremap cot :call fonts#CycleFont()<cr>
nnoremap <F12> :call fonts#CycleFont()<cr>
call fonts#ResetFont()

" for using Man with cppman only for c, c++ buffers
nmap <buffer>K <Plug>CppManfunc

" shortcuts for opening files located in the same directory as the current file
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
map <leader>ew :e %%
