# Mostly lifted from https://github.com/chriskempson/base16-shell
if status --is-interactive
  set -l BASE24_SHELL_DIR "$HOME/.local/share/base24/shell"
  set -l BASE24_SHELL_HOOKS "$HOME/.config/base24-hooks"

  set -l BASE24_CURRENT_THEME_LINK "$HOME/.base24_theme"

  # load currently active theme:
  if test -e $BASE24_CURRENT_THEME_LINK
    set -l SCRIPT (realpath $BASE24_CURRENT_THEME_LINK)
    set -gx BASE24_THEME (basename $SCRIPT .sh)
    eval sh '"'$SCRIPT'"'
  end

  # create a function per theme:
  for SCRIPT in $BASE24_SHELL_DIR/scripts/*.sh
    set THEME (basename $SCRIPT .sh)

    function $THEME -V SCRIPT -V THEME
      # load the theme
      sh $SCRIPT

      # update the theme symlink
      ln -sf $SCRIPT ~/.base24_theme

      # update the global theme variable
      set -gx BASE24_THEME (string split -m 1 '-' $THEME)[2]

      # update the file we source in vim to set colors
      # TODO: this could be a hook.
      echo -e "if !exists('g:colors_name') || g:colors_name != '$THEME'\n  colorscheme $THEME\nendif" > ~/.vimrc_background

      # run hooks
      if test (count $BASE24_SHELL_HOOKS) -eq 1; and test -d "$BASE24_SHELL_HOOKS"
        for hook in $BASE24_SHELL_HOOKS/*
          test -f "$hook"; and test -x "$hook"; and "$hook"
        end
      end
    end
  end
end
