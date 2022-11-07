##### Note:
I have decided to use another repository for my dotfiles and manage these with **GNU stow**. This repository has served me for quite some time, but I still find it annoying because the configuration files are mixed in with other files that do not belong to the repository. That is why I want to take a more traditional approach and also revisit my vim configuration, as it has become a bit slow with the incorporation of coc.vim,don't make me wrong it is a wonderful plugin. But I am not 100% sure that I need it. I still want the configuration to be common for vim and neovim. I say this because at the moment there is a choice to make between Lua(Neovim) and vim9script(vim) for the configuration. Where will my configuration go? I have no idea yet.

## Using bare repository technique
#### Create the directory for your bare repository
~~~ sh
mkdir ~/.dotfiles
~~~
#### Initialize a bare repository in the directory you just created
~~~ sh
git init --bare ~/.dotfiles
~~~
Make sure you have committed the alias to your .bashrc or .zsh:
#### Alias
~~~ sh
# Alias for dotfiles
alias dgit='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
~~~
Ignore the files that are not being tracked from being shown up in git status:
#### Config
~~~ sh
dgit config --local status.showUntrackedFiles no
~~~
#### Add the remote location to the repository (in this case GitHub)
~~~ sh
dgit remote add origin https://github.com/$USERNAME/$REPOSITORY.git
~~~
#### Usage
##### Use the dgit alias like you would use the git command
~~~ sh
dgit status
dgit add --update filename1 filename2 ...
dgit commit -m "my comments..."
dgit push
~~~
##### Listing files (not tracked by git)
~~~ sh
dgit status -u .config/bash/scripts
~~~
##### Listing files (tracked by git)
~~~ sh
dgit ls-files
dgit ls-files .vim
~~~
#### Install your dotfiles onto a new system
~~~ sh
git clone --separate-git-dir=$HOME/.dotfiles https://github.com/shadday007/.dotfiles.git tmpdotfiles
rsync --recursive --verbose --exclude '.git' tmpdotfiles/ $HOME/

rm -r tmpdotfiles

curl -Lks https://raw.githubusercontent.com/shadday007/.dotfiles/master/dotfiles_install.sh | /bin/bash
~~~
