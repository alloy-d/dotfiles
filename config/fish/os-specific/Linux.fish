set -x AUR_PAGER /usr/bin/ranger

set -x DOWNLOADS "$HOME/downloads"
set -x XDG_DOWNLOAD_DIR "$DOWNLOADS"

# set -x MOZ_ENABLE_WAYLAND "true"
# set -x QT_QPA_PLATFORM "wayland"
# set -x XDG_CURRENT_DESKTOP "sway"
set -x XKB_DEFAULT_VARIANT "colemak"

set -x SXHKD_SHELL /usr/bin/dash

test -d /opt/asdf-vm/bin; and fish_add_path --path --append /opt/asdf-vm/bin

function fish_command_not_found
  __fish_default_command_not_found_handler $argv[1]
end
