#!/bin/sh
#TODO Add git and homebrew install stuff and pull of dotfiles from github

ruby -e "$(curl -fsS http://gist.github.com/raw/323731/install_homebrew.rb)"
brew install git
brew install mysql
brew install ctags

bash < <( curl http://rvm.beginrescueend.com/releases/rvm-install-head )
#TODO Install desired Rubys

sudo easy_install http://closure-linter.googlecode.com/files/closure_linter-latest.tar.gz
mkdir -p ~/bin/dotfiles/vim/tmp/backup
mkdir -p ~/bin/dotfiles/vim/tmp/swap
ln -sf ~/bin/dotfiles/vim/rcfiles/vimrc ~/.vimrc
ln -sf ~/bin/dotfiles/vim ~/.vim                
ln -sf ~/bin/dotfiles/zsh/zshenv ~/.zshenv
ln -sf ~/bin/dotfiles/git/gitconfig ~/.gitconfig
ln -sf ~/bin/dotfiles/git/gitignore_global ~/.gitignore_global
ln -sf ~/bin/dotfiles/gem/gemrc ~/.gemrc
ln -sf ~/bin/dotfiles/zsh/dotzsh ~/.zsh

