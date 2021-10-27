# Make sure the shell is interactive
case $- in
    *i*) ;;
    *) return ;;
esac

export HISTCONTROL=ignoreboth:erasedups

#PS1='[\u@\h \W]\$ '

#shopt
shopt -s autocd # change to named directory
shopt -s cdspell # autocorrects cd misspellings
shopt -s cmdhist # save multi-line commands in history as single line
shopt -s dotglob
shopt -s histappend # do not overwrite history
shopt -s expand_aliases # expand aliases


export EDITOR=vim

export VIMCONFIG=~/.vim
export VIMDATA=~/.vim
export MYVIMRC=~/.vim/vimrc
### "vim" as manpager
export MANPAGER='/bin/bash -c "vim -MRn -c \"set buftype=nofile showtabline=0 ft=man ts=8 nomod nolist norelativenumber nonu noma\" -c \"normal L\" -c \"nmap q :qa<CR>\"</dev/tty <(col -b)"'
#export MANPAGER="vim -M +MANPAGER -"

stty -ixon  #Note that <C-Q> only works in a terminal if you disable flow control
            # from vim-unimpaired plugin

# for cppman
#export COMP_WORDBREAKS=" /\"\'><;|&("
cppman -m true

# Execute Alias definitions. {{{
DISTRO=$(cat /etc/issue  | head -n +1 | awk '{print $1}')
if [[ -f $HOME/.config/bash/aliasses/$DISTRO ]]; then
    . "$HOME"/.config/bash/aliasses/"$DISTRO"
else
    . "$HOME"/.config/bash/aliasses/default
fi
# }}}

#
if [[ $TERM == xterm-termite ]]; then
    . /etc/profile.d/vte.sh
    __vte_prompt_command
fi

# Base16 Shell {{{
BASE16_SHELL="$HOME/.config/base16-shell/"

if [[ ! -f $BASE16_SHELL/profile_helper.sh ]]; then
    git clone https://github.com/chriskempson/base16-shell.git "$BASE16_SHELL"
fi

[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"
# }}}

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="/home/shadday/.local/bin:$PATH"
export PATH="/home/shadday/.config/bash/scripts/:$PATH"
export DENO_INSTALL="/home/shadday/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"
export PATH=".:$PATH"
#export MANPATH="$(manpath -g):$HOME/.cache/cppman:$HOME/.cache/cppman/manindex"   #no set for now

# install font JetBrains Mono Regular Nerd Font Complete.ttf
FONT_INSTALLED=$(fc-list | grep -i "JetBrainsMono");
if [ -z "$FONT_INSTALLED" ]; then
   FONT_INSTALL_PATH="$HOME/.local/share/fonts"
   FONT_URL="https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/Regular/complete/JetBrains%20Mono%20Regular%20Nerd%20Font%20Complete.ttf"
   FONT_NAME="JetBrains Mono Regular Nerd Font Complete.ttf"
   curl -fLo "$FONT_NAME" "$FONT_URL"
   if [ ! -d "$FONT_INSTALL_PATH" ]; then
      mkdir "$FONT_INSTALL_PATH"
   fi
   mv "$FONT_NAME" "$FONT_INSTALL_PATH"
   fc-cache -f -v
fi

neofetch

source "$HOME"/.config/bash/oh-my-bash.conf
source "$HOME"/.config/bash/scripts/color.sh

# Key bindings for command-line and Fuzzy finder completion for bash
source /usr/share/fzf/completion.bash
source /usr/share/fzf/key-bindings.bash

# fzf
export FZF_DEFAULT_COMMAND='fd --type f --color=never --hidden --exclude={.git,.idea,.vscode,.sass-cache,node_modules,build}'
export FZF_DEFAULT_OPTS="-m --layout=reverse  --height 40% --color=bg+:#343d46,gutter:-1,pointer:#ff3c3c,info:#0dbc79,hl:#0dbc79,hl+:#23d18b --preview '(highlight -O ansi {} || bat {}) 2> /dev/null | head -500'"

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="-m --preview 'bat --color=always --line-range :50 {}'"

export FZF_ALT_C_COMMAND='fd --type d . --color=never --hidden'
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -50'"

export BAT_THEME="base16-256"

### CREATE CUSTOM PROMPT(S)
#PS1=$'\n\e[1;36m %@ [%.] %# \e[0m\e[4 q' # for zsh
  # \n - new line
  # %# - specifies whether the user is root (#) or otherwise (%)
  # \e[1;36m - applies bold and cyan color to the following text (list of options in the LS_COLORS file on the www-gem gitlab)
  # %@ - time in 12h format
  # %. - current directory (not the full path)
  # \e[0m - exit color-change
  # \e[4 q - show the cursor as underline _
    # 0 -> blinking block
    # 1 -> blinking block (default)
    # 2 -> steady block
    # 3 -> blinking underline
    # 4 -> steady underline
    # 5 -> blinking bar (xterm)
    # 6 -> steady bar (xterm)
  # Note that zsh also offers a right sided prompt with the RPROMPT variable. It uses the same placeholders as the PS1 prompt.

  ### OTHER ZSH OPTIONS
  # %D - the date in yy-mm-dd format
  # %T - current time of day, in 24-hour format
  # %t or %@ - current time of day, in 12-hour, am/pm format
  # %* - current time of day in 24-hour format, with seconds
  # %w - the date in day-dd format
  # %W - the date in mm/dd/yy format
  # %D{string} - string is formatted using the strftime function. See man page strftime(3) for more details. Various zsh extensions provide numbers with no leading zero or space if the number is a single digit
  # %f - the day of the month
  # %K - the hour of the day on the 24-hour clock
  # %L - the hour of the day on the 12-hour clock
  # %l - the line (tty) the user is logged in on, without ‘/dev/’ prefix. If the name starts with ‘/dev/tty’, that prefix is stripped
  # %M - the full machine hostname
  # %m - the hostname up to the first ‘.’. An integer may follow the ‘%’ to specify how many components of the hostname are desired. With a negative integer, trailing components of the hostname are shown
  # %n - $USERNAME
  # %y - the line (tty) the user is logged in on, without ‘/dev/’ prefix. This does not treat ‘/dev/tty’ names specially
  # %? - the return status of the last command executed just before the prompt
  # %_ - the status of the parser, i.e. the shell constructs (like ‘if’ and ‘for’) that have been started on the command line. If given an integer number that many strings will be printed; zero or negative or no integer means print as many as there are. This is most useful in prompts PS2 for continuation lines and PS4 for debugging with the XTRACE option; in the latter case it will also work non-interactively
  # %^ - the status of the parser in reverse. This is the same as ‘%_’ other than the order of strings. It is often used in RPS2
  # %d or %/ - current working directory. If an integer follows the ‘%’, it specifies a number of trailing components of the current working directory to show; zero means the whole path. A negative integer specifies leading components, i.e. %-1d specifies the first component
  # %~ - as %d and %/, but if the current working directory starts with $HOME, that part is replaced by a ‘~’. Furthermore, if it has a named directory as its prefix, that part is replaced by a ‘~’ followed by the name of the directory, but only if the result is shorter than the full path; Filename Expansion
  # %e - evaluation depth of the current sourced file, shell function, or eval. This is incremented or decremented every time the value of %N is set or reverted to a previous value, respectively. This is most useful for debugging as part of $PS4
  # %h or %! - current history event number
  # %i - the line number currently being executed in the script, sourced file, or shell function given by %N. This is most useful for debugging as part of $PS4
  # %I - the line number currently being executed in the file %x. This is similar to %i, but the line number is always a line number in the file where the code was defined, even if the code is a shell function
  # %j - the number of jobs
  # %L - the current value of $SHLVL
  # %N - the name of the script, sourced file, or shell function that zsh is currently executing, whichever was started most recently. If there is none, this is equivalent to the parameter $0. An integer may follow the ‘%’ to specify a number of trailing path components to show; zero means the full path. A negative integer specifies leading components
  # %x - the name of the file containing the source code currently being executed. This behaves as %N except that function and eval command names are not shown, instead the file where they were defined
  # %c or % or %C - trailing component of the current working directory. An integer may follow the ‘%’ to get more than one component. Unless ‘%C’ is used, tilde contraction is performed first. These are deprecated as %c and %C are equivalent to %1~ and %1/, respectively, while explicit positive integers have the same effect as for the latter two sequences

  ### BASH OPTIONS
  # \$ - specifies whether the user is root (#) or otherwise ($)
  # \d – date (day/month/date)
  # \h – hostname (short)
  # \H – full hostname (domain name)
  # \j – number of jobs being managed by the shell
  # \l – the basename of the shells terminal device
  # \r – carriage return
  # \s – the name of the shell
  # \t – time (hour:minute:second)
  # \A – time, 24-hour, without seconds
  # \u – current username
  # \v – bASH version
  # \V – extra information about the BASH version
  # \w – current working directory ($HOME is represented by ~)
  # \W – the basename of the working directory ($HOME is represented by ~)
  # \[ – start a sequence of non-displayed characters (useful if you want to add a command or instruction set to the prompt)
  # \] – close or end a sequence of non-displayed characters

