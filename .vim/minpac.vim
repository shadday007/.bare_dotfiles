" Plugins management {{{1
try
  packadd minpac
catch
    silent !git clone https://github.com/k-takata/minpac.git  ~/.vim/pack/minpac/opt/minpac
    autocmd VimEnter * PackUpdate 
endtry

if exists('g:loaded_minpac')
"if exists('*minpac#init')  stop working

    call minpac#init({'verbose': 3})

    call minpac#add('k-takata/minpac', { 'type': 'opt' })

    " Plugins list {{{2
    " Official LSP support {{{3
    " 3}}}

    " Completion / Linters {{{3
    " 3}}}

    " New mappings on top of basic vim functions {{{3
    " aka 'Tpope's land'
    "call minpac#add('junegunn/fzf', { 'do': { -> fzf#install() } })
    " 3}}}

    " Snippets/Convenience {{{3
    " 3}}}

    " Git {{{3
    call minpac#add('tpope/vim-fugitive')
    call minpac#add('airblade/vim-gitgutter')
    call minpac#add('tpope/vim-rhubarb')                      " for browse repository
    " 3}}}

    " Vim plugin development {{{3
    " 3}}}

    " Appearance {{{3
    call minpac#add('chriskempson/base16-vim')
    call minpac#add('wincent/pinnacle')
    " Custom filetype plugins {{{3
    " 3}}}

    " Utilities Plugins {{{3
    call minpac#add('tyru/open-browser.vim')    " open and or search the word or uri under cursor on many browsers
    "call minpac#add('Yggdroot/indentLine')      " show conceal
    " 3}}}

    " Personal Packages {{{3
    " 3}}}
endif

" Minpac commands {{{2
command! PackUpdate packadd minpac | source $MYVIMRC | call minpac#update()
command! PackClean packadd minpac | source $MYVIMRC | call minpac#clean()
"  2}}}
" 1}}}
