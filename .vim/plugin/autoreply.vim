" https://gist.githubusercontent.com/benknoble/d53208c6f1ad8f2130fd706c9cdbd006/raw/3894823700f591684bc297f32ca2cfe8229f8a95/Vim_autoreply.md
" A modified version of [George's gist](https://gist.github.com/george-b/2f842efaf2141cb935a81f6174b6401f) which I recommend checking out.

" A modified version of [Romain's gist](https://gist.github.com/romainl/047aca21e338df7ccf771f96858edb86) which I recomend checking out.

" Instead we pull the last line from the command history with ~~~`histget()`~~~ `getcmdline()` and use [`fullcommand()`](https://github.com/vim/vim/commit/038e09ee7645731de0296d255aabb17603276443) to get the command name. This gives us the proper command name which we can match against literally.

" Also rather than always having to return a carriage return and whatever else in an expression I've opted to use an `autocmd`.

" This also fixes what could be considered a minor bug at the time of writting in the original the `dlist` and `ilist` mapping. The pattern may have spaces so rather than increment the cursor backwards move it to the start then increment it forwards to the correct destination.

" This now works correctly with any `:global` command, but to have line numbers show up for jumping you still want to use the `#` command at the end.

" Just throwing this up so I can play around with further modifications.

" ```vim
" taken from https://gist.github.com/george-b/2f842efaf2141cb935a81f6174b6401f
" modified in https://gist.github.com/benknoble/d53208c6f1ad8f2130fd706c9cdbd006

if !exists('##CmdlineLeave')
  finish
endif

let s:has_replied = v:false

function s:feedkeys(str) abort
  call feedkeys(a:str, 'n')
endfunction

function! AutoReply(cmdline) abort
  let previous = split(a:cmdline)

  if empty(previous)
    return s:has_replied
  endif

  let previous_cmd = fullcommand(a:cmdline)
  let previous_args = previous[1:]

  if empty(previous_cmd)
    return s:has_replied
  endif

  if s:has_replied
    let s:has_replied = v:false
    return s:has_replied
  endif

  let s:has_replied = v:true

  if previous_cmd ==# 'global'
    call s:feedkeys(':')
  elseif previous_cmd ==# 'undolist'
    call s:feedkeys(':undo' . ' ')
  elseif previous_cmd ==# 'oldfiles'
    call s:feedkeys(':edit #<')
  elseif previous_cmd ==# 'marks'
    call s:feedkeys(':normal! `')

  elseif previous_cmd ==# 'changes'
    call s:feedkeys(':normal! g;')
    call s:feedkeys("\<S-Left>")
  elseif previous_cmd ==# 'jumps'
    call s:feedkeys(':normal!' . ' ')
    call s:feedkeys("\<C-O>\<S-Left>")
  elseif previous_cmd ==# 'registers'
    call s:feedkeys(':normal! "p')
    call s:feedkeys("\<Left>")
  elseif previous_cmd ==# 'tags'
    call s:feedkeys(':pop')
    call s:feedkeys("\<Home>")

  elseif index(['ls', 'files', 'buffers'], previous_cmd) != -1
    call s:feedkeys(':buffer' . ' ')
  elseif index(['clist', 'llist'], previous_cmd) != -1
    call s:feedkeys(':' . repeat(previous_cmd[0], 2) . ' ')
  elseif index(['dlist', 'ilist'], previous_cmd) != -1
    call s:feedkeys(':' . previous_cmd[0] . 'jump' . ' ' . join(previous_args))
    call s:feedkeys("\<Home>\<S-Right>\<Space>")

  else
    let s:has_replied = v:false
  endif

  return s:has_replied
endfunction

augroup AutoReply
  autocmd!
  autocmd CmdlineLeave : call AutoReply(getcmdline())
augroup end
