function append_to_path
  for entry in $argv
    contains $entry $PATH; or set -x PATH $PATH $entry
  end
end
