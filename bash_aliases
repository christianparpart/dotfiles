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

[[ -f /opt/clang/bin/clang++ ]] && export PATH="/opt/clang/bin:$PATH"

export PATH="$HOME/bin:$HOME/local/bin:$PATH"

[[ -s "$HOME/bin/gitprompt.sh" ]] && source "$HOME/bin/gitprompt.sh"

alias dos2unix="perl -pi -e 's/\r\n/\n/g'"
alias ls='ls --color -F'
alias l='ls -lish'
alias ll='ls -lisah'
alias grep='grep --color=auto'
alias pm-suspend='sync; sudo pm-suspend'
alias pm-hibernate='sync; sudo pm-hibernate'
alias o='chromium'
alias po='ps -o pid,comm,wchan:21,cmd'

alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'

alias vg='valgrind --num-callers=32 --db-attach=yes'

export EDITOR="/usr/bin/vim"

if test -f $HOME/projects/x0/contrib/x0d.bash-completion.sh; then
	. $HOME/projects/x0/contrib/x0d.bash-completion.sh
fi

function dawanda() {
	if [[ "$1" != "" ]]; then
		case "$1" in
			46.231.*.*)	IP=$1 ;;
			*.*.*.*)	IP=$1 ;;
			*.*)		IP=192.168.$1 ;;
			*)
				if [[ $(echo $1 + 0) -ne 0 ]]; then
					IP=192.168.2.$1
				else
					IP=$1
				fi
				;;
		esac
		shift
		TERM=screen ssh -A -p 22998 -o "StrictHostKeyChecking no" $IP ${@}
	else
		# default to cesar1
		TERM=screen ssh -A -p 22998 46.231.176.107
	fi
}

if [[ "$USER" = "trapni" ]]; then
	PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
	[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
fi

# OpenStack
#export OS_TENANT_NAME="windsor"
#export OS_USERNAME="admin"
#export OS_PASSWORD="admin"
#export OS_AUTH_URL="http://127.0.0.1:5000/v2.0/"
#export OS_REGION_NAME="RegionOnce"
#export OS_AUTH_STRATEGY="keystone"
