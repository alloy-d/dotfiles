set -l os_specific "$__fish_config_dir/os-specific/$(uname).fish"
set -l host_specific "$__fish_config_dir/host-specific/$(hostname -s).fish"

test -e "$os_specific"; and source "$os_specific"
test -e "$host_specific"; and source "$host_specific"
