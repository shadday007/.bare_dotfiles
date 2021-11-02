" A modified version of Romain's gist.
" https://gist.github.com/george-b/2f842efaf2141cb935a81f6174b6401f

" See prior revisions for functionality closer to the original. This is now a simplification that aims only to provide prompts that would typically follow basic commands.

function! ExpandCommand(pattern) abort
    let aliases =
                \ { 'cn' : 'cnext'
                \ , 'cp' : 'cprevious'
                \ , 'g'  : 'global'
                \ , 's'  : 'substitute'
                \ , 'v'  : 'vglobal'
                \ }

    let completion = getcompletion(a:pattern, 'command')
    if &ignorecase
        call filter(completion, "v:val !~# a:pattern")
    endif
    let completion = len(completion) == 1 ? join(completion) : ''

    return get(aliases, a:pattern, completion)
endfunction

augroup AutoReply
    autocmd!
    autocmd CmdlineLeave :
                \ execute 'silent doautocmd AutoReply User'
                \          ExpandCommand(getcmdline())

    autocmd User marks     call feedkeys(':normal!`', 'n')
    autocmd User oldfiles  call feedkeys(':edit#<',   'n')

    autocmd User buffers   call feedkeys(':buffer'      . "\<Space>",  'n')
    autocmd User files     call feedkeys(':buffer'      . "\<Space>",  'n')
    autocmd User ls        call feedkeys(':buffer'      . "\<Space>",  'n')

    autocmd User clist     call feedkeys(':silent cc'   . "\<Space>",  'n')
    autocmd User llist     call feedkeys(':silent ll'   . "\<Space>",  'n')
    autocmd User registers call feedkeys(':silent put'  . "\<Space>",  'n')
    autocmd User tags      call feedkeys(':tjump'       . "\<Space>",  'n')
    autocmd User undolist  call feedkeys(':silent undo' . "\<Space>",  'n')

    autocmd User changes   call feedkeys(':normal! g;'  . "\<S-Left>", 'n')
    autocmd User jumps     call feedkeys(':normal! �'  . "\<S-Left>", 'n')

    autocmd User chistory
                \ if getqflist({'nr' : '$'}).nr > 1
                \ |   call feedkeys(':silent chistory | copen',  'n')
                \ |   call feedkeys("\<Home>\<S-Right>\<Right>", 'n')
                \ | endif
augroup END
