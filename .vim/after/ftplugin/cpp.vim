" let extension=expand('%:e')
" echom extension

runtime ftplugin/man.vim

function! s:callCppMan()
    let old_isk = &iskeyword
    setl iskeyword+=:
    let str = expand("<cword>")
    let &l:iskeyword = old_isk
    execute 'Man ' . str
endfunction

command! FuncCppMan :call s:callCppMan()
