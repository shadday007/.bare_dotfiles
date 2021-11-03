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
    call minpac#add('tpope/vim-surround') " provides mappings to easily delete, change and add such surroundings in pairs.
    call minpac#add('tpope/vim-repeat') " Repeat.vim remaps . in a way that plugins can tap into it.
    call minpac#add('tpope/vim-unimpaired') " This plugin provides several pairs of bracket maps.
    call minpac#add('tpope/vim-commentary') " This plugin provides several pairs of bracket maps.
    call minpac#add('jiangmiao/auto-pairs') " Insert or delete brackets, parens, quotes in pair.
    call minpac#add('tommcdo/vim-exchange') " Easy text exchange operator for Vim.
    call minpac#add('unblevable/quick-scope') " highlight for a unique character in every word on a line
    " 3}}}

    " Fuzzy finder {{{3
    call minpac#add('junegunn/fzf.vim') " fzf is a general-purpose command-line fuzzy finder
    call minpac#add('junegunn/fzf', { 'do': './install --all' }) " fzf is a general-purpose command-line fuzzy finder
    call minpac#add('pbogut/fzf-mru.vim') " fzf is a general-purpose command-line fuzzy finder
    call minpac#add('jesseleite/vim-agriculture') " improve the project search experience when using tools like ag and rg
    call minpac#add('mhinz/vim-grepper') " Use your favorite grep tool to start an asynchronous search
    call minpac#add('yssl/QFEnter') " allows you to open items from Vim's quickfix or location list wherever you wish.
    " 3}}}

    " Snippets/Convenience {{{3
    " 3}}}

    " Git {{{3
    call minpac#add('tpope/vim-fugitive') " The crown jewel of Fugitive is :Git
    call minpac#add('airblade/vim-gitgutter') " shows a git diff in the sign column
    call minpac#add('junegunn/vim-github-dashboard') " Browse GitHub events (user dashboard, user/repo activity) in Vim.
    call minpac#add('tpope/vim-rhubarb') " for browse repository
    " 3}}}

    " Vim plugin for development {{{3
    call minpac#add('ludovicchabant/vim-gutentags') " for generate tags 
    " call minpac#add('skywind3000/gutentags_plus')   " for switch gtags not work for now
    call minpac#add('liuchengxu/vista.vim') " View and search LSP symbols, tags in Vim
    call minpac#add('SirVer/ultisnips') " Snippet Manager
    call minpac#add('honza/vim-snippets') " Snippet Provider
    " 3}}}

    " Appearance {{{3
    call minpac#add('chriskempson/base16-vim')
    call minpac#add('wincent/pinnacle')
    call minpac#add('Yggdroot/indentLine')  " displaying thin vertical lines at each indentation level
    " 3}}}

    " Custom filetype plugins {{{3
    " 3}}}

    " Utilities Plugins {{{3
    call minpac#add('tyru/open-browser.vim')    " open and or search the word or uri under cursor on many browsers
    " 3}}}

    " Personal Packages {{{3
    " 3}}}
endif

" Minpac commands {{{2
command! PackUpdate packadd minpac | source $MYVIMRC | call minpac#update()
command! PackClean packadd minpac | source $MYVIMRC | call minpac#clean()
"  2}}}
" 1}}}
