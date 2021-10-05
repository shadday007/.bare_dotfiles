"" ." functions to format status line from https://github.com/wincent/wincent.git
"
function! statusline#gutterpadding() abort
  let l:minwidth=2
  let l:gutterWidth=max([strlen(line('$')) + 1, &numberwidth, l:minwidth])
  let l:padding=repeat(' ', l:gutterWidth - 1)
  return l:padding
endfunction

function! statusline#gitbranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! statusline#gitstatus()
  let l:branchname = statusline#gitbranch()
  return strlen(l:branchname) > 0?''.l:branchname.' ':''
endfunction

" Automatically change the statusline color depending on mode
function! statusline#changestatuslineColor()
  if (mode() =~# '\v(n|no)')
    exe 'hi! User9 ctermfg=005 guifg=#00ff00 gui=None cterm=None'
  elseif (mode() =~# '\v(v|V)' || g:currentmode[mode()] ==# 'V·Block' || get(g:currentmode, mode(), '') ==# 't')
    exe 'hi! User9 ctermfg=004 guifg=#6CBCE8 gui=None cterm=None'
  elseif (mode() ==# 'i')
    exe 'hi! User9 ctermfg=004 guifg=yellow gui=None cterm=None'
  else
    exe 'hi! User9 ctermfg=006 guifg=orange gui=None cterm=None'
  endif

  return ''
endfunction

" Find out current buffer's size and output it.
function! statusline#filesize()
  let bytes = getfsize(expand('%:p'))
  if (bytes >= 1024)
    let kbytes = bytes / 1024
  endif
  if (exists('kbytes') && kbytes >= 1000)
    let mbytes = kbytes / 1000
  endif

  if bytes <= 0
    return '0'
  endif

  if (exists('mbytes'))
    return mbytes . 'MB '
  elseif (exists('kbytes'))
    return kbytes . 'KB '
  else
    return bytes . 'B '
  endif
endfunction

":h  Head of the file name (the last component and any separators removed).
function! statusline#fileprefix() abort
  let l:basename=expand('%:h')
  if l:basename == '' || l:basename == '.'
    return ''
  else
    " Make sure we show $HOME as ~.
    return substitute(l:basename . '/', '\C^' . $HOME, '~', '')
  endif
endfunction

" File type
function! statusline#ft() abort
  if strlen(&ft)
    return ',' . &ft
  else
    return ''
  endif
endfunction

" File encoding
function! statusline#fenc() abort
  if strlen(&fenc) && &fenc !=# 'utf-8'
    return ',' . &fenc
  else
    return ''
  endif
endfunction

" If buffer is modified or not modified left-hand-side
function! statusline#lhs() abort
  let l:line=statusline#gutterpadding()
  let l:line.=statusline#gitstatus()
  let l:line.=bufnr('')
  " HEAVY BALLOT X - Unicode: U+2718, UTF-8: E2 9C 98
  let l:line.=&modified ? '✘ ' : '  '
  return l:line
endfunction

" rigth hand side
function! statusline#rhs() abort
  let l:rhs=' '
  if winwidth(0) > 80
    let l:column=virtcol('.')
    let l:width=virtcol('$')
    let l:line=line('.')
    let l:height=line('$')

    " Add padding to stop rhs from changing too much as we move the cursor.
    let l:padding=len(l:height) - len(l:line)
    if (l:padding)
      let l:rhs.=repeat(' ', l:padding)
    endif

    let l:rhs.='ℓ ' " (Literal, \u2113 "SCRIPT SMALL L").
    let l:rhs.=l:line
    let l:rhs.='/'
    let l:rhs.=l:height
    let l:rhs.=' 𝚌 ' " (Literal, \u1d68c "MATHEMATICAL MONOSPACE SMALL C").
    let l:rhs.=l:column
    let l:rhs.='/'
    let l:rhs.=l:width
    let l:rhs.=' '

    " Add padding to stop rhs from changing too much as we move the cursor.
    if len(l:column) < 2
      let l:rhs.=' '
    endif
    if len(l:width) < 2
      let l:rhs.=' '
    endif
  endif
  return l:rhs
endfunction

let s:default_lhs_color='Comment'
let s:async_lhs_color='Constant'
let s:modified_lhs_color='ModeMsg'
let s:statusline_status_highlight=s:default_lhs_color
let s:async=0

function! statusline#async_start() abort
  let s:async=1
  call statusline#check_modified()
endfunction

function! statusline#async_finish() abort
  let s:async=0
  call statusline#check_modified()
endfunction

function! statusline#check_modified() abort
  if &modified && s:statusline_status_highlight != s:modified_lhs_color
    let s:statusline_status_highlight=s:modified_lhs_color
    call statusline#update_highlight()
  elseif !&modified
    if s:async && s:statusline_status_highlight != s:async_lhs_color
      let s:statusline_status_highlight=s:async_lhs_color
      call statusline#update_highlight()
    elseif !s:async && s:statusline_status_highlight != s:default_lhs_color
      let s:statusline_status_highlight=s:default_lhs_color
      call statusline#update_highlight()
    endif
  endif
endfunction

" example without pinnacle: ref:1,2,3
" ref:1
" let s:prefix=has('gui') || (has('termguicolors') && &termguicolors) ? 'gui' : 'cterm'

function! statusline#update_highlight() abort
" ref:1
"  let l:fgcolor=synIDattr(synIDtrans(hlID("StatusLine")), \"fg", s:prefix)
" ref:2
"  let l:bgcolor=synIDattr(synIDtrans(hlID("StatusLine")), \"bg", s:prefix)
" ref:3
"  execute 'highlight User1 '  . ' ' . s:prefix .'bg=' . l:bgcolor . ' ' . s:prefix .'fg=' .l:fgcolor . ' cterm=Italic' 

  " Update StatusLine to use italics (used for filetype).
  let l:highlight=pinnacle#italicize('StatusLine')
  execute 'highlight User1 ' . l:highlight

  " Update MatchParen to use italics (used for blurred statuslines).
  let l:highlight=pinnacle#italicize('MatchParen')
  execute 'highlight User2 ' . l:highlight

  " StatusLine + bold (used for file names).
  let l:highlight=pinnacle#embolden('StatusLine')
  execute 'highlight User3 ' . l:highlight

  " Inverted Error styling, for left-hand side "Powerline" triangle.
  let l:fg=pinnacle#extract_fg(s:statusline_status_highlight)
  let l:bg=pinnacle#extract_bg('StatusLine')
  execute 'highlight User4 ' . pinnacle#highlight({'bg': l:bg, 'fg': l:fg})

  " And opposite for the buffer number area.
  execute 'highlight User7 ' .
        \ pinnacle#highlight({
        \   'bg': l:fg,
        \   'fg': pinnacle#extract_fg('Normal'),
        \   'term': 'bold'
        \ })

  " Right-hand side section.
  let l:bg=pinnacle#extract_fg('Cursor')
  let l:fg=pinnacle#extract_fg('User3')
  execute 'highlight User5 ' .
        \ pinnacle#highlight({
        \   'bg': l:fg,
        \   'fg': l:bg,
        \   'term': 'bold'
        \ })

  " Right-hand side section + italic (used for %).
  execute 'highlight User6 ' .
        \ pinnacle#highlight({
        \   'bg': l:fg,
        \   'fg': l:bg,
        \   'term': 'bold,italic'
        \ })

  highlight clear StatusLineNC
  highlight! link StatusLineNC User1
endfunction
