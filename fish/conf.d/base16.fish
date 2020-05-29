# Mostly lifted from https://github.com/chriskempson/base16-shell
if status --is-interactive
  set BASE16_SHELL_DIR "$HOME/.config/base16-files/shell"
  set BASE16_SHELL_HOOKS "$HOME/.config/base16-hooks"

  # load currently active theme:
  if test -e ~/.base16_theme
    set -l SCRIPT_NAME (basename (realpath ~/.base16_theme) .sh)
    set -gx BASE16_THEME (string match 'base16-*' $BASE16_THEME | string sub -s (string length 'base16-*'))
    eval sh '"'(realpath ~/.base16_theme)'"'
  end

  # create a function per theme:
  for SCRIPT in $BASE16_SHELL_DIR/scripts/*.sh
    set THEME (basename $SCRIPT .sh)

    function $THEME -V SCRIPT -V THEME
      # load the theme
      sh $SCRIPT

      # update the theme symlink
      ln -sf $SCRIPT ~/.base16_theme

      # update the global theme variable
      set -gx BASE16_THEME (string split -m 1 '-' $THEME)[2]

      # update the file we source in vim to set colors
      # TODO: this could be a hook.
      echo -e "if !exists('g:colors_name') || g:colors_name != '$THEME'\n  colorscheme $THEME\nendif" > ~/.vimrc_background

      # run hooks
      if test (count $BASE16_SHELL_HOOKS) -eq 1; and test -d "$BASE16_SHELL_HOOKS"
        for hook in $BASE16_SHELL_HOOKS/*
          test -f "$hook"; and test -x "$hook"; and "$hook"
        end
      end
    end
  end
end
