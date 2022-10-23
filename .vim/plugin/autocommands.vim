
if has('autocmd')

    function! s:autocommands()

        augroup autocommands

            autocmd!

            " Create directories before write
            " [1]: https://stackoverflow.com/questions/4292733/vim-creating-parent-directories-on-save
            autocmd BufWritePre * if expand("<afile>")!~#'^\w\+:/' && !isdirectory(expand("%:h")) | execute "silent! !mkdir -p ".shellescape(expand('%:h'), 1) | redraw! | endif

            " Auto-resize splits when Vim gets resized.
            autocmd VimResized * wincmd =

            " Update a buffer's contents on focus if it changed outside of Vim.
            autocmd FocusGained,BufEnter * :checktime

            " Consider this one, since WinEnter doesn't fire on the first window created when Vim launches.
            " You'll need to set any options for the first window in your vimrc,
            " or in an earlier VimEnter autocmd if you include this
            autocmd VimEnter * let w:created=1

            let s:default_path = escape(&path, '\ ') " store default value of 'path'

            " Always add the current file's directory to the path and tags list if not
            " already there. Add it to the beginning to speed up searches.
            autocmd BufRead *
                        \ let s:tempPath=escape(escape(expand("%:p:h"), ' '), '\ ') |
                        \ exec "set path-=".s:tempPath |
                        \ exec "set path-=".s:default_path |
                        \ exec "set path^=".s:tempPath |
                        \ exec "set path^=".s:default_path

            if exists("+omnifunc")
                autocmd Filetype *
                            \	if &omnifunc == "" |
                            \		setlocal omnifunc=syntaxcomplete#Complete |
                            \	endif
            endif

            autocmd BufWritePost,VimLeave *notes/*.md silent !~/.config/bash/scripts/buildnote %:p

            " Remember last position in file:
            autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


            " Extras White spaces
            highlight ExtraWhitespace ctermbg=red guibg=red
            match ExtraWhitespace /\s\+$/
            autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
            autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
            autocmd InsertLeave * match ExtraWhitespace /\s\+$/
            autocmd BufWinLeave * call clearmatches()

            function! TrimWhiteSpace()
                %s/\s\+$//e
            endfunction

            autocmd FileWritePre   * call TrimWhiteSpace()
            autocmd FileAppendPre  * call TrimWhiteSpace()
            autocmd FilterWritePre * call TrimWhiteSpace()
            autocmd BufWritePre    * call TrimWhiteSpace()

        augroup END

        augroup load_us_in_insert_mode
            autocmd!
            autocmd InsertEnter *
                        \ call plug#load(
                        \ 'delimitMate'
                        \)
                        \| autocmd! load_us_in_insert_mode
        augroup END

        augroup load_us_in_idle_mode
            autocmd!
            autocmd CursorHold,CursorHoldI *
                        \ call plug#load(
                        \ 'vim-unimpaired',
                        \ 'vim-surround',
                        \ 'vim-repeat',
                        \ 'vim-commentary',
                        \ 'open-browser.vim',
                        \ 'vim-easy-align',
                        \ 'QFEnter',
                        \ 'quick-scope'
                        \)
                        \| autocmd! load_us_in_idle_mode
        augroup END

        augroup numbertoggle
            autocmd!
            autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
            autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
        augroup END

    endfunction

    call s:autocommands()
endif

