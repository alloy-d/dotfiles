#!/usr/bin/dash

NUM="$1"
INDEX=`expr $NUM - 1`

# waybar sorts workspace names, swaybar does not.
SORT=""

getworkspaces() {
  swaymsg -r -t get_workspaces
}

if test "$SORT" = "true"; then
  getworkspaces | jq -r "map(.name)|sort|.[$INDEX] // $NUM"
else
  getworkspaces | jq -r ".[$INDEX].name // $NUM"
fi
