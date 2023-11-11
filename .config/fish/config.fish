set fish_greeting

set -l OS (uname)
set -x HOST (hostname -s) # sic, used by other configs

# Abbreviations
# -------------
if status --is-interactive
  # neovim
  abbr -a nview 'nvim -R'
  abbr -a ndiff 'nvim -d'

  # tmux
  abbr -a tat 'tmux attach -t'
  abbr -a tnt 'tmux new -t'
  abbr -a tns 'tmux new -s'
  abbr -a tls 'tmux ls'

  # git
  abbr -a gap 'git add -p'
  abbr -a gfpo 'git fetch --prune origin'
  abbr -a gci 'git ci'
  abbr -a gp 'git push'
  abbr -a gpc 'git push origin (git current)'
  abbr -a gplc 'git pull origin (git current)'
  abbr -a gpffc 'git pull --ff-only origin (git current)'
  abbr -a gpsu 'git push --set-upstream'
  abbr -a gst 'git st'

  # bundler
  abbr -a bundlex 'bundle exec'
  abbr -a bx 'bundle exec'

  # vagrant
  abbr -a vp 'vagrant provision'
  abbr -a vssh 'vagrant ssh'
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

fish_add_path --path --prepend $HOME/.local/bin $HOME/.rbenv/shims
fish_add_path --path --append /usr/local/sbin

set -x COWPATH "$HOME/.cows:$COWPATH"

set -x BAT_THEME "base16"

set -x ARDUINO_DIR /Applications/Arduino.app/Contents/Java/
set -x ARDMK_DIR $HOME/Code/Arduino-Makefile

set -l OS_SPECIFIC_CONFIG "$HOME/.config/fish/os-specific/$OS.fish"
set -l HOST_SPECIFIC_CONFIG "$HOME/.config/fish/host-specific/$HOST.fish"

if test -e "$OS_SPECIFIC_CONFIG"
  source "$OS_SPECIFIC_CONFIG"
end
if test -e "$HOST_SPECIFIC_CONFIG"
  source "$HOST_SPECIFIC_CONFIG"
end
