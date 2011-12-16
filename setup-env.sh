#!/bin/sh

# TODO Install XCode

# TODO set up keyboard defaults, repeat rate etc...

# TODO Set default shell to zsh
# Bump up keyboard repeat rate

# Set up personal pro theme for Terminal
# set background opacity to 100
# set render bright as bold
# set menlo bold, 12pt as font
# set cursor color to green
# set highlight color to blue
# set size 100x43
# set title active process name
# set new pro as default
# install fonts, Inconsolata

# Get babushka
#bash -c "`curl babushka.me/up`"

# Remove glass dock
defaults write com.apple.dock no-glass -boolean YES && killall Dock
osascript -e 'tell app "Finder" to quit'

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
ruby -e "$(curl -fsSL https://raw.github.com/gist/323731)"

brew install git ctags wget tree vcprompt ack flip htop multimarkdown growlnotify
#brew install mysql ghc mit-scheme node tmux
#easy_install mercurial # or brew install pip && pip install mercurial

# Install multimarkdown support and services

# Apps to install
# ruby mine, sequel pro, mac vim, git x, skype, pester, adium,
# chrome, firefox, httpclient, dropbox, notational velocity alt, Alfred
# textmate, MSOffice, acorn, photoshop, VLC, Yojimbo, virtual box, peepopen, Sparrow, Skitch
# Total finder, iterm2

# Install solarized theme for iterm2

# TODO Change with rbenv
bash < <( curl http://rvm.beginrescueend.com/releases/rvm-install-head )
rvm install ruby-1.9.2
rvm install ruby-1.8.7
rvm use ruby-1.9.2 --default
rvm use ruby-1.9.2@global
gem install homesick ghost cheat bundler vagrant awesome_print key-installer

# TODO Set up ssh keys

# Grab my dotfiles
homesick clone git@github.com:grassdog/dotfiles.git
homesick symlink dotfiles

# Setup vim
cd && git clone git@github.com:grassdog/vimfiles.git .vim
cd .vim && rake setup

# Grab bin files
cd && [ -d 'bin' ] || git clone git@github.com:grassdog/environment.git bin
