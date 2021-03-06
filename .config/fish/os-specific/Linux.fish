set -x AUR_PAGER /usr/bin/ranger

set -x DOWNLOADS "$HOME/downloads"
set -x XDG_DOWNLOAD_DIR "$DOWNLOADS"

set -x QT_QPA_PLATFORM "wayland"
set -x XKB_DEFAULT_VARIANT "colemak"

set -x SXHKD_SHELL /usr/bin/dash

function fish_command_not_found
  __fish_default_command_not_found_handler $argv[1]
end
