#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export HISTCONTROL=ignoreboth:erasedups

PS1='[\u@\h \W]\$ '

#shopt
shopt -s autocd # change to named directory
shopt -s cdspell # autocorrects cd misspellings
shopt -s cmdhist # save multi-line commands in history as single line
shopt -s dotglob
shopt -s histappend # do not overwrite history
shopt -s expand_aliases # expand aliases


EDITOR=vim

export VIMCONFIG=~/.vim
export VIMDATA=~/.vim
export MYVIMRC=~/.vim/vimrc

#
if [[ $TERM == xterm-termite ]]; then
    . /etc/profile.d/vte.sh
    __vte_prompt_command
fi

# Base16 Shell {{{
BASE16_SHELL="$HOME/.config/base16-shell/"

if [[ ! -f $BASE16_SHELL/profile_helper.sh ]]; then
    git clone https://github.com/chriskempson/base16-shell.git $BASE16_SHELL
fi

[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"


# }}}

# Execute Alias definitions. {{{
DISTRO=$(cat /etc/issue | head -n +1 | awk '{print $1}')
if [[ -f $HOME/.config/bash/aliasses/$DISTRO ]]; then
    . "$HOME"/.config/bash/aliasses/$DISTRO
else
    . "$HOME"/.config/bash/aliasses/default
fi
# }}}

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="/home/shadday/.local/bin:$PATH"
export PATH="/home/shadday/.config/bash/scripts/:$PATH"
export DENO_INSTALL="/home/shadday/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

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
