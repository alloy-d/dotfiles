set fish_greeting

set -l OS (uname)
set -x HOST (hostname -s) # sic, used by other configs

# Abbreviations
# -------------
if status --is-interactive
  # neovim
  abbr -ag nview 'nvim -R'
  abbr -ag ndiff 'nvim -d'

  # tmux
  abbr -ag tat 'tmux attach -t'
  abbr -ag tnt 'tmux new -t'
  abbr -ag tns 'tmux new -s'
  abbr -ag tls 'tmux ls'

  # git
  abbr -ag gap 'git add -p'
  abbr -ag gfpo 'git fetch --prune origin'
  abbr -ag gci 'git ci'
  abbr -ag gp 'git push'
  abbr -ag gpc 'git push origin (git current)'
  abbr -ag gplc 'git pull origin (git current)'
  abbr -ag gpffc 'git pull --ff-only origin (git current)'
  abbr -ag gpsu 'git push --set-upstream'
  abbr -ag gst 'git st'

  # bundler
  abbr -ag bundlex 'bundle exec'
  abbr -ag bx 'bundle exec'

  # vagrant
  abbr -ag vp 'vagrant provision'
  abbr -ag vssh 'vagrant ssh'
end


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
if test -z "$SSH_AUTH_SOCK"
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
