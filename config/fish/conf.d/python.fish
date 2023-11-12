if which python3 > /dev/null
  set PYTHON_USER_BASE (python3 -m site --user-base)
  prepend_to_path "$PYTHON_USER_BASE/bin"
end
