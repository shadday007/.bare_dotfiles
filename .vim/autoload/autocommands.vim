let g:ColorColumnBufferNameBlacklist = []
let g:ColorColumnFileTypeBlacklist = ['diff', 'fugitiveblame', 'qf']
let g:CursorlineBlacklist = ['command-t']
let g:MkviewFiletypeBlacklist = ['diff', 'hgcommit', 'gitcommit']

" Variant of statusline from plugin/statusline.vim (can't comment inline
" with line continuation markers without Vim freaking out).
let g:QuickfixStatusline =
      \ '%7*'
      \ . '%{statusline#lhs()}'
      \ . '%*'
      \ . '%4*'
      \ . ''
      \ . '\ '
      \ . '%*'
      \ . '%3*'
      \ . '%q'
      \ . '\ '
      \ . '%{get(w:,\"quickfix_title\",\"\")}'
      \ . '%*'
      \ . '%<'
      \ . '\ '
      \ . '%='
      \ . '\ '
      \ . ''
      \ . '%5*'
      \ . '%{statusline#rhs()}'
      \ . '%*'

function! autocommands#should_colorcolumn() abort
    if index(g:ColorColumnBufferNameBlacklist, bufname(bufnr('%'))) != -1
        return 0
    endif
    if index(g:ColorColumnFileTypeBlacklist, &filetype) != -1
        return 0
    endif
    return &buflisted
endfunction

function! s:get_spell_settings() abort
    return {
                \   'spell': &l:spell,
                \   'spellcapcheck': &l:spellcapcheck,
                \   'spellfile': &l:spellfile,
                \   'spelllang': &l:spelllang
                \ }
endfunction

function! s:set_spell_settings(settings) abort
    let &l:spell=a:settings.spell
    let &l:spellcapcheck=a:settings.spellcapcheck
    let &l:spellfile=a:settings.spellfile
    let &l:spelllang=a:settings.spelllang
endfunction

function! autocommands#blur_window() abort
    if autocommands#should_colorcolumn()
        let l:settings=s:get_spell_settings()
        " ownsyntax off
        " let &l:colorcolumn=join(range(1,255),',')
        set nolist
        if has('conceal')
            set conceallevel=0
        endif
        call s:set_spell_settings(l:settings)
    endif
endfunction

function! autocommands#focus_window() abort
    if autocommands#should_colorcolumn()
        if !empty(&ft)
            let l:settings=s:get_spell_settings()
            " ownsyntax on
            " let &l:colorcolumn='+'.join(range(0,254),',+')
            set list
            if has('conceal')
                set conceallevel=1
            endif
            call s:set_spell_settings(l:settings)
        endif
    endif
endfunction

function! autocommands#blur_statusline() abort
  " Default blurred statusline (buffer number: filename).
  let l:blurred='%{statusline#gutterpadding()}'
  let l:blurred.='\ ' " space
  let l:blurred.='\ ' " space
  let l:blurred.='\ ' " space
  let l:blurred.='\ ' " space
  let l:blurred.='%<' " truncation point
  let l:blurred.='%f' " filename
  let l:blurred.='%=' " split left/right halves (makes background cover whole)
  call s:update_statusline(l:blurred, 'blur')
endfunction

function! autocommands#focus_statusline() abort
  " `setlocal statusline=` will revert to global 'statusline' setting.
  call s:update_statusline('', 'focus')
endfunction

function! s:update_statusline(default, action) abort
  let l:statusline = s:get_custom_statusline(a:action)
  if type(l:statusline) == type('')
    " Apply custom statusline.
    execute 'setlocal statusline=' . l:statusline
  elseif l:statusline == 0
    " Do nothing.
    "
    " Note that order matters here because of Vimscript's insane coercion rules:
    " when comparing a string to a number, the string gets coerced to 0, which
    " means that all strings `== 0`. So, we must check for string-ness first,
    " above.
    return
  else
    execute 'setlocal statusline=' . a:default
  endif
endfunction

function! s:get_custom_statusline(action) abort
  if &ft ==# 'command-t'
    " Will use Command-T-provided buffer name, but need to escape spaces.
    return '\ \ ' . substitute(bufname('%'), ' ', '\\ ', 'g')
  elseif &ft ==# 'diff' && exists('t:diffpanel') && t:diffpanel.bufname ==# bufname('%')
    return 'Undotree\ preview' " Less ugly, and nothing really useful to show.
  elseif &ft ==# 'undotree'
    return 0 " Don't override; undotree does its own thing.
  elseif &ft ==# 'qf'
    if a:action ==# 'blur'
      return
            \ '%{statusline#gutterpadding()}'
            \ . '\ '
            \ . '\ '
            \ . '\ '
            \ . '\ '
            \ . '%<'
            \ . '%q'
            \ . '\ '
            \ . '%{get(w:,\"quickfix_title\",\"\")}'
            \ . '%='
    else
      return g:QuickfixStatusline
    endif
  endif

  return 1 " Use default.
endfunction

