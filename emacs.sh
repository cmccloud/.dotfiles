#!/usr/bin/env bash

# include my library helpers for colorized echo and require_brew, etc
source ./lib.sh

# Ask for the administrator password upfront
bot "checking sudo state..."
if sudo grep -q "# %wheel\tALL=(ALL) NOPASSWD: ALL" "/etc/sudoers"; then
    promptSudo
fi
ok

###############################################################################
# Configure Emacs
###############################################################################
# Symlink emacs script
ln -s -f ./bin/emacs /usr/bin/emacs
# Symlink emacsclient script
ln -s -f ./bin/ec /usr/bin/ec
# Backup .emacs.d
mv ~/.emacs.d ~/.emacs.d.bak
# Install Spacemacs
git clone --recursive https://github.com/cmccloud/spacemacs ~/.emacs.d
# Move to stable branch
cd ~/.emacs.d;git checkout develop-stable;
# Install mu
brew install mu --with-emacs --HEAD
