# vim:syntax=sh

case $TERM in
	*-256color)
		;;
	linux)
		;;
	*)
		export TERM=$TERM-256color
		;;
esac

export EDITOR="/usr/bin/vim"

alias dos2unix="perl -pi -e 's/\r\n/\n/g'"
alias ls='ls --color -F'
alias l='ls -lish'
alias ll='ls -lisah'
alias grep='grep --color=auto'
alias pm-suspend='sync; sudo pm-suspend'
alias pm-hibernate='sync; sudo pm-hibernate'
alias o='chromium'
alias po='ps -o pid,comm,wchan:21,cmd'
alias vg='valgrind --num-callers=32 --db-attach=yes'
alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'

[[ -d ~/bin ]] && export PATH="$HOME/bin:$PATH"
[[ -d ~/local/bin ]] && export PATH="$HOME/local/bin:$PATH"
[[ -d ~/local/sbin ]] && export PATH="$HOME/local/sbin:$PATH"
[[ -d /opt/clang/bin ]] && export PATH="/opt/clang/bin:$PATH"
[[ -d ~/local/share/man ]] && export MANPATH="$HOME/local/share/man:$MANPATH"
[[ -d /opt/scala/bin ]] && export PATH="/opt/scala/bin:$PATH"

[[ -d /opt/java/bin ]] && export JAVA_HOME="/opt/java"

[[ -f ~/projects/x0/contrib/x0d.bash-completion.sh ]] && . ~/projects/x0/contrib/x0d.bash-completion.sh
[[ -f ~/.bash_aliases-private ]] && . ~/.bash_aliases-private

[[ -s "$HOME/bin/gitprompt.sh" ]] && . "$HOME/bin/gitprompt.sh"

export JAVA_HOME=/opt/java
