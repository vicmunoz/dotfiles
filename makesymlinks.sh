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
files="bashrc zshrc vimrc vim gitignore"

##########

install_dotfiles () {
  # create dotfiles_old in homedir
  echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
  mkdir -p $olddir
  echo "$olddir for backup done"
  
  # change to the dotfiles directory
  echo "Changing to the $dir directory ..."
  cd $dir
  
  # Backup any existing dotfile in homedir to dotfiles_old directory, 
  echo "Backup existing dotfiles"
  for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    # mv ~/.$file ~/dotfiles_old/ # original code, trying below line to see if it works
    mv ~/.$file $olddir/
  done
  echo "Backup done"
  
  # then create symlinks from the homedir to any files in the ~/dotfiles 
  # directory specified in $files
  echo "Starting to create symlinks"
  for file in $files; do
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
  done
  echo "Symlinks done"
  
  # Clone vim plugins
  echo "Starting download of vim plugins"
  cd $dir/vim/bundle
  git clone git@github.com:vim-ruby/vim-ruby.git
  git clone git@github.com:vimwiki/vimwiki.git
  cd $dir
  echo "VIM plugins done"
  
  # Install liquidprompt (https://github.com/nojhan/liquidprompt)
  echo "Installing liquidprompt"
  git clone https://github.com/nojhan/liquidprompt.git
  echo "liquidprompt done"

  # Exclude vim plugins and liquidprompt from git track files
  echo "Adding vim plugins and liquidprompt folder to git exclude"
  echo "liquidprompt/" >> $dir/.git/info/exclude
  echo "vim/bundle/" >> $dir/.git/info/exclude

}

install_zsh () {
# Test to see if zshell is installed.  If it is:
if [ -f /bin/zsh -o -f /usr/bin/zsh ]; then
  echo "ZHS installation detected"
  # Install oh-my-zsh from GitHub
  echo "Installing oh-my-zsh" 
  cd ~
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  echo "oh-my-zsh done"
  echo "Checking current SHELL"
  # Set the default shell to zsh if it isn't currently set to zsh
  if [[ ! $(echo $SHELL) == $(which zsh) ]] && [[ ! $(echo $SHELL) == '/bin/zsh' ]]; then
    echo "Changing default SHELL to ZSH"
    chsh -s $(which zsh)
  fi
else
  echo "Not detected a valid ZSH installation"
  # If zsh isn't installed, get the platform of the current machine
  platform=$(uname);
  # If the platform is Linux, try an apt-get to install zsh and then recurse
  if [[ $platform == 'Linux' ]]; then
    echo "Linux platform detected"
    if [[ -f /etc/redhat-release ]]; then
      echo "RedHat platform detected"
      sudo yum install zsh
      install_zsh
    fi
    if [[ -f /etc/debian_version ]]; then
      echo "Debian based platform detected"
      sudo apt-get install zsh
      install_zsh
    fi
  # If the platform is OS X, tell the user to install zsh :)
  elif [[ $platform == 'Darwin' ]]; then
    echo "OS X platform detected"
    echo "Please install zsh, then re-run this script!"
    exit
  fi
fi
}

install_zsh
install_dotfiles

