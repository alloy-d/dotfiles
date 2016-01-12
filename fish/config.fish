set fish_greeting

# Third-party tools
# -----------------

[ -f /usr/local/share/autojump/autojump.fish ]; and . /usr/local/share/autojump/autojump.fish


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
alias gpsu='git push --set-upstream'
alias gst='git st'

# Environment
# -----------

set -x GOPATH $HOME/.go
set -x PATH $HOME/.rbenv/shims $GOPATH/bin /usr/local/opt/go/libexec/bin $PATH

set -x COWPATH "$HOME/.cows:$COWPATH"

set -x ARDUINO_DIR /Applications/Arduino.app/Contents/Java/
set -x ARDMK_DIR $HOME/Code/Arduino-Makefile

# Point Ansible to a vault password file:
#set -x ANSIBLE_VAULT_PASSWORD_FILE $HOME/.vault.txt


# Fortune
# -------

set ANNA_FORTUNE $HOME/Code/anna-fortune/anna.txt

if status --is-interactive
  if test -e $ANNA_FORTUNE
    fortune $ANNA_FORTUNE
    echo ""
  end
end
