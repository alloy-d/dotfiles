if status --is-login; and command -q gem
  set -l user_gem_dir (gem environment gempath | string split ':' | head -n 1)

  # Presumably this is the user gem directory for the system ruby,
  # so I want it at the end of the path. Otherwise, it risks overriding
  # asdf shims.
  fish_add_path --path --append "$user_gem_dir/bin"
end
