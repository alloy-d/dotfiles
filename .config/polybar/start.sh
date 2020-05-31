#!/bin/sh

YELLOW="$(xgetres polybar.color3)"
BRIGHT_BLACK="$(xgetres polybar.color8)"
FG_ALT="$BRIGHT_BLACK"

CPU_TEMP_PREFIX="%{T2}%{F${FG_ALT}}CPU%{F- T-}"
GPU_TEMP_PREFIX="%{T2}%{F${FG_ALT}}GPU%{F- T-}"

export CPU_TEMP_LABEL="${CPU_TEMP_PREFIX} %temperature-c%"
export CPU_TEMP_LABEL_WARN="${CPU_TEMP_PREFIX} %{F${YELLOW}}%temperature-c%%{F-}"

export GPU_TEMP_LABEL="${GPU_TEMP_PREFIX} %temperature-c%"
export GPU_TEMP_LABEL_WARN="${GPU_TEMP_PREFIX} %{F${YELLOW}}%temperature-c%%{F-}"

polybar -r top &
polybar -r bottom &
