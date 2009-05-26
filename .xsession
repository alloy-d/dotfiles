#!/bin/sh

#
# ~/.xsession
#
# Executed by xdm/gdm/kdm at login
#

xmodmap ~/.xmodmaprc

/bin/bash --login -i ~/.xinitrc

