#!/bin/sh
#TODO Add git and homebrew install stuff and pull of dotfiles from github
ln -sf ~/bin/dotfiles/vim/rcfiles/vimrc .vimrc
ln -sf ~/bin/dotfiles/vim .vim                
ln -sf ~/bin/dotfiles/zsh/zshenv .zshenv
ln -sf ~/bin/dotfiles/git/gitconfig .gitconfig
ln -sf ~/bin/dotfiles/git/gitignore_global .gitignore_global
ln -sf ~/bin/dotfiles/gem/gemrc .gemrc

