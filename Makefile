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

install-symlinks-files:
	ln -sf `pwd`/bash_aliases ~/.bash_aliases
	ln -sf `pwd`/gitconfig ~/.gitconfig
	ln -sf `pwd`/inputrc ~/.inputrc
	ln -sf `pwd`/screenrc ~/.screenrc
	ln -sf `pwd`/vimrc ~/.vimrc
	ln -sf `pwd`/tmux.conf ~/.tmux.conf

install-symlinks-dirs:
	ln -s `pwd`/irbrc ~/.irbrc
	ln -s `pwd`/.vim ~/.vim || true
	ln -s `pwd`/.cgdb ~/.cgdb || true

install-os-tweaks: /etc/sudoers.d/00-trapni

/etc/sudoers.d/00-trapni: sudoers.d.trapni
	sudo install -m 0640 sudoers.d.trapni /etc/sudoers.d/00-trapni

install: install-symlinks-files install-symlinks-dirs install-os-tweaks
