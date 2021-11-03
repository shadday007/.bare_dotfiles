" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" Turn off this plugin when the length of line is longer than
let g:qs_max_chars=200

"  list of buffer types disables the plugin 
let g:qs_buftype_blacklist = ['terminal', 'nofile']

"  list of file types disables the plugin 
let g:qs_filetype_blacklist = ['dashboard', 'startify']

if has('timers')
    let g:qs_delay = 0
endif

let g:qs_lazy_highlight = 1
