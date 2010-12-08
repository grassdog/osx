#!/bin/sh
#TODO Add git and homebrew install stuff and pull of dotfiles from github

# TODO set up keyboard defaults

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

ruby -e "$(curl -fsSLk https://gist.github.com/raw/323731/install_homebrew.rb)"

brew install git
easy_install mercurial #or brew install pip && pip install mercurial
brew install ctags wget tree vcprompt ack
brew install mysql

#install ruby mine, sequel pro, mac vim, git x, skype, pester, adium, 
#  chrome, firefox, httpclient, dropbox, notational velocity, google quick search box, 
#  textmate, MSOffice, acorn, photoshop, VLC, Yojimbo, virtual box

bash < <( curl http://rvm.beginrescueend.com/releases/rvm-install-head )
rvm install ruby-1.9.2
rvm use ruby-1.9.2 --default
rvm use ruby-1.9.2@global
gem install ghost
gem install bundler

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

