set theme-scripts-dir = ~/.local/share/base16/shell/scripts
set shell-hooks-dir = ~/.config/base16-hooks

set current-theme-script = ~/.base16_theme

if ?(test -e $current-theme-script) {
  sh $current-theme-script
}

fn use [theme-name]{
  set theme-script = $theme-scripts-dir"/base16-"$theme-name".sh"

  try {
    test -e $theme-script
  } except {
    fail "theme '"$theme-name"' does not seem to exist."
  }

  sh $theme-script

  ln -sf $theme-script $current-theme-script

  put $shell-hooks-dir/*.sh | peach [hook]{
    try {
      test -f $hook
      test -x $hook
    } except {
      fail "hook script '"$hook"' cannot be run."
    }

    $hook
  }
}
