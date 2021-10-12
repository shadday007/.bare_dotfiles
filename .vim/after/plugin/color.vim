function s:CheckColorScheme()
    if !has('termguicolors')
        let g:base16colorspace=256
    endif

    let s:config_file = expand('~/.vim/.base16')

    if filereadable(s:config_file)
        let s:config = readfile(s:config_file, '', 2)

        if s:config[1] =~# '^dark\|light$'
            execute 'set background=' . s:config[1]
        else
            echoerr 'Bad background ' . s:config[1] . ' in ' . s:config_file
        endif

        if filereadable(expand('~/.vim/pack/minpac/start/base16-vim/colors/base16-' . s:config[0] . '.vim'))
            execute 'colorscheme base16-' . s:config[0]
        else
            echoerr 'Bad scheme ' . s:config[0] . ' in ' . s:config_file
        endif
    else " default
        set background=dark
        colorscheme base16-default-dark
    endif

    " Hide (or at least make less obvious) the EndOfBuffer region
    highlight! EndOfBuffer ctermbg=bg ctermfg=bg guibg=bg guifg=bg

    " Grey, just like we used to get with https://github.com/Yggdroot/indentLine
    if &background ==# 'light'
        let s:conceal_term_fg=249
        let s:conceal_gui_fg='Grey70'
    else
        let s:conceal_term_fg=239
        let s:conceal_gui_fg='Grey30'
    endif
    highlight clear Conceal
    execute 'highlight Conceal ' .
                \ 'ctermfg=' . s:conceal_term_fg
                \ 'guifg=' . s:conceal_gui_fg

    " Sync with corresponding non-nvim 'highlight' settings in
    " ~/.vim/plugin/settings.vim:
    highlight clear NonText
    highlight link NonText Conceal

    highlight clear DiffDelete
    highlight link DiffDelete Conceal
    highlight clear VertSplit
    " Resolve clashes with ColorColumn.
    " Instead of linking to Normal (which has a higher priority, link to nothing).
    highlight link vimUserFunc NONE

    " More subtle highlighting during merge conflict resolution.
    highlight clear DiffAdd
    highlight clear DiffChange
    highlight clear DiffText

    " Allow for overrides:
    " example:
    " - `statusline.vim` will re-set User1, User2 etc.
    " - `after/plugin/loupe.vim` will override Search.
    doautocmd ColorScheme
    "   hi Normal guibg=NONE ctermbg=NONE
    "   hi! Normal ctermbg=NONE guibg=NONE
    hi! NonText ctermbg=NONE guibg=NONE guifg=NONE ctermfg=NONE
    if &background ==# 'light'
        highlight CursorLine gui=none guibg=lightBlue
    else
        highlight CursorLine gui=none guibg=grey25
    endif
    highlight CursorLineNr term=bold cterm=bold gui=bold 

    " Spelling mistakes will be colored up red.
    hi SpellBad cterm=underline ctermfg=201 guifg=#ff5f5f
    hi SpellLocal cterm=underline ctermfg=202 guifg=#ff5f5f
    hi SpellRare cterm=underline ctermfg=203 guifg=#ff5f5f
    hi SpellCap cterm=underline ctermfg=203 guifg=#ff5f5f
endfunction

if v:progname !=# 'vi'
    if has('autocmd')
        augroup Autocolor
            autocmd!
            autocmd FocusGained * call s:CheckColorScheme()
        augroup END
    endif

    call s:CheckColorScheme()
endif

