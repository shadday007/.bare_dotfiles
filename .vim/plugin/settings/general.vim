" Set commands {{{1
" set guioptions {{{2
if has('gui')
  set guioptions-=m  "remove menu bar
  set guioptions-=T  "remove toolbar
  set guioptions-=r  "remove right-hand scroll bar
  set guioptions-=L  "remove left-hand scroll bar when there is a vertically split window
  set guioptions-=R  "remove Right-hand scrollbar is present when there is a vertically
  set guioptions-=b  "remove Bottom (horizontal) scrollbar
  set guioptions-=l  "remove Left-hand scrollbar
endif

set wildignore=*~,#*#,*.7z,.DS_Store,.git,.hg,.svn,*.a,*.adf,*.asc,*.au,*.aup
      \,*.avi,*.bin,*.bmp,*.bz2,*.class,*.db,*.dbm,*.djvu,*.docx,*.exe
      \,*.filepart,*.flac,*.gd2,*.gif,*.gifv,*.gmo,*.gpg,*.gz,*.hdf,*.ico
      \,*.iso,*.jar,*.jpeg,*.jpg,*.m4a,*.mid,*.mp3,*.mp4,*.o,*.odp,*.ods,*.odt
      \,*.ogg,*.ogv,*.opus,*.pbm,*.pdf,*.png,*.ppt,*.psd,*.pyc,*.rar,*.rm
      \,*.s3m,*.sdbm,*.sqlite,*.swf,*.swp,*.tar,*.tga,*.ttf,*.wav,*.webm,*.xbm
      \,*.xcf,*.xls,*.xlsx,*.xpm,*.xz,*.zip

" Makes the backspace key behave like you'd expect, and go through EVERYTHING:
set backspace=indent,eol,start

" Tabulations and Keystrokes behaviour{{{2
set mouse=a
set mousemodel=popup
set shiftwidth=4
set tabstop=4           " 4 space tab
set expandtab           " use spaces for tabs
set softtabstop=4       " 4 space tab
set shiftwidth=4
set modelines=1

" Always try to show 10 lines above and below the cursor location:
set scrolloff=10

" Allows you to switch between buffers without saving EVERY TIME:
set hidden

" Case insensitive in command-line mode:
set wildignorecase

" Automatic, language-dependent indentation, syntax coloring  {{{2
filetype indent plugin on
syntax on
set autoindent
set breakindent
set termguicolors

" Editor window options {{{2
syntax enable
set number              " show line numbers
set relativenumber
set ignorecase          " ignore case when searching
set incsearch           " search as characters are entered
set hlsearch            " highlight all matches
set smartcase           " ignores case unless an upper case letter is present in the query
set shortmess+=a        " use abbreviations in messages eg. `[RO]` instead of `[readonly]`
set showcmd             " show command in bottom bar
set cursorline          " highlight current line
set wildmenu
set lazyredraw
set showmatch           " higlight matching parenthesis
set fillchars+=vert:┃
set diffopt=filler,vertical


" Set temp directories {{{2
if exists('$SUDO_USER')
  set nobackup                        " don't create root-owned files
  set nowritebackup                   " don't create root-owned files
  set noswapfile                      " don't create root-owned files
  set noundofile                      " don't create root-owned files
else
  set backupdir=$XDG_CONFIG_HOME/tmp/backup     " keep backup files out of the way
  set backupdir+=.
  set directory=$XDG_CONFIG_HOME/tmp/swap       " keep swap files out of the way
  set directory+=.
  if !has('nvim')
    set undodir=$XDG_CONFIG_HOME/tmp/undo         " keep undo files out of the way
  else
    set undodir=$XDG_CONFIG_HOME/tmp/nvim/undo | call mkdir(&undodir, 'p', 0700)   " keep undo files out of the way
  endif
  set undodir+=.
  set undofile                      " actually use undo files
  if !has('nvim') | set viminfofile=$XDG_CACHE_HOME/vim/viminfo | endif
endif

if has('mksession')
    " override ~/.vim/view default
    set viewdir=$XDG_DATA_HOME/tmp/view | call mkdir(&viewdir, 'p', 0700)
    set viewoptions=cursor,folds        " save/restore just these (with `:{mk,load}view`)
endif

" Folding {{{2
if has('folding')
  if has('windows')
    set fillchars=diff:∙               " BULLET OPERATOR (U+2219, UTF-8: E2 88 99)
    set fillchars+=fold:·              " MIDDLE DOT (U+00B7, UTF-8: C2 B7)
    set fillchars+=vert:┃              " BOX DRAWINGS HEAVY VERTICAL (U+2503, UTF-8: E2 94 83)
  endif

  if has('nvim-0.3.1')
    set fillchars+=eob:\              " suppress ~ at EndOfBuffer
  endif

  " vim: set foldmethod=marker:
  set foldmethod=indent               " not as cool as syntax, but faster
  set foldlevelstart=99               " start unfolded
  set foldlevelstart=10               " start with fold level of 1
  set foldnestmax=10                  " max 10 depth
  set nofoldenable                      " don't fold files by default on open
  set foldtext=MyFoldText()

  function! MyFoldText() abort
    return "+-" . v:folddashes . " " . printf("%3d", v:foldend - v:foldstart + 1) . " lines: "
          \ . trim(substitute(getline(v:foldstart), split(&l:fmr, ',')[0].'\d\?', '', '')) . " "
  endfunction
endif


