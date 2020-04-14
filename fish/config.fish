set fish_greeting

# Third-party tools
# -----------------

if [ -f /usr/share/autojump/autojump.fish ]
  source /usr/share/autojump/autojump.fish
else if [ -f /usr/local/share/autojump/autojump.fish ]
  source /usr/local/share/autojump/autojump.fish
end

if status --is-interactive
  set BASE16_SHELL "$HOME/.config/base16-shell"
  source "$BASE16_SHELL/profile_helper.fish"
end

if status --is-interactive
  set BASE16_SHELL "$HOME/.config/base16-shell/"
  source "$BASE16_SHELL/profile_helper.fish"
end


# Aliases
# -------

alias c='curl -D - -H -'

# Some convenience aliases for bundler:
alias bundlex='bundle exec'
alias bx='bundle exec'

# Convenience aliases for Vagrant:
alias vp='vagrant provision'
alias vssh='vagrant ssh'

# Aliases for git:
alias gap='git add -p'
alias gci='git ci'
alias gp='git push'
alias gpc='git push origin (git current)'
alias gpsu='git push --set-upstream'
alias gst='git st'

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

function gmtm --wraps 'git merge' --description 'merge a branch into the latest master'
  git co master && git pull origin master && git merge --no-ff $argv
end
function gmm --wraps 'git merge' --description 'merge the latest master into the current branch'
  git fetch origin && git merge --no-ff origin/master $argv
end
function gdel --wraps 'git branch' --description 'deletes a git branch real good'
  git branch -d "$argv[1]" && git push origin ":$argv[1]"
end

# Aliases for vim:
alias nview='nvim -R'
alias ndiff='nvim -d'

alias swift="env PATH=/System/Library/Frameworks/Python.framework/Versions/Current/bin:$PATH swift"

function rgl --wraps rg --description 'rg with pager'
  rg --color=always --heading --line-number $argv | less -R
end

# Environment
# -----------

set -x EDITOR nvim
set -x TERMINAL kitty

set -x GOPATH $HOME/.go
set -x PATH $HOME/.rbenv/shims $PATH /usr/local/sbin

set -x COWPATH "$HOME/.cows:$COWPATH"

set -x RIPGREP_CONFIG_PATH "$HOME/.ripgreprc"

set -x BAT_THEME "ansi-dark"

set -x NVM_DIR "$HOME/.nvm"

set -x ARDUINO_DIR /Applications/Arduino.app/Contents/Java/
set -x ARDMK_DIR $HOME/Code/Arduino-Makefile

set -x SXHKD_SHELL /usr/bin/sh

# Point Ansible to a vault password file:
#set -x ANSIBLE_VAULT_PASSWORD_FILE $HOME/.vault.txt


# GPG Agent
# ---------
set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent


# Fortune
# -------

set ANNA_FORTUNE $HOME/Code/anna-fortune/anna.txt

if status --is-interactive
  if test -e $ANNA_FORTUNE
    fortune $ANNA_FORTUNE
    echo ""
  end
end

# opam configuration
source /Users/adam/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true

# HBO configuration
set HBO_CONFIG "$HOME/Code/HBO/config.fish"
if test -e "$HBO_CONFIG"
  source "$HBO_CONFIG"
end
