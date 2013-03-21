#!/bin/bash
ln -s ~/dotfiles/.vim ~/.vim
ln -s ~/dotfiles/.vimrc ~/.vimrc
ln -s ~/dotfiles/.ackrc ~/.ackrc
ln -s ~/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/dotfiles/.gitignore ~/.gitignore
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/.zshenv ~/.zshenv
ln -s ~/dotfiles/.zshrc ~/.zshrc
ln -s ~/dotfiles/.zsh ~/.zsh
chsh -s /bin/zsh
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
