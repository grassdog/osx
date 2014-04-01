#!/bin/sh

################
# Setup my MacOSX Environment how I like it
################

# Disable trash and extension change warnings and view extensions in finder preferences
# Set up keyboard defaults, repeat rate, caps lock as control etc...
# Set desktop background to point to dropbox backgrounds folder
# Set default shell to zsh (in user menu)
# Don't play feedback when volume is changed

# Install fonts

# Enable full keyboard access for all controls (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true

# Disable menu bar transparency
defaults write NSGlobalDomain AppleEnableMenuBarTransparency -bool false

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Automatically open a new Finder window when a volume is mounted
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true

# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Hide ping dropdowns and restore itunes arrows and set their default to filter my own library.
defaults write com.apple.iTunes hide-ping-dropdown 1
defaults write com.apple.iTunes show-store-link-arrows 1
defaults write com.apple.iTunes invertStoreLinks 1

# Reset Launchpad
rm ~/Library/Application\ Support/Dock/*.db

# Show the ~/Library folder
cd
sudo chflags nohidden ~/Library

# Disable local Time Machine backups
sudo tmutil disablelocal

# Kill affected applications
for app in Safari Finder Dock Mail; do killall "$app"; done

# Fix for the ancient UTF-8 bug in QuickLook (http://mths.be/bbo)
echo "0x08000100:0" > ~/.CFUserTextEncoding

################
# Install Apps
################

# XCode and command line tools
# Mac vim, Total finder, iTerm2, Chrome, Dropbox, Alfred, Sparrow, Moom
# Skype, Pester, Adium, Super Duper, Github, Kindle, Perian
# XQuarts (for an X-server)
# HttpClient, MSOffice, Photoshop, VLC, Yojimbo, Secureid
# Sequel pro?

# Set up iTerm

# Import Solarized theme
# Set font to menlo 12pt bold and menlo 12pt
# keys left option key acts as +esc
# Disable confirm closing
# disable contacts in Alfred
# Disable spaces keyboard shortcuts etc..

# Install Alfred extensions

# Get babushka
bash -c "`curl babushka.me/up`"

# Get home, end etc.. keys working correctly
mkdir -p ~/Library/KeyBindings
curl https://raw.github.com/gist/810749/d4ff1627f3f1675be82ee29b44f362e56e93853e/DefaultKeyBinding.dict > ~/Library/KeyBindings/DefaultKeyBinding.dict

# Install Homebrew
ruby <(curl -fsSkL raw.github.com/mxcl/homebrew/go)

brew install git
brew tap homebrew/homebrew-dupes
brew install apple-gcc42
brew install mercurial vcprompt
brew install ctags wget tree ack
brew install ghc plt-racket node leiningen qt rename imagemagick
brew install htop multimarkdown
#brew install mysql
brew install mongodb
brew install pstree node ruby-build chruby phantomjs tmux haskell-platform mercurial pow
brew install z

brew install emacs --cocoa --srgb

brew install vim --with-ruby --with-mzscheme --with-python
brew install macvim

brew install ruby-build chruby
# rbenv install 1.9.3-p194
# rbenv global 1.9.3-p194
# gem install bundler pry heroku foreman

npm -g install js-beautify

# Copy across ssh keys

# Install pow
# curl get.pow.cx | sh
gem install powder

# Install Postgresapp

# Grab my dotfiles
cd && git clone git@github.com:grassdog/dotfiles.git .dotfiles
cd .dotfiles && rake install

# Setup vim
cd && git clone git@github.com:grassdog/vimfiles.git .vim
cd .vim && rake setup

