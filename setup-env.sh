#!/bin/sh

# Install Apps

# Must haves
# XCode and command line tools
# Mac vim, Total finder, iTerm2, Chrome, Dropbox, Alfred, Sparrow

# Rest
# Skype, pester, adium,
# httpclient, notational velocity alt, 
# MSOffice, photoshop, VLC, Yojimbo, Virtual box, Sparrow, Skitch
# Sequel pro 

# Set up keyboard defaults, repeat rate, caps lock as control etc...

# Set default shell to zsh

# Install solarized theme for iterm2
# Install Alfred extensions

# Get babushka
#bash -c "`curl babushka.me/up`"

# Remove glass dock
#defaults write com.apple.dock no-glass -boolean YES && killall Dock
#osascript -e 'tell app "Finder" to quit'

# Hide ping dropdowns
# Restore itunes arrows and set their defaul to filter my own library.
defaults write com.apple.iTunes hide-ping-dropdown 1
defaults write com.apple.iTunes show-store-link-arrows 1
defaults write com.apple.iTunes invertStoreLinks 1

# Go to terminal preferences and select keyboard tab
# Change home, and end keys so that the following sequences are placed in and allow
# for movement to start and end of line
#
#Home	\033[1~
#End	\033[4~
#Page Up	\033[5~
#Page Down	\033[6~

# Get home, end etc.. working correctly
curl https://raw.github.com/gist/810749/d4ff1627f3f1675be82ee29b44f362e56e93853e/DefaultKeyBinding.dict > ~/Library/KeyBindings/DefaultKeyBinding.dict

# Install Homebrew
ruby <(curl -fsSkL raw.github.com/mxcl/homebrew/go)

brew install git rbenv ruby-build
brew install ctags wget tree flip ack rbenv ruby-build
brew install mysql ghc plt-racket node leiningen qt postgresql rename imagemagick apple-gcc42 mongodb
#brew install flip htop multimarkdown

#easy_install mercurial # or brew install pip && pip install mercurial

rbenv install 1.9.3-p194
gem install ghost bundler awesome_print pry

# TODO Set up ssh keys

# Grab my dotfiles
cd && git clone git@github.com:grassdog/dotfiles.git .dotfiles
cd .dotfiles && rake install

# Setup vim
cd && git clone git@github.com:grassdog/vimfiles.git .vim
cd .vim && rake setup

