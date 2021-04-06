if status --is-interactive
  if [ -f /usr/share/autojump/autojump.fish ]
    source /usr/share/autojump/autojump.fish
  else if [ -f /opt/homebrew/share/autojump/autojump.fish ]
    source /opt/homebrew/share/autojump/autojump.fish
  else if [ -f /usr/local/share/autojump/autojump.fish ]
    source /usr/local/share/autojump/autojump.fish
  end
end
