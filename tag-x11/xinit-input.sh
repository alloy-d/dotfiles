#!/bin/sh

# if using a trackpad, enable natural scrolling
xinput --set-prop "Apple Inc. Magic Trackpad 2" "libinput Natural Scrolling Enabled" 1

TRACKBALL="$(xinput list | grep "Logitech MX Ergo" | grep pointer | perl -n -e'/id=(\d+)/ && print "$1\n"')"
echo "Trackball is ${TRACKBALL}"
if [ -n "$TRACKBALL" ]; then
  SCROLL_METHOD="302"
  SCROLL_BUTTON="304"
  xinput --set-prop --type=int --format=8 "$TRACKBALL" "$SCROLL_METHOD" 0 0 1
  xinput --set-prop "$TRACKBALL" "$SCROLL_BUTTON" 8
  xinput --set-button-map "$TRACKBALL" 1 2 3 4 5 8 9 6 7
fi

# use Colemak
setxkbmap -variant colemak -option caps:ctrl_modifier

