#!/bin/sh

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

# Get babushka
#bash -c "`curl babushka.me/up`"

# Remove glass dock
defaults write com.apple.dock no-glass -boolean YES && killall Dock

ruby -e "$(curl -fsSLk https://gist.github.com/raw/323731/install_homebrew.rb)"

brew install git
easy_install mercurial # or brew install pip && pip install mercurial
brew install ctags wget tree vcprompt ack
brew install mysql

# Apps to install
# ruby mine, sequel pro, mac vim, git x, skype, pester, adium, 
# chrome, firefox, httpclient, dropbox, notational velocity alt, google quick search box, 
# textmate, MSOffice, acorn, photoshop, VLC, Yojimbo, virtual box, peepopen, Sparrow

# Setup textmate
mkdir -p /Library/Application\ Support/TextMate/Bundles
cd /Library/Application\ Support/TextMate/Bundles
#curl https://github.com/downloads/protocool/AckMate/AckMate.1.1.2.zip
#curl https://github.com/subtleGradient/javascript-tools.tmbundle/zipball/master
git clone git://github.com/kswedberg/jquery-tmbundle.git "JavaScript jQuery.tmbundle"
git clone git://github.com/rspec/rspec-tmbundle.git RSpec.tmbundle
git clone git://github.com/aslakhellesoy/cucumber-tmbundle.git Cucumber.tmbundle
git clone git://github.com/mocoso/code-beautifier.tmbundle.git Code\ Beautifier.tmbundle
git clone git://github.com/grimen/compass_blueprint_tmbundle.git 'Compass + Blueprint.tmbundle'
osascript -e 'tell app "TextMate" to reload bundles'

bash < <( curl http://rvm.beginrescueend.com/releases/rvm-install-head )
rvm install ruby-1.9.2
rvm install ruby-1.8.7
rvm use ruby-1.9.2 --default
rvm use ruby-1.9.2@global
gem install ghost
gem install cheat
gem install bundler
gem install vagrant
gem install request-log-analyzer
gem install awesome_print

# Setup dotfiles
cd &&
[ -d 'bin' ] || git clone git@github.com:grassdog/binfiles.git bin &&
mkdir -p ~/bin/dotfiles/vim/tmp/backup &&
mkdir -p ~/bin/dotfiles/vim/tmp/swap &&
ln -sf ~/bin/dotfiles/vim/rcfiles/vimrc ~/.vimrc &&
ln -sf ~/bin/dotfiles/vim ~/.vim &&
ln -sf ~/bin/dotfiles/zsh/zshenv ~/.zshenv &&
ln -sf ~/bin/dotfiles/git/gitconfig ~/.gitconfig &&
ln -sf ~/bin/dotfiles/git/gitignore_global ~/.gitignore_global &&
ln -sf ~/bin/dotfiles/gem/gemrc ~/.gemrc &&
ln -sf ~/bin/dotfiles/ack/ackrc ~/.ackrc &&
ln -sf ~/bin/dotfiles/zsh/dotzsh ~/.zsh

