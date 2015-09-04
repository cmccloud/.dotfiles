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
# Install homebrew and cask
###############################################################################
running "checking homebrew install"
brew_bin=$(which brew) 2>&1 > /dev/null
if [[ $? != 0 ]]; then
	action "installing homebrew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    if [[ $? != 0 ]]; then
    	error "unable to install homebrew, script $0 abort!"
    	exit -1
	fi
fi
ok

running "checking brew-cask install"
output=$(brew tap | grep cask)
if [[ $? != 0 ]]; then
	action "installing brew-cask"
	require_brew caskroom/cask/brew-cask
fi
ok

###############################################################################
# Install command-line tools using Homebrew
###############################################################################
# Make sure we’re using the latest Homebrew
running "updating homebrew"
brew update
ok

bot "before installing brew packages, we can upgrade any outdated packages."
read -r -p "run brew upgrade? [y|N] " response
if [[ $response =~ ^(y|yes|Y) ]];then
    # Upgrade any already-installed formulae
    action "upgrade brew packages..."
    brew upgrade
    ok "brews updated..."
else
    ok "skipped brew package upgrades.";
fi

bot "installing homebrew command-line tools"

###############################################################################
bot "System Tools..."
###############################################################################
# Install GNU core utilities (those that come with OS X are outdated)
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
require_brew coreutils
# Install some other useful utilities like `sponge`
require_brew moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed
require_brew findutils
# Install GNU TLS
require_brew gnutls
# Install openssl
require_brew openssl
# skip those GUI clients, git command-line all the way
require_brew git
# Extend Git with Hub
require_brew hub
# yes, yes, use git-flow, please :)
require_brew git-flow
# Text-based git UI
require_brew tig
# why is everyone still not using GPG?
require_brew gnupg
# Install ACK
require_brew ack
# Install AG
require_brew the_silver_searcher
# Install Gtags
require_brew global --with-exuberant-ctags --with-pygments
# PDFGrep is used by pdf-tools (Emacs)
# require_brew pdfgrep
# docker setup:
# require_brew boot2docker
# Wrapper for Ack, used for Text Searching
# require_brew gawk
# Install GNU `sed`, overwriting the built-in `sed`
# so we can do "sed -i 's/foo/bar/' file" instead of "sed -i '' 's/foo/bar/' file"
require_brew gnu-sed --default-names
# better, more recent grep
require_brew homebrew/dupes/grep
# Imagemagick support
require_brew imagemagick
# Install imagesnap
require_brew imagesnap
# jq is a JSON grep
# require_brew jq
# Network Tool
require_brew nmap
# better, more recent vim
require_brew vim --override-system-vi
# Install Watch: Executes a program periodically, showing output fullscreen
# require_brew watch
# Install wget with IRI support: Internet file retriever
require_brew wget --enable-iri
# Better support for command line repls
require_brew rlwrap
# Syntax Checking in Emacs
require_brew aspell
# PDF Support Tools
require_brew mupdf
# Local storage for e-mail
require_brew offline-imap
# Command Line shortcuts
# require_brew fasd

# Terminals
require_brew zsh
# require_brew bash


# Languages and Programming
# require_brew plantuml
# require_brew mit-scheme
# require_brew python
# require_brew android-sdk

# Databases
require_brew redis
require_brew mongodb
require_brew couchdb
require_brew postgresql

###############################################################################
# Language Specific Configuration
###############################################################################

###############################################################################
# Clojure
bot "Installing Leiningen..."
###############################################################################
require_brew leiningen
# require_brew boot-clj

###############################################################################
# Javascript
bot "Installing Node and NPM Globals..."
###############################################################################
# Use NVM to manage node and npm
require_brew nvm
require_nvm stable
# NPM Modules
require_npm tern
require_npm bower
require_npm browserify
# http://ionicframework.com/
# require_npm cordova
# require_npm ionic
require_npm yo
# https://github.com/markdalgleish/bespoke.js
# require_npm generator-bespoke
rqeuire_npm grunt-cli
require_npm gulp
require_npm jspm
require_npm karma
require_npm karma-cli
require_npm jshint
# require_npm http-server
# require_npm mocha
require_npm nodemon
# require_npm ndoeunit
# require_npm phantomjs
# require_npm protractor
# http://devo.ps/blog/goodbye-node-forever-hello-pm2/
require_npm pm2
require_npm prettyjson
# require_npm supervisor
# https://github.com/sindresorhus/trash
require_npm trash
# https://github.com/MrRio/vtop
# require_npm vtop
require_npm azure-cli

###############################################################################
# Ruby Support
# bot "Ruby Gems..."
###############################################################################
# require_brew rbenv
# require_brew ruby-build
# eval "$(rbenv init -)"
# require_gem git-up

###############################################################################
# Native Apps (via brew cask)
bot "installing GUI tools via homebrew casks..."
###############################################################################
brew tap caskroom/versions > /dev/null 2>&1
brew tap railwaycat/emacsport > /dev/null 2>$1

# Apps to Install Manually
# Evernote
# Popcorn-Time
# Xcode - xcode-select --install from command line for just CLI to xcode

# Install to Applications folder
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# Editors
require_cask emacs
require_cask sublime-text3
# require_cask emacs-mac
# require_cask webstorm
# require_cask atom
# require_cask intellij-idea

# Tools
require_cask java
require_cask iterm2
require_cask alfred
require_cask gpgtools
require_cask the-unarchiver
require_cask transmission
require_cask vlc
require_cask xquartz
require_cask hammerspoon
require_cask flux
require_cask gfxcardstatus
require_cask seil
require_cask karabiner
require_cask marked
require_cask google-earth
# require_cask diffmerge
# require_cask github
# require_cask onyx

# Web Browsers
# require_cask breach
require_cask firefox
# require_cask firefox-aurora
require_cask google-chrome
# require_cask google-chrome-canary
# require_cask torbrowser

# Cloud Storage
require_cask google-drive
# require_cask amazon-cloud-drive
# require_cask box-sync
# require_cask dropbox

# Communication
require_cask slack
require_cask skype
require_cask gitter

# Virtal Machines
# require_cask virtualbox
# chef-dk, berkshelf, etc
# require_cask chefdk
# vagrant for running dev environments using docker images
# require_cask vagrant # # | grep Caskroom | sed "s/.*'\(.*\)'.*/open \1\/Vagrant.pkg/g" | sh

# bot "Alright, cleaning up homebrew cache..."
# Remove outdated versions from the cellar
# brew cleanup > /dev/null 2>&1
# bot "All clean"

bot "Homebrew Setup Finished!"
