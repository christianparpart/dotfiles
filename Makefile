.PHONY: update install

update:
	git submodule init
	git submodule update

backup:
	test -f ~/.bash_aliases.bak || mv ~/.bash_aliases ~/.bash_aliases.bak
	test -f ~/.gitconfig.bak || mv ~/.gitconfig ~/.gitconfig.bak
	test -f ~/.inputrc.bak || mv ~/.inputrc ~/.inputrc.bak
	test -f ~/.screenrc.bak || mv ~/.screenrc ~/.screenrc.bak
	test -f ~/.vimrc.bak || mv ~/.vimrc ~/.vimrc.bak
	test -f ~/.tmux.conf.bak || mv ~/.tmux.conf ~/.tmux.conf.bak
	test -f ~/.vim.bak || mv ~/.vim ~/.vim.bak
	test -f ~/.cgdb.bak || mv ~/.cgdb ~/.cgdb.bak

reset: backup
	rm -f ~/.bash_aliases
	rm -f ~/.gitconfig
	rm -f ~/.inputrc
	rm -f ~/.screenrc
	rm -f ~/.vimrc
	rm -f ~/.tmux.conf
	rm -f ~/.vim
	rm -f ~/.cgdb

install: backup reset
	ln -sf `pwd`/bash_aliases ~/.bash_aliases
	ln -sf `pwd`/gitconfig ~/.gitconfig
	ln -sf `pwd`/inputrc ~/.inputrc
	ln -sf `pwd`/screenrc ~/.screenrc
	ln -sf `pwd`/vimrc ~/.vimrc
	ln -sf `pwd`/tmux.conf ~/.tmux.conf
	ln -s `pwd`/.vim ~/.vim
	ln -s `pwd`/.cgdb ~/.cgdb
