.PHONY: update install

update:
	git submodule init
	git submodule update

install:
	ln -sf `pwd`/bash_aliases ~/.bash_aliases
	ln -sf `pwd`/gitconfig ~/.gitconfig
	ln -sf `pwd`/inputrc ~/.inputrc
	ln -sf `pwd`/screenrc ~/.screenrc
	ln -sf `pwd`/tmux.conf ~/.tmux.conf
	ln -sf `pwd`/vimrc ~/.vimrc
	ln -s `pwd`/.vim ~/.vim
	ln -s `pwd`/.cgdb ~/.cgdb
