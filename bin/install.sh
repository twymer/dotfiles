#!/bin/bash
ln -s ~/dotfiles/.vim ~/.vim
ln -s ~/dotfiles/.vimrc ~/.vimrc
ln -s ~/dotfiles/.gvimrc ~/.gvimrc
ln -s ~/dotfiles/.ackrc ~/.ackrc
ln -s ~/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/dotfiles/.gitignore ~/.gitignore
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/.tmuxinator ~/.tmuxinator
ln -s ~/dotfiles/.zshenv ~/.zshenv
ln -s ~/dotfiles/.zshrc ~/.zshrc
ln -s ~/dotfiles/.zsh ~/.zsh
ln -s ~/dotfiles/.pairs ~/.pairs
ln -s ~/dotfiles/.ctags ~/.ctags
ln -s ~/dotfiles/.gitignore_global ~/.gitignore_global
ln -s ~/dotfiles/.agignore ~/.agignore
ln -s ~/.vimrc ~/.nvimrc
ln -s ~/.vim ~/.nvim
chsh -s /bin/zsh
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
