set fish_greeting

set -l OS (uname)
set -x HOST (hostname -s) # sic, used by other configs

# Aliases
# -------

alias c='curl -D - -H -'

# Aliases for vim:
alias nview='nvim -R'
alias ndiff='nvim -d'

# Aliases for tmux:
alias tat='tmux attach -t'
alias tnt='tmux new -t'
alias tns='tmux new -s'
alias tls='tmux ls'

# Aliases for git:
alias gap='git add -p'
alias gfpo='git fetch --prune origin'
alias gci='git ci'
alias gp='git push'
alias gpc='git push origin (git current)'
alias gpsu='git push --set-upstream'
alias gst='git st'
function gmtm --wraps 'git merge' --description 'merge a branch into the latest master'
  git co master && git pull origin master && git merge --no-ff $argv
end
function gmm --wraps 'git merge' --description 'merge the latest master into the current branch'
  git fetch origin && git merge --ff-only origin/master $argv
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

set -x DIFFPROG 'nvim -d'
set -x EDITOR nvim
set -x TERMINAL alacritty
set -x MANPAGER most
set -x MANWIDTH 80

set -x GOPATH $HOME/.go

prepend_to_path $HOME/.local/bin $HOME/.rbenv/shims
append_to_path /usr/local/sbin

if test -d /opt/homebrew/
  prepend_to_path /opt/homebrew/bin
  append_to_path /opt/homebrew/sbin
end

set -x COWPATH "$HOME/.cows:$COWPATH"

set -x BAT_THEME "base16"

set -x NVM_DIR "$HOME/.nvm"

set -x ARDUINO_DIR /Applications/Arduino.app/Contents/Java/
set -x ARDMK_DIR $HOME/Code/Arduino-Makefile


# GPG Agent
# ---------
if test -e "$SSH_AUTH_SOCK"
  # Could already be set by pam_env.
  set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
end
set -x GPG_TTY (tty)
gpgconf --launch gpg-agent
gpg-connect-agent updatestartuptty /bye > /dev/null


# asdf version manager
# On macOS, this would be (brew --prefix asdf)/asdf.fish,
# but it's much, much faster to *not* run that.
set -l ASDF_MACOS "/usr/local/opt/asdf"
set -l ASDF_ARCHLINUX "/opt/asdf-vm"
if test -e "$ASDF_MACOS/asdf.fish"
  source "$ASDF_MACOS/asdf.fish"
else if test -e "$ASDF_ARCHLINUX/asdf.fish"
  source "$ASDF_ARCHLINUX/asdf.fish"
end

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
