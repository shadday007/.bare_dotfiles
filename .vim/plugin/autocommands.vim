scriptencoding utf-8

if has('autocmd')

    function! s:autocommands()

        augroup autocommands

            autocmd!

            " Create directories before write
            " [1]: https://stackoverflow.com/questions/4292733/vim-creating-parent-directories-on-save
            autocmd BufWritePre * if expand("<afile>")!~#'^\w\+:/' && !isdirectory(expand("%:h")) | execute "silent! !mkdir -p ".shellescape(expand('%:h'), 1) | redraw! | endif


            " autocmd that will set up the w:created variable
            autocmd VimEnter * autocmd WinEnter * let w:created=1

            " Consider this one, since WinEnter doesn't fire on the first window created when Vim launches.
            " You'll need to set any options for the first window in your vimrc,
            " or in an earlier VimEnter autocmd if you include this
            autocmd VimEnter * let w:created=1

            autocmd BufEnter,FocusGained,VimEnter,WinEnter * call autocommands#focus_window()
            autocmd FocusLost,WinLeave * call autocommands#blur_window()

        augroup END

    endfunction

    call s:autocommands()

endif
