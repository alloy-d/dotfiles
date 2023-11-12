function prepend_to_path
  for entry in $argv
    contains $entry $PATH; or set -x PATH $entry $PATH
  end
end
