if which gem > /dev/null 2>&1
  set -l user_gem_dir (gem environment gempath | string split ':' | head -n 1)

  prepend_to_path "$user_gem_dir/bin"
end
