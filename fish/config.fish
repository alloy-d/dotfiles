set fish_greeting

set -l OS (uname)
set -l HOST (hostname)

# Aliases
# -------

alias c='curl -D - -H -'

# Aliases for vim:
alias nview='nvim -R'
alias ndiff='nvim -d'

# Aliases for git:
alias gap='git add -p'
alias gci='git ci'
alias gp='git push'
alias gpc='git push origin (git current)'
alias gpsu='git push --set-upstream'
alias gst='git st'
function gmtm --wraps 'git merge' --description 'merge a branch into the latest master'
  git co master && git pull origin master && git merge --no-ff $argv
end
function gmm --wraps 'git merge' --description 'merge the latest master into the current branch'
  git fetch origin && git merge --no-ff origin/master $argv
end
function gdel --wraps 'git branch' --description 'deletes a git branch real good'
  git branch -d "$argv[1]" && git push origin ":$argv[1]"
end

# Functions for working with Kubernetes:
# TODO: move these into a k8s specific file.
function kubenames --wraps 'kubectl' --description 'get just the names of things from kubectl output'
  cut -f1 -d' ' | grep -v '^NAME$'
end

function kubenamegrep --wraps 'grep' --description 'grep just the names of things from kubectl output'
  grep $argv | kubenames
end
alias knames='kubenames'
alias kng='kubenamegrep'

function podgrep --wraps 'grep' --description 'grep for a pod name'
  kubectl get pods | kubenamegrep $argv
end

# Some convenience aliases for bundler:
alias bundlex='bundle exec'
alias bx='bundle exec'

# Convenience aliases for Vagrant:
alias vp='vagrant provision'
alias vssh='vagrant ssh'

function rgl --wraps rg --description 'rg with pager'
  rg --color=always --heading --line-number $argv | less -R
end

# Environment
# -----------

set -x EDITOR nvim
set -x TERMINAL kitty
set -x MANPAGER most
set -x MANWIDTH 80

set -x GOPATH $HOME/.go

function prepend_to_path
  for entry in $argv
    contains $entry $PATH; or set -x PATH $entry $PATH
  end
end
function append_to_path
  for entry in $argv
    contains $entry $PATH; or set -x PATH $PATH $entry
  end
end

prepend_to_path $HOME/.local/bin $HOME/.rbenv/shims
append_to_path /usr/local/sbin

set -x COWPATH "$HOME/.cows:$COWPATH"

set -x RIPGREP_CONFIG_PATH "$HOME/.ripgreprc"

set -x BAT_THEME "ansi-dark"

set -x NVM_DIR "$HOME/.nvm"

set -x ARDUINO_DIR /Applications/Arduino.app/Contents/Java/
set -x ARDMK_DIR $HOME/Code/Arduino-Makefile


# GPG Agent
# ---------
set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
set -x GPG_TTY (tty)
gpgconf --launch gpg-agent

# opam configuration
source /Users/adam/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true

set -l OS_SPECIFIC_CONFIG "$HOME/.config/fish/os-specific/$OS.fish"
set -l HOST_SPECIFIC_CONFIG "$HOME/.config/fish/host-specific/$HOST.fish"

if test -e "$OS_SPECIFIC_CONFIG"
  source "$OS_SPECIFIC_CONFIG"
end
if test -e "$HOST_SPECIFIC_CONFIG"
  source "$HOST_SPECIFIC_CONFIG"
end
