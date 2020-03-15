#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export HISTCONTROL=ignoreboth:erasedups

PS1='[\u@\h \W]\$ '


# Aliases for software managment
# pacman or pm
alias pmsyu="sudo pacman -Syu --color=auto"
alias pacman='sudo pacman --color auto'
alias update='sudo pacman -Syu'

# pacaur or pc
alias pcsyu="pacaur -Syu"

#ps
alias ps="ps auxf"
alias psgrep="ps aux | grep -v grep | grep -i -e VSZ -e"

# yaourt keeps tmp folder cleaner than packer
alias pks="yaourt -S --noconfirm "
alias pksyu="yaourt -Syu --noconfirm"
alias pksyua="yaourt -Syu  --aur --noconfirm"

#grub update
alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"

#improve png
alias fixpng="find . -type f -name "*.png" -exec convert {} -strip {} \;"

#add new fonts
alias fc='sudo fc-cache -fv'

#get fastest mirrors in your neighborhood 
alias mirror="sudo reflector --protocol https --latest 50 --number 20 --sort rate --save /etc/pacman.d/mirrorlist"
alias mirrors=mirror


# Alias for dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
#
#
#shopt
shopt -s autocd # change to named directory
shopt -s cdspell # autocorrects cd misspellings
shopt -s cmdhist # save multi-line commands in history as single line
shopt -s dotglob
shopt -s histappend # do not overwrite history
shopt -s expand_aliases # expand aliases


EDITOR=vim

neofetch
export VIMCONFIG=~/.vim
export VIMDATA=~/.vim
export MYVIMRC=~/.vim/vimrc
#export VIMDATA=~/.local/share/nvim
#export VIMCONFIG=~/.config/nvim
#. ~/nvim-aliases.sh
#[ -n "$PS1" ] && sh ~/.vim/pack/minpac/start/snow/shell/snow_dark.sh
# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"



# Source a script if it is executable
source_script() {
            [[ "${@:-1}" == "force" ]] && FORCE=1
            for script in $*; do
                if [[ -x $script || "$FORCE" == 1 ]]; then
                    source $script
                fi
            done
}

# Execute Alias definitions.
if [[ -f $HOME/.config/bash/aliasses/$HOSTNAME ]]; then
    . "$HOME"/.config/bash/aliasses/$HOSTNAME
else
    . "$HOME"/.config/bash/aliasses/default
fi
