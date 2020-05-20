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
[[ -n "$DISPLAY" && "$TERM" = "xterm" ]] && export TERM=xterm-256color
#

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

#######################  OH MY BASH ####################################
#
# Path to your oh-my-bash installation.
export OSH=/$HOME/.config/bash/oh-my-bash

if [[ ! -f $OSH/oh-my-bash.sh ]]; then
    git clone git://github.com/ohmybash/oh-my-bash.git $OSH
fi

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-bash is loaded.
OSH_THEME="agnoster"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_OSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $OSH/custom?
# OSH_CUSTOM=/path/to/new-custom-folder

# Which completions would you like to load? (completions can be found in ~/.oh-my-bash/completions/*)
# Custom completions may be added to ~/.oh-my-bash/custom/completions/
# Example format: completions=(ssh git bundler gem pip pip3)
# Add wisely, as too many completions slow down shell startup.
completions=(
  git
  composer
  ssh
)

# Which aliases would you like to load? (aliases can be found in ~/.oh-my-bash/aliases/*)
# Custom aliases may be added to ~/.oh-my-bash/custom/aliases/
# Example format: aliases=(vagrant composer git-avh)
# Add wisely, as too many aliases slow down shell startup.
aliases=(
  general
)

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-bash/plugins/*)
# Custom plugins may be added to ~/.oh-my-bash/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  bashmarks
)

source $OSH/oh-my-bash.sh

# User configuration
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-bash libs,
# plugins, and themes. Aliases can be placed here, though oh-my-bash
# users are encouraged to define aliases within the OSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias bashconfig="mate ~/.bashrc"
# alias ohmybash="mate ~/.oh-my-bash"

source "$HOME"/.config/bash/scripts/color.sh
