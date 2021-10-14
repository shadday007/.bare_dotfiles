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
"}}}

" set Wildmenu {{{2
set wildmenu
" Make wildmenu behave like similar to Bash completion.
set wildmode=list:longest:list,full
set wildignore=*~,#*#,*.7z,.DS_Store,.git,.hg,.svn,*.a,*.adf,*.asc,*.au,*.aup
      \,*.avi,*.bin,*.bmp,*.bz2,*.class,*.db,*.dbm,*.djvu,*.docx,*.exe
      \,*.filepart,*.flac,*.gd2,*.gif,*.gifv,*.gmo,*.gpg,*.gz,*.hdf,*.ico
      \,*.iso,*.jar,*.jpeg,*.jpg,*.m4a,*.mid,*.mp3,*.mp4,*.o,*.odp,*.ods,*.odt
      \,*.ogg,*.ogv,*.opus,*.pbm,*.pdf,*.png,*.ppt,*.psd,*.pyc,*.rar,*.rm
      \,*.s3m,*.sdbm,*.sqlite,*.swf,*.swp,*.tar,*.tga,*.ttf,*.wav,*.webm,*.xbm
      \,*.xcf,*.xls,*.xlsx,*.xpm,*.xz,*.zip
" Enable extended % matching
runtime macros/matchit.vim
" Makes the backspace key behave like you'd expect, and go through EVERYTHING:
set backspace=indent,eol,start
"}}}

" Tabulations and Keystrokes behaviour{{{2
set mouse=a            " Enable mouse drag on window splits
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
"}}}

" Automatic, language-dependent indentation, syntax coloring  {{{2
filetype indent plugin on
syntax on
set autoindent
set breakindent
set termguicolors
"}}}

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
set laststatus=2        " show always stausline
set cursorline          " highlight current line
set lazyredraw
set showmatch           " higlight matching parenthesis
set fillchars+=vert:┃
set diffopt=filler,vertical
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300
set termwinsize=12x0   " Set terminal size
set splitbelow         " Always split below
"}}}

" Set temp directories {{{2
if exists('$SUDO_USER')
  set nobackup                        " don't create root-owned files
  set nowritebackup                   " don't create root-owned files
  set noswapfile                      " don't create root-owned files
  set noundofile                      " don't create root-owned files
else
  set backupdir=$XDG_CONFIG_HOME/tmp/backup  | call mkdir(&backupdir, 'p', 0700)   " keep backup files out of the way
  set backupdir+=.
  set directory=$XDG_CONFIG_HOME/tmp/swap  | call mkdir(&directory, 'p', 0700)     " keep swap files out of the way
  set directory+=.
  if !has('nvim')
    set undodir=$XDG_CONFIG_HOME/tmp/undo | call mkdir(&undodir, 'p', 0700)   " keep undo files out of the way
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
"}}}

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
  set foldcolumn=2                    " show a small column on the left side of the window
  set foldtext=MyFoldText()

  function! MyFoldText() abort
    return "+-" . v:folddashes . " " . printf("%3d", v:foldend - v:foldstart + 1) . " lines: "
          \ . trim(substitute(getline(v:foldstart), split(&l:fmr, ',')[0].'\d\?', '', '')) . " "
  endfunction
endif
"}}}

" Spell configuration {{{2
call mkdir($XDG_DATA_HOME."/.vim/spell", 'p', 0700)
" 
" For spelling, use  United States English by default, but later on we’ll
" configure a leader mapping to switch to Spanish, since I so
" often have to write for Venezuelan people.
"
set spelllang=en_us

" Spell checking includes optional support for catching lower case letters at
" the start of sentences, and defines a pattern in 'spellcapcheck' for the end
" of a sentence.  The default is pretty good, but with two-spacing with
" 'cpoptions' including ‘J’ and 'formatoptions' including ‘p’ as set later in
" this file, we can be less ambiguous in this pattern.  We require two
" consecutive spaces, a newline, a carriage return, or a tab to mark the end
" of a sentence.  This means that we could make abbreviations like “i.e.
" something” without flagging “something” as a spelling error.
"
set spellcapcheck=[.?!]\\%(\ \ \\\|[\\n\\r\\t]\\)

" When spell-checking snakeCased or CamelCased words, treat every upper-case
" character in a word text object as the beginning of a new word for separate
" spell-checking.  At the time of writing, this is still a very new option
" (v8.2.0953, June 2020).
"
" <https://github.com/vim/vim/releases/tag/v8.2.0953>
"
if exists('+spelloptions')
  set spelloptions+=camel
endif

set dictionary^=/usr/share/dict/usa
set dictionary+=/usr/share/dict/spanish

set thesaurus^=$XDG_DATA_HOME."/.vim/spell/thesaurus.txt"  "<https://sanctum.geek.nz/ref/thesaurus.txt>

set complete+=kspell
set completeopt=menuone,longest
set spellsuggest=double
"}}}
"

" Format options configuration {{{2
" If a line is already longer than 'textwidth' would otherwise limit when
" editing of that line begins in insert mode, don’t suddenly automatically
" wrap it; I’ll break it apart myself with a command like ‘gq’.  This doesn’t
" seem to stop paragraph reformatting with ‘a’, if that’s set.
"
set formatoptions+=l

" Don’t wrap a line in such a way that a single-letter word like “I” or “a” is
" at the end of it.  Typographically, as far as I can tell, this seems to be
" a stylistic preference rather than a rule, rather like avoiding “widow” and
" “orphan” lines in typesetting.  I think it generally looks better to have
" the short word start the line, so we’ll switch it on.
"
set formatoptions+=1

" If the filetype plugins have correctly described what the comment syntax for
" the buffer’s language looks like, it makes sense to use that to figure out
" how to join lines within comments without redundant comment syntax cropping
" up.  For example, with this set, joining lines in this very comment with ‘J’
" would remove the leading ‘"’ characters.
"
" This 'formatoptions' flag wasn’t added until v7.3.541.  Because we can’t
" test for the availability of option flags directly, we resort to a version
" number check before attempting to set it.  I don’t like using :silent! to
" suppress errors for this sort of thing when I can reasonably avoid it, even
" if the tests are somewhat more verbose.
"
" <https://github.com/vim/vim/releases/tag/v7.3.541>
"
if has('patch-7.3.541')
  set formatoptions+=j
endif

" A momentary digression here into the doldrums of 'cpoptions'—after staunchly
" opposing it for years, I have converted to two-spacing.  You can blame Steve
" Losh
"
" <http://stevelosh.com/blog/2012/10/why-i-two-space/>
"
" Consequently, we specify that sentence objects for the purposes of the ‘s’
" text object, the ‘(’ and ‘)’ sentence motions, and formatting with the 'gq'
" command must be separated by *two* spaces.  One space does not suffice.
"
" My defection to the two-spacers is also the reason I now leave 'joinspaces'
" set, per its default, so that two spaces are inserted when consecutive
" sentences separated by a line break are joined onto one line by the ‘J’
" command.

set cpoptions+=J

" Separating sentences with two spaces has an advantage in making a clear
" distinction between two different types of periods: periods that abbreviate
" longer words, as in “Mr. Moolenaar”, and periods that terminate sentences,
" like this one.
"
" If we’re using two-period spacing for sentences, Vim can interpret the
" different spacing to distinguish between the two types, and can thereby
" avoid breaking a line just after an abbreviating period.  For example, the
" two words in “Mr. Moolenaar” should never be split apart, lest the
" abbreviation “Mr.” look too much like the end of a sentence.  This also
" preserves the semantics of that same period for subsequent reformatting; its
" single-space won’t get lost.
"
" So, getting back to our 'formatoptions' settings, that is what the ‘p’ flag
" does.  I wrote the patch that added it, after becoming envious of an
" analogous feature during an ill-fated foray into GNU Emacs usage.
"
" <https://github.com/vim/vim/releases/tag/v8.1.1523>

if has('patch-8.1.728')
  set formatoptions+=p
endif

set list
set listchars=
set listchars+=tab:░\ 
set listchars+=trail:·
set listchars+=extends:»
set listchars+=precedes:«
set listchars+=nbsp:⣿

" Extras White spaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
au BufWinEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhitespace /\s\+$/
au BufWinLeave * call clearmatches()
"}}}
