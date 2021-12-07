#!/bin/bash

BASE16="${HOME}/.local/share/base16"
BASE16_KITTY="${BASE16}/kitty"
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

set_kitty() {
  echo "Configuring kitty..."
  source="${BASE16_KITTY}/colors/${THEME}-256.conf"
  config="${HOME}/.config/kitty/kitty.conf"
  colors_config="$(mktemp)"

  if [ ! -f "$source" ]; then
    echo "Problem setting kitty theme: '${source}' doesn't exist." >&2
    return 2
  fi

  # Generate a new config with just the colors stuff.
  echo "include ${source}" >> "${colors_config}"
  grep 'color9 ' < "${source}" | sed 's/color9/cursor/' >> "${colors_config}"

  # Get rid of the old colors stuff.
  sed -i "\|^include ${BASE16}|d" "${config}"
  sed -i '/^cursor /d' "${config}"

  # Add the new colors config to the config file.
  cat < "${colors_config}" >> "${config}"

  # Set colors now in currently running kitties.
  pgrep -x kitty && kitty @ set-colors -a "${colors_config}" >/dev/null 2>&1 || true
}

if [ ! -L "$SHELL_THEME_LINK" ]; then
  echo "${SHELL_THEME_LINK} doesn't exist or isn't a link; aborting." >&2
  exit 1
fi

THEME=$(basename "$(readlink "$SHELL_THEME_LINK")" .sh)
echo "Setting theme ${THEME}..."

set_kitty
set_rofi
set_sway
set_xresources
