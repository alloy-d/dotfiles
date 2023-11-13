if command -q gem
  set -l user_gem_dir (gem environment gempath | string split ':' | head -n 1)

  fish_add_path --path --prepend "$user_gem_dir/bin"
end
