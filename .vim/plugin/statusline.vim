" Subset from plugin/statusline.vim (can't comment inline with line continuation
" markers without Vim freaking out).
" let g:QuickfixStatusline =
"       \ 'Quickfix'
"       \ . '%<'
"       \ . '\ '
"       \ . '%='
"       \ . '\ '
"       \ . 'ℓ'
"       \ . '\ '
"       \ . '%l'
"       \ . '/'
"       \ . '%L'
"       \ . '\ '
"       \ . '@'
"       \ . '\ '
"       \ . '%c'
"       \ . '%V'
"       \ . '\ '
"       \ . '%1*'
"       \ . '%p'
"       \ . '%%'
"       \ . '%*'
" " https://github.com/Greduan/dotfiles/blob/76e16dd8a04501db29989824af512c453550591d/vim/after/plugin/statusline.vim
" 
" let g:currentmode={
"       \ 'n'  : 'N ',
"       \ 'no' : 'N·Operator Pending ',
"       \ 'v'  : 'V ',
"       \ 'V'  : 'V·Line ',
"       \ \"\<C-v>" : 'V·Block ',
"       \ 's'  : 'Select ',
"       \ 'S'  : 'S·Line ',
"       \ \"\<C-s" : 'S·Block ',
"       \ 'i'  : 'I ',
"       \ 'R'  : 'R ',
"       \ 'Rv' : 'V·Replace ',
"       \ 'c'  : 'Command ',
"       \ 'cv' : 'Vim Ex ',
"       \ 'ce' : 'Ex ',
"       \ 'r'  : 'Prompt ',
"       \ 'rm' : 'More ',
"       \ 'r?' : 'Confirm ',
"       \ '!'  : 'Shell ',
"       \ 't'  : 'Terminal '
"       \}
" 
scriptencoding utf-8

" cf the default statusline: %<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
if has('statusline')
  set statusline=
  set statusline+=%7*                         " Switch to User7 highlight group
  set statusline+=%{statusline#lhs()}
  set statusline+=%*                         " Reset highlight group.
  set statusline+=%4*                        " Switch to User4 highlight group (Powerline arrow).
  set statusline+=                          " Powerline arrow.
  set statusline+=%*                         " Reset highlight group.
  set statusline+=\                          " Space.
  set statusline+=%<                         " Truncation point, if not enough width available.
  set statusline+=%{statusline#fileprefix()} " Relative path to file's directory.
  set statusline+=%3*                        " Switch to User3 highlight group (bold).
  set statusline+=%t                         " Filename.
  set statusline+=%*                         " Reset highlight group.
  set statusline+=\                          " Space.
  set statusline+=%1*                        " Switch to User1 highlight group (italics).

  " Needs to be all on one line:
  "   %(                   Start item group.
  "   [                    Left bracket (literal).
  "   %R                   Read-only flag: ,RO or nothing.
  "   %{statusline#ft()}   Filetype (not using %Y because I don't want caps).
  "   %{statusline#fenc()} File-encoding if not UTF-8.
  "   ]                    Right bracket (literal).
  "   %)                   End item group.
  set statusline+=%([%R%{statusline#ft()}%{statusline#fenc()}]%)

  set statusline+=%*   " Reset highlight group.
  set statusline+=%=   " Split point for left and right groups.

  set statusline+=\               " Space.
  set statusline+=               " Powerline arrow.
  set statusline+=%5*             " Switch to User5 highlight group.
  set statusline+=%{statusline#rhs()}
  set statusline+=%*              " Reset highlight group.

 if has('autocmd')
    augroup CustomStatusline
      autocmd!
      autocmd ColorScheme * call statusline#update_highlight()
"      autocmd User FerretAsyncStart call statusline#async_start()
"      autocmd User FerretAsyncFinish call statusline#async_finish()
      if exists('#TextChangedI')
        autocmd BufWinEnter,BufWritePost,FileWritePost,TextChanged,TextChangedI,WinEnter * call statusline#check_modified()
      else
        autocmd BufWinEnter,BufWritePost,FileWritePost,WinEnter * call statusline#check_modified()
      endif
    augroup END
  endif
endif
