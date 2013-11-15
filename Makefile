.PHONY: update install

update:
	git submodule init
	git submodule update

install:
	ln -s `pwd`/bash_aliases ~/.bash_aliases
	ln -s `pwd`/gitconfig-global ~/.gitconfig-global
	ln -s `pwd`/inputrc ~/.inputrc
	ln -s `pwd`/screenrc ~/.screenrc
	ln -s `pwd`/tmux.conf ~/.tmux.conf
	ln -s `pwd`/vimrc ~/.vimrc
	ln -s `pwd`/.vim ~/.vim
	ln -s `pwd`/.cgdb ~/.cgdb
