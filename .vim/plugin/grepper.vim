
nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)

nnoremap <leader>ga :Grepper -tool ag<cr>
nnoremap <leader>gr :Grepper -tool rg<cr>
nnoremap <leader>gg :Grepper -tool git<cr>
nnoremap <leader>gs :Grepper -tool ag -side<cr>
nnoremap <leader>*  :Grepper -tool ag -cword -noprompt<cr>
"nnoremap <leader>g  :Grepper<cr> " conflict with Format a paragraph mappings.vim

let g:grepper = {}
let g:grepper.tools = ['ag', 'git', 'grep', 'rg']
let g:grepper.open = 1
let g:grepper.jump = 0
let g:grepper.prompt_mapping_tool = '<leader>gp'
let g:grepper.next_tool     = '<leader>gn'

command! Todo Grepper -noprompt -tool git -query -E '(TODO|FIXME|XXX):'

" After searching for text, press this mapping to do a project wide find and
" replace. It's similar to <leader>r except this one applies to all matches
" across all files instead of just the current file.
nnoremap <Leader>R
  \ :let @s='\<'.expand('<cword>').'\>'<CR>
  \ :Grepper -cword -noprompt<CR>
  \ :cfdo %s/<C-r>s//g \| update
  \<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>

" The same as above except it works with a visual selection.
xmap <Leader>R
    \ "sy
    \ gvgr
    \ :cfdo %s/<C-r>s//g \| update
     \<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>

