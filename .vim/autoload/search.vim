" Ripgrep search
finish
function! search#search_fzf_ripgrep(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let command = printf(command_fmt, a:query)
  call fzf#vim#grep(command, 1, fzf#vim#with_preview(), a:fullscreen)
endfunction
