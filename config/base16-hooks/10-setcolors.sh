#!/bin/bash

BASE16="${HOME}/.local/share/base16"
BASE16_ROFI="${BASE16}/rofi"
BASE16_SWAY="${BASE16}/sway"
BASE16_XRESOURCES="${BASE16}/xresources"

SHELL_THEME_LINK="${HOME}/.base16_theme"

set_xresources() {
  echo "Clobbering ~/.Xresources-colors..."
  source="${BASE16_XRESOURCES}/xresources/${THEME}-256.Xresources"
  if [ ! -f "$source" ]; then
    echo "Problem setting ~/.Xresources-colors: '${source}' doesn't exist." >&2
    return 2
  fi
  cat "$source" > "$HOME/.Xresources-colors"

  if [ ! -z "$DISPLAY" ]; then
    xrdb -merge "$HOME/.Xresources-colors"
  fi
}

set_sway() {
  echo "Configuring sway..."
  source="${BASE16_SWAY}/themes/${THEME}.config"

  ln -sf "$source" "$HOME/.config/sway/base16-theme.config"

  pgrep -x sway > /dev/null && swaymsg reload
}

set_rofi() {
  echo "Configuring rofi..."
  source="${BASE16_ROFI}/themes/${THEME}.rasi"
  config="${HOME}/.config/rofi/config.rasi"

  if [ ! -f "$source" ]; then
    echo "Problem setting rofi theme: '${source}' doesn't exist." >&2
    return 2
  fi

  cat <<EOF > $config
/* DON'T EDIT THIS, DOOFUS. IT'S AUTOMATICALLY GENERATED. */
configuration {
  font: "Iosevka Semibold 18";
}
@theme "${source}"
EOF
}

reload_i3() {
  echo "Reloading i3..."
  # Colors come from Xresources, so just need to reload.

  pgrep -x i3 > /dev/null && i3-msg reload
}

if [ ! -L "$SHELL_THEME_LINK" ]; then
  echo "${SHELL_THEME_LINK} doesn't exist or isn't a link; aborting." >&2
  exit 1
fi

THEME=$(basename "$(readlink "$SHELL_THEME_LINK")" .sh)
echo "Setting theme ${THEME}..."

set_rofi
set_sway
set_xresources

reload_i3
