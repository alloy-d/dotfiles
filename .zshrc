# The following lines were added by compinstall

zstyle ':datetime:*' calendar-file '/home/adam/.calendar'
zstyle ':completion:*' format 'Completing %d:'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' ignore-parents parent pwd .. directory
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
zstyle ':completion:*' max-errors 2 not-numeric
zstyle ':completion:*' menu select=long
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' prompt 'Corrected within %e errors.'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle :compinstall filename '/home/adam/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd extendedglob
bindkey -e
# End of lines configured by zsh-newuser-install

# autoload -U promptinit
# promptinit
# prompt walters

autoload calendar calendar_add
calendar -s

zstyle ':completion::complete:6g::' file-patterns '*.go:go-files:Go\ source\ files'
zstyle ':completion::complete:6l::' file-patterns '*.6:go-amd64-files:Go\ amd64\ object\ files'
zstyle ':completion::complete:mupdf::' file-patterns '*.pdf:pdf-files:PDF\ files'

export EDITOR=vim
export PAGER=less
export BROWSER=chromium

export MANWIDTH=72

export GOROOT=$HOME/sys/go
export GOBIN=$GOROOT/bin
export GOARCH=amd64
export GOOS=linux

export CHICKEN_REPOSITORY="$HOME/sys/lib/chicken/5"
export CHICKEN_INSTALL_PREFIX="$HOME/sys"

PATH="$HOME/.gem/ruby/1.9.1/bin:$PATH:/usr/lib/ruby/gems/1.9.1/bin"
PATH="$HOME/.cabal/bin:$PATH"
PATH="$GOBIN:$PATH"
PATH="$HOME/sys/bin:$PATH:/usr/local/bin"
export PATH

setopt PROMPT_SUBST
setopt PROMPT_PERCENT
setopt SHARE_HISTORY

FGCOL=black
#FGCOL=white

function precmd() {

case $TERM in
    xterm|rxvt*|screen)
        print -Pn "\e]0;%n@%m: %~\a"
PROMPT="
%B%(0?.%F{$FGCOL}(^_^.%F{red}(O_O))%f%b %B%F{green}%n%f%b %Bin%b %B%F{blue}%~%f%b \
`hg prompt \"at %B%F{yellow}{rev}%f%b:{node|short}\
%F{cyan}{ ({bookmark})}%f\
%B%F{red}{ [{status}]}%f%b\" 2>/dev/null`
%B%(!.%F{red}#.%F{$FGCOL}>)%f%b "
;;
    linux|*)
        PROMPT="
%B%(0?.>.%F{red}>%f)%b " ;;
esac
}

function preexec() {
    case $TERM in
        xterm|rxvt*)
            print -Pn "\e]0;%n@%m: $2\a" ;;
    esac
}
RPROMPT="%T"

bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search

export PERL5LIB="$HOME/lib/perl"
export PYTHONPATH="$HOME/lib/python"
export PKG_CONFIG_PATH="/usr/local/lib/pkgconfig"
export RB_USER_INSTALL=true

alias py="python2"
alias py3="python3"
alias rb="ruby"

alias ls="ls --classify --color=auto"
alias ll="ls -l"
alias la="ls -A"
alias lla="ls -lA"

alias sshg="ssh -R 8001:127.0.0.1:8001"

alias notestamp="date +%y%m%d%H%M"

alias dexter="~/projects/dexter/bin/query.rb"

alias supterm="urxvtc -bg '[85]black' -fg white -color0 black -color7 white -color8 black -color15 white -e sup"
function blackterm {
    urxvtc -bg '[85]black' -fg white -color0 black -color7 white -color8 black -color15 white $@
}

function note {
    mail me@alloy-d.net -s "$@" < /dev/null >/dev/null 2>&1
}

alias open="kde-open"
#alias open="xdg-open"
#function open {
#    xdg-open $@ >/dev/null 2>&1 &!
#}

function edit {
    emacs $@ >/dev/null 2>&1 &!
    #gvim $@ >/dev/null 2>&1 &!
}

function jp {
    xlock -nolock -mode juggle -only balls -pattern "$*"
}

#source /home/adam/sys/ros/setup.sh

/usr/bin/keychain -Q -q ~/.ssh/id_dsa 99E101ED
[[ -f $HOME/.keychain/$(hostname)-sh ]] && source $HOME/.keychain/$(hostname)-sh

# Prevent new shells from reporting a nonzero last exit code.
{
    return 0
}
