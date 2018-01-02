# vim:syntax=sh

# case "${TERM}" in
#   *-256color) ;;
#   linux) ;;
#   *) export TERM="${TERM}-256color" ;;
# esac

export EDITOR="/usr/bin/vim"

alias dos2unix="perl -pi -e 's/\r\n/\n/g'"

if [[ $(uname) = "Darwin" ]]; then
  alias ls='ls -G -F'
else
  alias ls='ls --color -F'
  alias pbcopy='xsel --clipboard --input'
  alias pbpaste='xsel --clipboard --output'
  alias pm-suspend='sync; sudo pm-suspend'
  alias pm-hibernate='sync; sudo pm-hibernate'
fi
alias l='ls -lish'
alias ll='ls -lisah'
alias grep='grep --color=auto'
alias o='chromium'
alias po='ps -o pid,comm,wchan:21,cmd'
alias vg='valgrind --num-callers=32 --db-attach=yes'

MANDIRS=( "/usr/share/man" "${HOME}/local/share/man" "$HOME/usr/share/man" )
for mandir in ${MANDIRS[*]}; do
  [[ -d ${mandir} ]] && export MANPATH="${mandir}${MANPATH:+:}${MANPATH}"
done

[[ -d /opt/java/bin ]] && export JAVA_HOME="/opt/java"

[[ -d "$HOME/usr/lib/pkgconfig" ]] && export PKG_CONFIG_PATH="${HOME}/usr/lib/pkgconfig${PKG_CONFIG_PATH:+:}${PKG_CONFIG_PATH}"

[[ -f ~/projects/x0/contrib/x0d.bash-completion.sh ]] && . ~/projects/x0/contrib/x0d.bash-completion.sh
[[ -f ~/.bash_aliases-private ]] && . ~/.bash_aliases-private
[[ -f ~/work/loveos-puppet/scripts/dwn-completion.bash ]] && . ~/work/loveos-puppet/scripts/dwn-completion.bash

[[ -s "$HOME/bin/gitprompt.sh" ]] && . "$HOME/bin/gitprompt.sh"

export HISTSIZE=16384
export HISTFILESIZE=16384
export HISTCONTROL=${HISTCONTROL:-ignorespace:ignoredups}

export XZERO_LOGLEVEL=trace
export CORTEX_LOGLEVEL=trace

export GOPATH=$HOME/gocode

if [[ -d $HOME/usr/opt/go ]]; then
  export GOROOT=$HOME/usr/opt/go
fi

BINDIRS=( ${HOME}/bin
          ${HOME}/usr/bin
          ${HOME}/usr/opt/*/bin
          ${HOME}/.rvm/bin
          ${HOME}/.local/bin
          /opt/*/bin
          /usr/local/opt/llvm/bin
          ${GOPATH}/bin )

for bindir in ${BINDIRS[*]}; do
  if [[ -d "${bindir}" ]]; then
    if echo $PATH | grep -q -v ${bindir}; then
      export PATH="${bindir}${PATH:+:}${PATH}"
    else
      #echo "Path already in \$PATH: ${bindir}"
      true
    fi
  fi
done

# on OS/X we have that installation for latex editing
TEXBINDIR="/Library/TeX/Distributions/TeXLive-2016.texdist/Contents/Programs/x86_64"
if [[ -d ${TEXBINDIR} ]]; then
  export PATH=${PATH}:${TEXBINDIR}
fi

for dir in ${HOME} ${HOME}/opt /opt; do
  if [[ -d ${dir}/google-cloud-sdk ]]; then
    GCSDK="${dir}/google-cloud-sdk"

    # The next line updates PATH for the Google Cloud SDK.
    if [ -f ${GCSDK}/path.bash.inc ]; then
      source "${GCSDK}/path.bash.inc"
    fi

    # The next line enables shell command completion for gcloud.
    if [ -f ${GCSDK}/completion.bash.inc ]; then
      source "${GCSDK}/completion.bash.inc"
    fi

    break
  fi
done

export GPG_TTY=$(tty)

if uname -r | grep -q Microsoft; then
  export DOCKER_HOST="tcp://127.0.0.1:2375"
  export DISPLAY=":0"
fi

# if which kubectl &>/dev/null; then
#   source <(kubectl completion bash)
# fi

man() {
  # mb = blinking
  # md = double-bright
  # me = disable all modes (mb, md, so, us)
  # so = stand-out enter
  # se = stand-out leave
  # us = underline begin
  # ue = underline leave
	LESS_TERMCAP_mb=$'\e[01;34m' \
	LESS_TERMCAP_md=$'\e[01;31m' \
	LESS_TERMCAP_so=$'\e[01;44;33m' \
	LESS_TERMCAP_us=$'\e[38;5;27m' \
	LESS_TERMCAP_se=$'\e[0m' \
	LESS_TERMCAP_ue=$'\e[0m' \
	LESS_TERMCAP_me=$'\e[0m' \
	command man "$@"
}

[[ -s "$HOME/work/ops-tools/ops-completion.bash" ]] && source work/ops-tools/ops-completion.bash

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
if echo $PATH | grep -q -v "${HOME}/.rvm/bin"; then
  #echo "sourcing RVM"
  [[ -s "$HOME/.rvm/scripts/rvm" ]] && \
      source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
else
  true #echo "skip sourcing RVM"
fi

SSH_KEYFILES=$(cd ~/.ssh; for file in $(/bin/ls -1 *.pub); do echo $(basename $file .pub); done)
if which keychain &>/dev/null; then
  eval `keychain --eval ${SSH_KEYFILES}`
fi
