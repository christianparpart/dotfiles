.PHONY: update install

update:
	git submodule init
	git submodule update
	git submodule status
	cd .vim/bundle/jedi-vim && git submodule init && git submodule update
	cd .vim/bundle/jedi-vim && git submodule status

backup:
	test -f ~/.bash_aliases || mv -f ~/.bash_aliases ~/.bash_aliases.bak
	test -f ~/.gitconfig || mv -f ~/.gitconfig ~/.gitconfig.bak
	test -f ~/.inputrc || mv -f ~/.inputrc ~/.inputrc.bak
	test -f ~/.screenrc || mv -f ~/.screenrc ~/.screenrc.bak
	test -f ~/.vimrc || mv -f ~/.vimrc ~/.vimrc.bak
	test -f ~/.tmux.conf || mv -f ~/.tmux.conf ~/.tmux.conf.bak
	test -f ~/.irbrc || mv -f ~/.irbrc ~/.irbrc.bak
	test -f ~/.vim || mv -f ~/.vim ~/.vim.bak
	test -f ~/.cgdb || mv -f ~/.cgdb ~/.cgdb.bak

reset: backup
	rm -f ~/.bash_aliases
	rm -f ~/.gitconfig
	rm -f ~/.inputrc
	rm -f ~/.screenrc
	rm -f ~/.vimrc
	rm -f ~/.tmux.conf
	rm -f ~/.irbrc
	rm -f ~/.vim
	rm -f ~/.cgdb

install: backup reset
	ln -sf `pwd`/bash_aliases ~/.bash_aliases || true
	ln -sf `pwd`/gitconfig ~/.gitconfig || true
	ln -sf `pwd`/inputrc ~/.inputrc || true
	ln -sf `pwd`/screenrc ~/.screenrc || true
	ln -sf `pwd`/vimrc ~/.vimrc || true
	ln -sf `pwd`/tmux.conf ~/.tmux.conf || true
	ln -s `pwd`/irbrc ~/.irbrc || true
	ln -s `pwd`/.vim ~/.vim || true
	ln -s `pwd`/.cgdb ~/.cgdb || true
