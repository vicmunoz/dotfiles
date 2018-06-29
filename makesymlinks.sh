#!/bin/bash
############################
# makesymlinks.sh
# This script creates symlinks from the home directory to any desired 
# dotfiles in ~/dotfiles
# see https://github.com/michaeljsmalley/dotfiles/blob/master/makesymlinks.sh
# for original script source code
############################

########## Variables
# dotfiles directory
dir=~/dotfiles
# old dotfiles backup directory
#olddir=~/dotfiles_old
olddir=~/dotfiles_$(date +%s)
# list of files/folders to symlink in homedir
# based on platform, files could be different ie: zshrc.linux, zshrc.darwin
files="bashrc zshrc oh-my-zsh vimrc vim gitignore"

##########

# create dotfiles_old in homedir
echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
mkdir -p $olddir
echo "done"

# change to the dotfiles directory
echo -n "Changing to the $dir directory ..."
cd $dir
echo "done"

# Backup any existing dotfile in homedir to dotfiles_old directory, 
echo -n "Backup existing dotfiles"
for file in $files; do
  echo "Moving any existing dotfiles from ~ to $olddir"
  # mv ~/.$file ~/dotfiles_old/ # original code, trying below line to see if it works
  mv ~/.$file $olddir/
done

# then create symlinks from the homedir to any files in the ~/dotfiles 
# directory specified in $files
echo -n "Starting to create symlinks"
for file in $files; do
  echo "Creating symlink to $file in home directory."
  ln -s $dir/$file ~/.$file
done


install_zsh () {
# Test to see if zshell is installed.  If it is:
if [ -f /bin/zsh -o -f /usr/bin/zsh ]; then
  # Install oh-my-zsh from GitHub 
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

  # Set the default shell to zsh if it isn't currently set to zsh
  if [[ ! $(echo $SHELL) == $(which zsh) ]] && [[ ! $(echo $SHELL) == '/bin/zsh' ]]; then
    chsh -s $(which zsh)
  fi
else
  # If zsh isn't installed, get the platform of the current machine
  platform=$(uname);
  # If the platform is Linux, try an apt-get to install zsh and then recurse
  if [[ $platform == 'Linux' ]]; then
    if [[ -f /etc/redhat-release ]]; then
      sudo yum install zsh
      install_zsh
    fi
    if [[ -f /etc/debian_version ]]; then
      sudo apt-get install zsh
      install_zsh
    fi
  # If the platform is OS X, tell the user to install zsh :)
  elif [[ $platform == 'Darwin' ]]; then
    echo "Please install zsh, then re-run this script!"
    exit
  fi
fi
}

install_zsh
