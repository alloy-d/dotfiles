if status --is-login && command -q asdf
  set -x ASDF_DATA_DIR "$HOME/.asdf"
  fish_add_path --path --prepend "$ASDF_DATA_DIR/shims"
end
