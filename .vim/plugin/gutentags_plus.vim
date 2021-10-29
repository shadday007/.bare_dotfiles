" configuration for gutentags_plus plugin
if exists('g:loaded_gutentags')
    finish
endif

let g:gutentags_ctags_exclude_wildignore = 1

let g:gutentags_ctags_exclude = [
  \'node_modules', '_build', 'build', 'CMakeFiles', '.mypy_cache', 'venv',
  \'proc', '.steam', 'opam', '.sourcegraph', 'opera', 'snapd', '.steampath',
  \'*.md', '*.tex', '*.css', '*.html', '*.json', '*.xml', '*.xmls', '*.ui']

" config project root markers.
let g:gutentags_project_root = ['Makefile','.dotfiles','.root']

" enable gtags module
let g:gutentags_modules = ['ctags']
" let g:gutentags_modules = ['ctags', 'gtags_cscope']

" Defines some advanced commands like |GutentagsToggleEnabled| and |GutentagsUnlock|.
let gutentags_define_advanced_commands = 1

" generate datebases in my cache directory, prevent gtags files polluting my project
let g:gutentags_cache_dir = expand($XDG_CACHE_HOME.'/vim/tags')

set tags=./tags;,tags;expand($XDG_CACHE_HOME.'/vim/tags')

" change focus to quickfix window after search (optional).
" let g:gutentags_plus_switch = 1

" disable the default keymaps by:
" let g:gutentags_plus_nomap = 1

command! -nargs=0 GutentagsClearCache call system('rm ' . g:gutentags_cache_dir . '/*')
