1.- Make sure you have committed the alias to your .bashrc or .zsh:
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
#### Usage
##### Use the dgit alias like you would use the git command
~~~ sh
dgit status
dgit add --update <filename1> <filename2> ...
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
