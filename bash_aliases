# vim:syntax=sh

# {{{ BASH dailies
set +o ignoreeof
export EDITOR="/usr/bin/vim"

export HISTSIZE=16384
export HISTFILESIZE=16384
export HISTCONTROL=${HISTCONTROL:-ignorespace:ignoredups}

export GPG_TTY=$(tty)

if [[ $(uname) = "Darwin" ]]; then
  alias ls='ls -G -F'
else
  alias ls='ls --color -F'
  alias pbcopy='xsel --clipboard --input'
  alias pbpaste='xsel --clipboard --output'
fi

alias l='ls -lish'
alias ll='ls -lisah'
alias grep='grep --color=auto'
alias o='chromium'
alias po='ps -o pid,comm,wchan:21,cmd'

alias dos2unix="perl -pi -e 's/\r\n/\n/g'"

alias ni='ninja'
alias n='ninja'

cf() {
  src="${1}"
  dst="${2}"

  if ! which pv &>/dev/null; then
    echo "No pv tool installed" 1>&2
    return 1
  fi

  # TODO: verify $src is a file and readable
  # TODO: verify $dst is a file, or a directory (if latter, mimmic cp)

  pv -s $(stat -c %s "${src}") <"${src}" >"${dst}"
}

# }}}
# {{{ man-pages
MANDIRS=(
    /usr/share/man
    ~/local/share/man
    ~/usr/share/man
    ~/usr/opt/*/man
    ~/usr/opt/*/share/man)
for mandir in ${MANDIRS[*]}; do
  [[ -d ${mandir} ]] && export MANPATH="${mandir}${MANPATH:+:}${MANPATH}"
done

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
# }}}
# {{{ Java
[[ -d /opt/java/bin ]] && export JAVA_HOME="/opt/java"
# }}}
# {{{ C++ development
alias vg='valgrind --num-callers=32 --vgdb=full'
if [[ -d "$HOME/usr/lib/pkgconfig" ]]; then
  export PKG_CONFIG_PATH="${HOME}/usr/lib/pkgconfig${PKG_CONFIG_PATH:+:}${PKG_CONFIG_PATH}"
fi
# }}}
# {{{ terminal settings (256-color)
# case "${TERM}" in
#   *-256color) ;;
#   linux) ;;
#   *) export TERM="${TERM}-256color" ;;
# esac
# }}}
# {{{ Go/Golang development environment
export GOPATH=$HOME/gocode

if [[ -d $HOME/usr/opt/go ]]; then
  export GOROOT=$HOME/usr/opt/go
fi
# }}}
# {{{ bin PATH directories
BINDIRS=( ${HOME}/bin
          ${HOME}/usr/bin
          ${HOME}/usr/sbin
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
# }}}
# {{{ LaTeX environment
# on OS/X we have that installation for latex editing
TEXBINDIR="/Library/TeX/Distributions/TeXLive-2016.texdist/Contents/Programs/x86_64"
if [[ -d ${TEXBINDIR} ]]; then
  export PATH=${PATH}:${TEXBINDIR}
fi
# }}}
# {{{ Google Cloud SDK
for dir in ${HOME} ${HOME}/usr/opt ${HOME}/opt /opt; do
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
# }}}
# {{{ WSL / Windows Subsystem for Linux
if uname -r | grep -q Microsoft; then
  export DOCKER_HOST="tcp://127.0.0.1:2375"
  export DISPLAY=":0"
fi
# }}}
# {{{ GIT-compatible shell prompt
        RED="\[\033[0;31m\]"
     YELLOW="\[\033[0;33m\]"
    GREEN="\[\033[0;32m\]"
       BLUE="\[\033[0;34m\]"

  LIGHT_RED="\[\033[1;31m\]"
LIGHT_GREEN="\[\033[1;32m\]"
 LIGHT_BLUE="\[\033[1;34m\]"
      WHITE="\[\033[1;37m\]"
 LIGHT_GRAY="\[\033[0;37m\]"

 COLOR_NONE="\[\e[0m\]"

function parse_git_branch {
  git rev-parse --git-dir &> /dev/null
  git_status="$(git status 2> /dev/null)"
  branch_pattern="^On branch ([^${IFS}]*)"
  remote_pattern="Your branch is (.*?) "
  diverge_pattern="Your branch and (.*) have diverged"

  #printf "git status: \"%s\"\n" "${git_status}"

  if [[ ! ${git_status}} =~ "working directory clean" ]]; then
    state="${RED}"
  fi
  # add an else if or two here if you want to get more specific
  if [[ ${git_status} =~ ${remote_pattern} ]]; then
    if [[ ${BASH_REMATCH[1]} == "ahead" ]]; then
      remote="${YELLOW}+"
    else
      remote="${YELLOW}"
    fi
  fi
  if [[ ${git_status} =~ ${diverge_pattern} ]]; then
    remote="${YELLOW}~"
  fi
  if [[ ${git_status} =~ ${branch_pattern} ]]; then
    branch=${BASH_REMATCH[1]}
    echo " (${branch})${remote}${state}"
  fi
}

function prompt_func() {
  previous_return_value=$?;
  prompt="${TITLEBAR}${BLUE}[${LIGHT_BLUE}\W${GREEN}$(parse_git_branch)${BLUE}]${COLOR_NONE} "
  if [[ $UID -eq 0 ]]; then
    if [[ $previous_return_value -eq 0 ]]; then
      PS1="${LIGHT_RED}$(hostname)${COLOR_NONE} ${prompt}${LIGHT_GREEN}>${COLOR_NONE} "
    else
      PS1="${LIGHT_RED}$(hostname)${COLOR_NONE} ${prompt}${RED}>${COLOR_NONE} "
    fi
  else
    if [[ $previous_return_value -eq 0 ]]; then
      PS1="${LIGHT_GREEN}${USER}${COLOR_NONE}@${WHITE}$(hostname)${COLOR_NONE} ${prompt}${LIGHT_GREEN}>${COLOR_NONE} "
    else
      PS1="${LIGHT_GREEN}${USER}${COLOR_NONE}@${WHITE}$(hostname)${COLOR_NONE} ${prompt}${RED}>${COLOR_NONE} "
    fi
  fi
}

PROMPT_COMMAND=prompt_func
# }}}
# {{{ Kubernetes
# if which kubectl &>/dev/null; then
#   source <(kubectl completion bash)
# fi
# }}}
# {{{ RVM
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
if echo $PATH | grep -q -v "${HOME}/.rvm/bin"; then
  #echo "sourcing RVM"
  [[ -s "$HOME/.rvm/scripts/rvm" ]] && \
      source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
else
  true #echo "skip sourcing RVM"
fi
# }}}
# {{{ key chain (SSH, GnuPG)
if [[ -z "${SUDO_USER}" && -z "${SSH_AUTH_SOCK}" ]]; then
  if which keychain &>/dev/null; then
    SSH_KEYFILES=$(cd ~/.ssh; for file in $(/bin/ls -1 *.pub 2>/dev/null); do echo $(basename $file .pub); done)
    eval `keychain --quiet --eval ${SSH_KEYFILES}`
  fi
fi
# }}}
# {{{ custom sourced files
SOURCES=(
    ~/projects/x0/contrib/x0d.bash-completion.sh
    ~/work/ops/ops-tools/ops-completion.bash
    ~/work/ops-tools/ops-completion.bash
    ~/.bash_aliases-private
)
for SOURCE in ${SOURCES[*]}; do
  [[ -f "${SOURCE}" ]] && source ${SOURCE}
done
# }}}
