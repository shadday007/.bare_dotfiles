git clone --separate-git-dir=$HOME/.dotfiles https://github.com/shadday007/.dotfiles.git tmpdotfiles
rsync --recursive --verbose --exclude '.git' tmpdotfiles/ $HOME/
rm -r tmpdotfiles

https://github.com/shadday007/.dotfiles/blob/master/dotfiles_install.sh | /bin/bash
