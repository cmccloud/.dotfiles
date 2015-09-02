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
# Configure Emacs Symlinks and Extra Packages
###############################################################################
# Replaces cli emacs script with script from bin
ln -s -f ./bin/emacs /usr/bin/emacs
# Adds emacs client script
ln -s -f ./bin/ec /usr/bin/ec
# Once that is complete, we can install mu
brew install mu --with-emacs --HEAD
