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

  # jj - command abbreviations, only available in fish >= 4
  if test (string sub -l 1 $version) -ge 4
    abbr -a -c jj np 'new -B @'                       # "new parent"
    abbr -a -c jj sp 'squash --interactive --into @-' # "squash into parent"

    abbr -a -c jj nne 'new --no-edit'
    abbr -a -c jj nnep 'new --no-edit -B @'
    abbr -a -c jj nnea 'new --no-edit --after'
    abbr -a -c jj nneb 'new --no-edit --before'

    abbr -a -c jj si 'squash --interactive'
    abbr -a -c jj sit 'squash --interactive --to'

    abbr -a -c jj bmt 'bookmark move trunk --to @'
    abbr -a -c jj bmtt 'bookmark move trunk --to'

    abbr -a -c jj gf 'git fetch'
    abbr -a -c jj gp 'git push'
    abbr -a -c jj gpa 'git push --all'
  end

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

if status --is-login
  set -x TERMINAL alacritty
  set -x MANWIDTH 80

  if command -q nvim
    set -x DIFFPROG 'nvim -d'
    set -x EDITOR nvim
  else if command -q nano
    set -x EDITOR nano
  end

  command -q most; and set -x MANPAGER most

  set -x GOPATH $HOME/.go

  fish_add_path --path --prepend $HOME/.local/bin
  fish_add_path --path --append /usr/local/sbin

  set -x COWPATH "$HOME/.cows:$COWPATH"

  set -x BAT_THEME "base16"

  set -x ARDUINO_DIR /Applications/Arduino.app/Contents/Java/
  set -x ARDMK_DIR $HOME/Code/Arduino-Makefile

  set -x RIPGREP_CONFIG_PATH $HOME/.config/ripgrep/rc
end
