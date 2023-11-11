set fish_greeting

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
  abbr -a gpfc 'git push origin (git current) --force-with-lease'
  abbr -a gplc 'git pull origin (git current)'
  abbr -a gpffc 'git pull --ff-only origin (git current)'
  abbr -a gpsu 'git push --set-upstream'

  # ripgrep, but with a useful pager
  abbr -a rgl --set-cursor 'rg --color=always --heading --line-number % | less -R'

  # bundler
  abbr -a bundlex 'bundle exec'
  abbr -a bx 'bundle exec'

  # vagrant
  abbr -a vp 'vagrant provision'
  abbr -a vssh 'vagrant ssh'
end

function gdel --wraps 'git branch' --description 'deletes a git branch real good'
  git branch -d "$argv[1]" && git push origin ":$argv[1]"
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
