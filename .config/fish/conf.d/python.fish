if command -q python3
  set PYTHON_USER_BASE (python3 -m site --user-base)
  fish_add_path --path --prepend "$PYTHON_USER_BASE/bin"
end
