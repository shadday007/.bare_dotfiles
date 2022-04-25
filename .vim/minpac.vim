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
    call minpac#add('kana/vim-textobj-user') " is a Vim plugin to create your own text objects without pain. 
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
    call minpac#add('SirVer/ultisnips') " Snippet Manager
    call minpac#add('honza/vim-snippets') " Snippet Provider
    " 3}}}

    " Git {{{3
    call minpac#add('tpope/vim-fugitive') " The crown jewel of Fugitive is :Git
    call minpac#add('airblade/vim-gitgutter') " shows a git diff in the sign column
    call minpac#add('junegunn/vim-github-dashboard') " Browse GitHub events (user dashboard, user/repo activity) in Vim.
    call minpac#add('tpope/vim-rhubarb') " for browse repository
    " 3}}}

    " Vim plugin for development {{{3
    call minpac#add('christoomey/vim-tmux-navigator') " move between tmux panes and Vim splits seamlessly.
    call minpac#add('ludovicchabant/vim-gutentags') " for generate tags 
    " call minpac#add('skywind3000/gutentags_plus')   " for switch gtags not work for now
    call minpac#add('liuchengxu/vista.vim') " View and search LSP symbols, tags in Vim
    call minpac#add('AndrewRadev/sideways')  " The plugin defines two commands, :SidewaysLeft and :SidewaysRight, which move the item under the cursor left or right

    " Ruby development
    call minpac#add('nelstrom/vim-textobj-rubyblock') " A custom text object for selecting ruby blocks.
    call minpac#add('tpope/vim-bundler') " This is a lightweight bag of Vim goodies for Bundler
    call minpac#add('tpope/vim-projectionist') " Projectionist provides granular project configuration using 'projections'
    call minpac#add('andyl/fuzzy-projectionist.vim') " Alternate File Navigation
    call minpac#add('andyl/vim-projectionist-ruby') " This plugin supplies quick-nav links for Ruby projects
    call minpac#add('tpope/vim-rake') " Rake.vim is a plugin leveraging projectionist.vim to enable you to use all those parts of rails.vim that you wish
    call minpac#add('tpope/vim-rails') " for editing Ruby on Rails applications.
    call minpac#add('ecomba/vim-ruby-refactoring') " to make refactoring Ruby easier.
    call minpac#add('tpope/gem-ctags') " automatically invoke Ctags on gems as they are installed.
    call minpac#add('tpope/vim-endwise') " This is a simple plugin that helps to end certain structures automatically.
    call minpac#add('alvan/vim-closetag') " 
    " 3}}}

    " Appearance {{{3
    call minpac#add('chriskempson/base16-vim')
    call minpac#add('wincent/pinnacle')
    call minpac#add('Yggdroot/indentLine')  " displaying thin vertical lines at each indentation level
    call minpac#add('tommcdo/vim-lion')  " for aligning text by some character. The two operators are gl and gL.
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
command! PackStatus packadd minpac | call minpac#status()
"  2}}}
" 1}}}
