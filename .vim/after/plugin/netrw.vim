" Testing this two lines for now
" let g:netrw_altv = 1
" let g:netrw_browse_split = 4
" Open Netwr

nnoremap <leader>df :Lexplore %:p:h<CR>
nnoremap <Leader>dl :Lexplore<CR>

" open url under cursor using 'gx'
let g:netrw_browsex_viewer= "xdg-open"

" The home directory for where bookmarks and history are saved
let g:netrw_home = $XDG_DATA_HOME."/vim"

" trying to make netrw more nice
" Hide banner
"Ocultar el banner (Si quieren). Para mostrarlo temporalmente sólo deben presionar I en Netrw.
let g:netrw_banner = 0

"Sincronizar el directorio actual y el directorio que está mostrando Netrw. Esto ayuda con el error cuando se intenta mover archivos.
let g:netrw_keepdir = 0

"Configurar el porcentaje que ocupa Netrw cuando crea una división. 25% esta bien.
"
let g:netrw_winsize = 25

"Ocultar archivos que comiencen con un punto.
" Hide dotfiles
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'

"Modificar el comando para copiar archivos. Para permitir copiar directorios de manera recursiva.
let g:netrw_localcopydircmd = 'cp -r'
"
"let g:netrw_localcopydircmd = 'cp -r'
"Resaltar los archivos marcados de la misma manera en la que se resalta las coincidencias en una búsqueda.
hi! link netrwMarkFile Search

" Better keymaps for Netrw
function! NetrwMapping()
  " Close Netrw window
  "nmap <buffer> <Leader>dd :Lexplore<CR>
  "nmap <buffer> <Leader>da :Lexplore<CR>

  " Go to file and close Netrw window
  "nmap <buffer> L <CR>:Lexplore<CR>

  " Go back in history
  "nmap <buffer> H u

  " Go up a directory
  "nmap <buffer> h -^

  " Go down a directory / open file
  "nmap <buffer> l <CR>

  " Toggle dotfiles
  "nmap <buffer> . gh

  " Toggle the mark on a file
  "nmap <buffer> <TAB> mf

  " Unmark all files in the buffer
  "nmap <buffer> <S-TAB> mF

  " Unmark all files
  "nmap <buffer> <Leader><TAB> mu

  " 'Bookmark' a directory
  "nmap <buffer> bb mb

  " Delete the most recent directory bookmark
  "nmap <buffer> bd mB

  " Got to a directory on the most recent bookmark
  "nmap <buffer> bl gb

  " Create a file
  "nmap <buffer> ff %

  " Rename a file
  "nmap <buffer> fe R

  " Copy marked files
  "nmap <buffer> fc mc

  " Move marked files
  "nmap <buffer> fx mm

  " Execute a command on marked files
  "nmap <buffer> f; mx

  " Show the list of marked files
  "nmap <buffer> fl :echo join(netrw#Expose("netrwmarkfilelist"), \"\n")<CR>

  " Show the current target directory
  "nmap <buffer> fq :echo 'Target:' . netrw#Expose("netrwmftgt")<CR>

  " Set the directory under the cursor as the current target
  "nmap <buffer> fg mtfq

  " Delete a file
  "nmap <buffer> FF :call NetrwRemoveRecursive()<CR>

  " Close the preview window
  "nmap <buffer> P <C-w>z
endfunction

augroup netrw_mapping
    autocmd!
    autocmd filetype netrw call NetrwMapping()
augroup END
