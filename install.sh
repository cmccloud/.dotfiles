#!/usr/bin/env bash

###################################################################################
# This script installs the dotfiles and runs all other system configuration scripts
###################################################################################

# include my library helpers for colorized echo and require_brew, etc
source ./lib.sh

# make a backup directory for overwritten dotfiles
if [[ ! -e ~/.dotfiles_backup ]]; then
    mkdir ~/.dotfiles_backup
fi

echo $0 | grep zsh > /dev/null 2>&1 | true
if [[ ${PIPESTATUS[0]} != 0 ]]; then
  running "changing your login shell to zsh"
  chsh -s $(which zsh);ok
else
  bot "looks like you are already using zsh. woot!"
fi

pushd ~ > /dev/null 2>&1

bot "creating symlinks for project dotfiles..."

symlinkifne .spacemacs.d
symlinkifne .lein
symlinkifne .hammerspoon
symlinkifne .authinfo
symlinkifne .offlineimaprc
symlinkifne .gitconfig
symlinkifne .profile
symlinkifne .shellaliases
symlinkifne .shellfn
symlinkifne .shellpaths
symlinkifne .shellvars
symlinkifne .zshrc
symlinkifne .oh-my-zsh

popd > /dev/null 2>&1

# Home Brew and Cask Apps
# ./homebrew.sh
# Emacs Config
# ./emacs.sh
# OSX System and App Settings
# ./osx.sh

bot "Woot! All done."
