# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Use bash completion
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# User specific aliases and functions
alias ls="ls --classify --color=auto"
alias view="vim -R"

function prompt {
  local WHITE="\[\033[1;37m\]"
  local GREEN="\[\033[1;32m\]"
  local CYAN="\[\033[1;36m\]"
  local GRAY="\[\033[1;30m\]"
  local BLUE="\[\033[1;34m\]"
  local RED="\[\033[1;31m\]"
  local NORMAL="\[\033[0m\]"
#  export PS1="${BLUE}[${GREEN}\u${BLUE}@${GREEN}\h ${RED}\W${BLUE}]\$${NORMAL} "
  export PS1="${BLUE}{ ${GREEN}\u ${RED}\W${BLUE} \$ }${NORMAL}  "
}
prompt


# User-specific variable definitions
export PATH="$HOME/bin:$HOME/.gem/ruby/1.8/bin:$PATH"
export PERL5LIB="$HOME/lib/perl"
export PYTHONPATH="$HOME/lib/python"


export PKG_CONFIG_PATH="/usr/local/lib/pkgconfig"

#export PYTHONDOCS="/opt/doc/python/lib/"
#export PYTHONDOCS="/usr/share/doc/python-docs/2.5.2/html/lib/"

export PAGER="/bin/less"
export EDITOR="/usr/bin/vim"
export TEXEDIT="/usr/bin/vim"
export GIT_EDITOR="/usr/bin/vim"

alias pacman='pacman-color'
alias timestamp='date +%Y%m%dT%H%M%S'
alias notestamp='date +%y%m%d%H%M'
alias todo='todo.sh -d ~/.todo.cfg'

export dsa="$HOME/classes/csci/2300"
export comporg="$HOME/classes/csci/2500"
export calc="$HOME/classes/math/2010"
export psych="$HOME/classes/psyc/1200"

export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

if [ -f "${HOME}/.gpg-agent-info" ]; then
    . "${HOME}/.gpg-agent-info"
    export GPG_AGENT_INFO
    export SSH_AUTH_SOCK
    export SSH_AGENT_PID
fi

