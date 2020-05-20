git clone --bare https://github.com/shadday007/.dotfiles.git $HOME/.dotfiles
function config {
   /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
}
mkdir -p .dotfiles-backup
config config status.showUntrackedFiles no
config checkout
if [ $? = 0 ]; then
  echo "Checked out config.";
  else
    echo "Backing up pre-existing dot files.";
    # make directories for files
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{}  dirname .dotfiles-backup/{} | xargs -I{} mkdir -p {}
    # move dot files
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv -f {} .dotfiles-backup/{}
    # move regular files
    config checkout 2>&1 | egrep "^\s+.+" | awk {'print $1'} | xargs -I{} mv -f {} .dotfiles-backup/{}
fi;
config checkout

