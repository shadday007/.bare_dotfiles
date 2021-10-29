" Command line suggestions of ripgrep args
function! s:RipgrepArgs(...)
  let list = ['-S', '--smartcase', '-i', '--ignorecase', '-w', '--word-regexp',
        \ '-e', '--regex', '-u', '--skip-vcs-ignores', '-t', '--extension',
        \ '-F', '--fixed-strings']
  return join(list, "\n")
endfunction

command! -nargs=+ -complete=custom,s:RipgrepArgs -bang Rga call search#search_fzf_ripgrep(<q-args>, <bang>0)

