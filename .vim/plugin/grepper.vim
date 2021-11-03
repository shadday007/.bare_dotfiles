" This is a possible configuration..
" for browsing the input history
cnoremap <c-n> <down>
cnoremap <c-p> <up>

nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)

nnoremap <leader>gg :Grepper -tool git<cr>
nnoremap <leader>ga :Grepper -tool ag<cr>
nnoremap <leader>gs :Grepper -tool ag -side<cr>
nnoremap <leader>*  :Grepper -tool ag -cword -noprompt<cr>
nnoremap <leader>g :Grepper<cr>

let g:grepper = {}
let g:grepper.tools = ['ag', 'git', 'grep', 'rg']
let g:grepper.open = 1
let g:grepper.jump = 0
let g:grepper.prompt_mapping_tool = '<leader>g'

command! Todo Grepper -noprompt -tool git -query -E '(TODO|FIXME|XXX):'

