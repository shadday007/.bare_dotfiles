scriptencoding utf-8

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

            " autocmd that will set up the w:created variable
            autocmd VimEnter * autocmd WinEnter * let w:created=1

            " Consider this one, since WinEnter doesn't fire on the first window created when Vim launches.
            " You'll need to set any options for the first window in your vimrc,
            " or in an earlier VimEnter autocmd if you include this
            autocmd VimEnter * let w:created=1

            autocmd BufEnter,FocusGained,VimEnter,WinEnter * call autocommands#focus_window() | setlocal cursorline
            autocmd FocusLost,WinLeave * call autocommands#blur_window() | setlocal nocursorline

            autocmd ColorScheme * call statusline#update_highlight()
            "      autocmd User FerretAsyncStart call statusline#async_start()
            "      autocmd User FerretAsyncFinish call statusline#async_finish()

            autocmd BufEnter,FocusGained,VimEnter,WinEnter * call autocommands#focus_statusline()
            autocmd FocusLost,WinLeave * call autocommands#blur_statusline()

            if exists('#TextChangedI')
                autocmd BufWinEnter,BufWritePost,FileWritePost,TextChanged,TextChangedI,WinEnter * call statusline#check_modified()
            else
                autocmd BufWinEnter,BufWritePost,FileWritePost,WinEnter * call statusline#check_modified()
            endif

        augroup END

    endfunction

    call s:autocommands()

endif
