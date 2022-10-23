" mappings general ( not plugins ) .{{{
" Remove all trailing whitespaces{{{
nnoremap <silent> <leader>rs :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>
"}}}

" Copy and paste from the system clipboard, and avoid indentation issues:{{{
noremap <leader>y "+y
noremap <leader>p "+p
" always use system clipboard as unnamed register
" Detect when system clipboard changes and sync it with yank unnamed register
set clipboard=unnamed,unnamedplus
"}}}

" Use <Bslash> instead of <C-w>, which is tough to type{{{
nmap <Bslash> <C-w>
"}}}

" Move visual selection up and down a line:{{{
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
"}}}

" Quickly re-select either the last pasted or changed text:{{{
noremap gV `[v`]
"}}}

" Format a paragraph or visual selection to 80 character lines:{{{
" Taken from: https://github.com/nickjj/dotfiles/blob/599f90a959f58c4ba3b771c9d933f2eeb83eef94/.vimrc#L305
nnoremap <Leader>g gqap
xnoremap <Leader>g gqa
"}}}

" Run the recorded macro on a range of lines:{{{
" Credit goes to https://github.com/stoeffel/.dotfiles/blob/master/vim/visual-at.vim
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

function! ExecuteMacroOverVisualRange()
    echo "@".getcmdline()
    execute ":'<,'>normal @".nr2char(getchar())
endfunction
"}}}

" swapping the colon and semi-colon keys means 1 less keypress:{{{
nnoremap ; :
nnoremap : ;
"}}}

" Make dot work on visual line selections.{{{
xnoremap . :norm.<CR>
"}}}

" In insert or command mode, move normally by using Ctrl {{{
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
" Bash like
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-d> <Delete>

" Command mode shortcut
cnoremap <C-h> <Left>
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>
cnoremap <C-l> <Right>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-d> <Delete>

" Nicer Navigation
map <C-j> <c-w>j
map <C-k> <c-w>k
map <C-l> <c-w>l
map <C-h> <c-w>h

map <C-LEFT> <C-w>h
map <C-DOWN> <C-w>j
map <C-UP> <C-w>k
map <C-RIGHT> <C-w>l

nnoremap <S-LEFT> :vertical resize +5 <Cr>
nnoremap <S-RIGHT> :vertical resize -5 <Cr>
nnoremap <S-UP> :resize +5 <Cr>
nnoremap <S-DOWN> :resize -5 <Cr>

"}}}

" Allows the cursor to move up and down naturally by display, lines instead of file lines:{{{
nnoremap j gj
nnoremap k gk
"}}}

" Make yanking with capital Y behave like the other capital letters, and yank until the end of the line:{{{
nnoremap Y y$
"}}}

" Press space to go down 10 lines, control + space to go up 10 lines:{{{
noremap <Space>   10j
noremap <C-Space> 10k
"}}}

" if there's an issue with ctrl-space, you can use <C-@> or <Nul>{{{
" Ref: https://stackoverflow.com/a/24983736
noremap <C-@> 10k
"}}}

" File and Buffer Navigation (but better)

" Press space twice to switch between your last two buffers, use it all the time for superfast switching:{{{
nnoremap <leader><leader> <c-^>
"}}}

" Switch buffers with Left and Right arrow keys:{{{
nnoremap <left>  :bp<cr>
nnoremap <right> :bn<cr>
"}}}

" Press your 'leader' key + enter to toggle search highlighting:{{{
nnoremap <leader><CR> :set hlsearch! hlsearch?<CR>
" nnoremap :nohlsearch <CR>
" nnoremap  <F3>   :nohlsearch<CR>
" vnoremap  <F3>   <ESC>:nohlsearch<CR>

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
"nnoremap <C-L>
"      \ :<C-U>nohlsearch<CR><C-L>

" The insert mode wrapper for normal CTRL-L uses i_CTRL-O to issue a single
" normal mode command.  We intentionally use ‘:normal’ rather than ‘:normal!’
" so that the mapping works recursively.  I tried using <C-O><C-L> with :imap
" for this, but it didn’t work.  Maybe i_CTRL-O doesn’t respect mappings.
" I couldn’t find any documentation about it.
"
"inoremap <C-L>
"      \ <C-O>:execute "normal \<C-L>"<CR>

" We use :vmap here rather than :xmap to have the mapping applied for select
" mode as well as visual mode.  This is because CTRL-L doesn’t reflect
" a printable character, and so we don't shadow anything by making it work,
" even though I don’t actually use select mode directly very much.
"
"vmap <C-L>
"      \ <Esc><C-L>gv
"}}}
"" Leader,C toggles highlighted cursor column; works in visual mode.{{{

nnoremap <Leader>C
      \ :<C-U>set cursorcolumn! cursorcolumn?<CR>
"}}}

" Toggle spell check.{{{
nnoremap <Leader>O :setlocal spell!<CR>
inoremap <C-s> <c-g>u<Esc>[s1z=`]a<c-g>u
"}}}

" Change Font size{{{
" nnoremap <F12> :call fonts#FontSizePlus()<cr>
" nnoremap <S-F12> :call fonts#FontSizeMinus()<cr>
" nnoremap cot :call fonts#CycleFont()<cr>
nnoremap <F12> :call fonts#CycleFont()<cr>
call fonts#ResetFont()
"}}}

" for using Man with cppman only for c, c++ buffers{{{
" nmap <buffer>K <Plug>CppManfunc
"}}}

" shortcuts for opening files located in the same directory as the current file{{{
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
map <leader>ew :e %%
"}}}

" Insert the current line into the command line{{{
" https://gist.github.com/romainl/fc2c2889be3718e9e491ab1c525ec4de
if !has('patch-8.0.1787')
    cnoremap <C-r><C-l> <C-r>=getline('.')<CR>
endif
"}}}

"}}}
" Press * to search for the term under the cursor or a visual selection and
" then press a key below to replace all instances of it in the current file.
nnoremap <Leader>r :%s///g<Left><Left>
nnoremap <Leader>rc :%s///gc<Left><Left><Left>

" The same as above but instead of acting on the whole file it will be
" restricted to the previously visually selected range. You can do that by
" pressing *, visually selecting the range you want it to apply to and then
" press a key below to replace all instances of it in the current selection.
xnoremap <Leader>r :s///g<Left><Left>
xnoremap <Leader>rc :s///gc<Left><Left><Left>

" Type a replacement term and press . to repeat the replacement again. Useful
" for replacing a few instances of the term (comparable to multiple cursors).
" nnoremap <silent> s* :let @/='\<'.expand('<cword>').'\>'<CR>cgn
" xnoremap <silent> s* "sy:let @/=@s<CR>cgn


