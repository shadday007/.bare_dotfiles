let g:qfenter_keymap = {}

" Normal mode : Open an item under cursor in the previously focused window.
" Visual mode : Open items in visual selection in the previously focused window. As a result, the last item appears in the window.
let g:qfenter_keymap.open = ['<CR>', '<2-LeftMouse>']
" Normal mode : Open an item under cursor in a new vertical split of the previously focused window.
" Visual mode : Open items in visual selection in a sequence of new vertical splits from the previously focused window.
let g:qfenter_keymap.vopen = ['<C-v>']
" Normal mode : Open an item under cursor in a new horizontal split from the previously focused window.
" Visual mode : Open items in visual selection in a sequence of new horizontal splits of the previously focused window.
let g:qfenter_keymap.hopen = ['<C-CR>', '<C-s>', '<C-x>']
" Normal mode : Open an item under cursor in a new tab.
" Visual mode : Open items in visual selection in a sequence of new tabs. By default, the quickfix window is automatically opened in the new tab to help you open other quickfix items. This behavior can be changed with the g:qfenter_enable_autoquickfix option.
let g:qfenter_keymap.topen = ['<C-t>']

let g:qfenter_exclude_filetypes = ['nerdtree', 'tagbar', '__vista__']
