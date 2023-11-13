#!/bin/sh

pgrep -x bspwm > /dev/null || exit 0

bspc config normal_border_color   "$(xgetres bspwm.color8)"
bspc config active_border_color   "$(xgetres bspwm.color1)"
bspc config focused_border_color  "$(xgetres bspwm.color4)"
bspc config presel_feedback_color "$(xgetres bspwm.color2)"
