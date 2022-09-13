# if [[ $- == *i* ]]; then
#     exec powershell -nologo
# fi
#/bin/sleep 4

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000

# ignore hist dups
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_BEEP

# Don't share history among open ZSH's
unsetopt share_history

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

#export MANPAGER="nvim +Man!"

# for gnuplot-nox
export GNUTERM="sixelgd size 1600,300 truecolor font arial 16"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="agnoster"
ZSH_THEME="powerlevel10k/powerlevel10k"
#ZSH_THEME="gnzh"
#ZSH_THEME="powerlevel9k/powerlevel9k"
#POWERLEVEL9K_MODE="nerdfont-fontconfig"

PROMPT+=$"%{\033[>M%}$"

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(user dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git
	colored-man-pages
	colorize
	command-not-found
	zsh-autosuggestions
	zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
#if [[ -n $SSH_CONNECTION ]]; then
#  export EDITOR='vim'
#else
#  export EDITOR='mvim'
#fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# -------------------------------------------------------------------------------------
export GPG_TTY=$(tty)
export EDITOR='vim'

alias ls='ls --color=auto -F --hyperlink=auto'
alias ll='ls -lisah'
alias l='ls -lish'
alias po='ps -o pid,tty,comm,wchan:21,cmd'
alias ccat='pygmentize -g'
alias bat='bat --italic-text=always'

alias isvg='rsvg-convert | img2sixel'

if [[ $(uname) = "Darwin" ]]; then
  alias ls='ls -G -F'
else
  alias pbcopy='xsel --clipboard --input'
  alias pbpaste='xsel --clipboard --output'
fi

# for some reason there is a really ugly grep alias that's not mine (system default?)
unalias grep

# {{{ C++ development
alias pt='valgrind --tool=callgrind --dump-instr=yes --collect-jumps=yes --branch-sim=yes --cache-sim=yes'
alias vg='valgrind --num-callers=32 --vgdb=full'
if [[ -d "$HOME/usr/lib/pkgconfig" ]]; then
  export PKG_CONFIG_PATH="${HOME}/usr/lib/pkgconfig${PKG_CONFIG_PATH:+:}${PKG_CONFIG_PATH}"
fi
alias n='ninja'
alias nn='nice ninja -j20'
alias j='make -j25'
alias jj='nice make -j25'
# }}}
# {{{ key chain (SSH, GnuPG)
#if [[ -z "${SUDO_USER}" && -z "${SSH_AUTH_SOCK}" ]]; then
if [[ -z "${SUDO_USER}" ]]; then
  if which keychain &>/dev/null; then
    SSH_KEYFILES=$(cd ~/.ssh; for file in $(/bin/ls -1 *.pub 2>/dev/null); do echo $(basename $file .pub); done)
    eval `keychain --systemd --quiet --eval ${SSH_KEYFILES}`
  fi
fi
# }}}

function extend_search_path() {
    local VarName=${1}
    shift
    local SearchPaths=( ${*} )
    for dir in ${SearchPaths[*]}; do
        local CurrentPaths=$(echo $(eval echo "\$(eval echo \$${VarName})"))
        if [[ -d "${dir}" ]]; then
            if echo "${CurrentPaths}" | grep -q -v ${dir}; then
                export `eval "echo '\$VarName'"`="${dir}${CurrentPaths:+:}$(echo $(eval echo "\$(eval echo \$${VarName})"))"
            else
                # Path already in \$PATH: ${dir}
                true
            fi
        fi
    done
}

LIBDIRS=( ${HOME}/lib/cmake
          ${HOME}/go/lib/cmake
          ${HOME}/usr/lib/cmake
		  $(test -d "${HOME}/usr/opt" && find "${HOME}/usr/opt" -name cmake -print | grep lib/cmake)
		  $(find /opt -name cmake -print 2>/dev/null)
		)
extend_search_path CMAKE_LIBRARY_PATH "${LIBDIRS[@]}"
#export CMAKE_LIBRARY_PATH=/home/trapni/usr/opt/boost/lib

# {{{ bin PATH directories
BINDIRS=( ${HOME}/go/bin
          ${HOME}/usr/bin
          ${HOME}/usr/sbin
		  /snap/bin
          ${HOME}/.rvm/bin
          ${HOME}/.local/bin
		  $(test -d "${HOME}/usr/opt" && find "${HOME}/usr/opt" -name bin -print)
		  $(find /opt -name bin -print 2>/dev/null)
		  #$(find /usr/lib -maxdepth 1 -name bin -print)
          /usr/local/opt/llvm/bin
		  /usr/lib/dart/bin
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

# force ~/bin to be first
test -d "${HOME}/bin" && export PATH="${HOME}/bin:${PATH}"

# }}}
# {{{ key chain (SSH, GnuPG)
#if [[ -z "${SUDO_USER}" && -z "${SSH_AUTH_SOCK}" ]]; then
if [[ -z "${SUDO_USER}" ]]; then
  if which keychain &>/dev/null; then
    SSH_KEYFILES=$(cd ~/.ssh; for file in $(/bin/ls -1 *.pub 2>/dev/null); do echo $(basename $file .pub); done)
    eval `keychain --systemd --quiet --eval ${SSH_KEYFILES}`
  fi
fi
# }}}

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# https://github.com/zsh-users/zsh-autosuggestions
#export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ff6000,bg=#202020,bold,underline"
#export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="bg=#6060ff,fg=#FFFFFF,bold,underline"
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#6060ff,bold,underline"
# #ff6000
# #6060ff

# C-U to mimmick the behaviour of C-U in Bash
bindkey \^U backward-kill-line

# VIM mode
#bindkey -v

# for contour, as there seems to be issues when running on Wayland native (such as inside Sway)
export QT_QPA_PLATFORM="xcb"

# use `bindkey -e` to switch back to Emacs-mode
test -f $HOME/.cargo/env && source $HOME/.cargo/env

# Enforce applying the KDE configured theme of KDE applications.
export XDG_CURRENT_DESKTOP=KDE

# path to evmone library for soltest/isoltest
export ETH_EVMONE="${HOME}/usr/opt/evmone/lib/libevmone.so"

if [[ "${TERMINAL_NAME}" = "contour" ]]; then
	CONTOUR_BIN="/Users/trapni/projects/contour/target/Debug/src/contour/contour.app/Contents/MacOS/contour"
	if [[ -e "${CONTOUR_BIN}" ]]; then
		source <(${CONTOUR_BIN} generate integration shell zsh to -)
	fi
fi

# ZSH Highlighting overrides
# See: https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[comment]='fg=#909090'

function try_source() {
	[[ ! -f "${1}" ]] || source "${1}"
}

try_source ~/.fzf.zsh
try_source ~/.p10k.zsh
try_source ~/.fzf-contour.zsh
try_source ~/usr/src/emsdk/emsdk_env.sh &>/dev/null

#try_source ~/projects/contour/contour-integration.zsh

#alias meow="echo '\n /| ､\n(°､ ｡ 7\n |､  ~ヽ\n じしf_,)〳\n'" # NOTE: From catpuccin discord server :D

if which exa &>/dev/null; then
	alias  l='exa -hl --icons --git --git-ignore'
	alias ll='exa -hl --icons --git -a'
fi

if which contour &>/dev/null; then
	CONTOUR_BIN=$(which contour)
	T=$PATH
	unset PATH
	eval "$(${CONTOUR_BIN} generate integration shell zsh to -)"
	export PATH=$T
	unset T
#else
#	echo "Path to contour not found."
fi

ulimit -c unlimited
