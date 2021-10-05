" Plugins management {{{1
try
  packadd minpac
catch
    silent !git clone https://github.com/k-takata/minpac.git  ~/.vim/pack/minpac/opt/minpac
    autocmd VimEnter * PackUpdate 
endtry

if exists('*minpac#init')

    call minpac#init()

    call minpac#add('k-takata/minpac', { 'type': 'opt' })

    " Plugins list {{{2
    " Official LSP support {{{3

    " Completion / Linters {{{3

    " New mappings on top of basic vim functions {{{3
    " aka 'Tpope's land'
    "call minpac#add('junegunn/fzf', { 'do': { -> fzf#install() } })

    " Snippets/Convenience {{{3

    " Git {{{3
    " call minpac#add('tpope/vim-fugitive')
    " call minpac#add('airblade/vim-gitgutter')

    " Vim plugin development {{{3

    " Appearance {{{3
    call minpac#add('chriskempson/base16-vim')
    " Custom filetype plugins {{{3
    " 3}}}

    " Personal Packages {{{3
    " 3}}}

    " Open URI with your favorite browser from your most favorite editor
    "call minpac#add('tyru/open-browser.vim')
    call minpac#add('wincent/pinnacle')
endif

" Minpac commands {{{2
command! PackUpdate packadd minpac | source $MYVIMRC | call minpac#update()
command! PackClean packadd minpac | source $MYVIMRC | call minpac#clean()

nnoremap <C-p> :<C-u>FZF<cr>

" 1}}}
