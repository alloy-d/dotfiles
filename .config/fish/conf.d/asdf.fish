if command -q asdf
  set -l asdf_dir (asdf info 2>/dev/null | grep ASDF_DIR | string split '=' -f2)
  set -l asdf_setup "$asdf_dir/asdf.fish"

  test -e "$asdf_setup"; and source "$asdf_setup"
end
