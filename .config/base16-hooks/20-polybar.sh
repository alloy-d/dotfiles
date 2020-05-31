#!/bin/sh

# Some of the polybar formatting is done by a shell script before
# starting polybar, so a simple USR1 isn't enough to make it reload.
pkill -x polybar
$HOME/.config/polybar/start.sh 2>/dev/null
