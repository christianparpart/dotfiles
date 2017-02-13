# vim:syntax=sh

case "${TERM}" in
  *-256color) ;;
  linux) ;;
  *) export TERM="${TERM}-256color" ;;
esac

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

#[[ -d ~/bin ]] && export PATH="$HOME/bin:$PATH"
[[ -d ~/local/share/man ]] && export MANPATH="$HOME/local/share/man:$MANPATH"
# [[ -d /opt/scala/bin ]] && export PATH="/opt/scala/bin:$PATH"
# [[ -d /opt/sbt/bin ]] && export PATH="/opt/sbt/bin:$PATH"

[[ -d /opt/java/bin ]] && export JAVA_HOME="/opt/java"

[[ -f ~/projects/x0/contrib/x0d.bash-completion.sh ]] && . ~/projects/x0/contrib/x0d.bash-completion.sh
[[ -f ~/.bash_aliases-private ]] && . ~/.bash_aliases-private
[[ -f ~/work/loveos-puppet/scripts/dwn-completion.bash ]] && . ~/work/loveos-puppet/scripts/dwn-completion.bash

[[ -s "$HOME/bin/gitprompt.sh" ]] && . "$HOME/bin/gitprompt.sh"
[[ -f "$HOME/work/loveos-puppet/scripts/dwn-completion.bash" ]] && \
    . "$HOME/work/loveos-puppet/scripts/dwn-completion.bash"

export HISTSIZE=16384
export HISTFILESIZE=16384
export HISTCONTROL=${HISTCONTROL:-ignorespace:ignoredups}

export PATH=$HOME/.rvm/bin:$PATH # Add RVM to PATH for scripting
export GEM_HOME=$HOME/.gem/ruby/2.3.0/

export XZERO_LOGLEVEL=trace
export CORTEX_LOGLEVEL=trace

export GOPATH=$HOME/gocode
export PATH=$GOPATH/bin:$PATH

for dir in /opt/*/bin; do
  export PATH=${dir}:$PATH
done

# on OS/X we have that installation for latex editing
TEXBINDIR="/Library/TeX/Distributions/TeXLive-2016.texdist/Contents/Programs/x86_64"
if [[ -d ${TEXBINDIR} ]]; then
  export PATH=${PATH}:${TEXBINDIR}
fi

for dir in ${HOME} /opt; do
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
