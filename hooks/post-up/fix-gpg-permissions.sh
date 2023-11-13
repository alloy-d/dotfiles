#!/bin/sh

find ~/.gnupg -type d -exec chmod 0700 {} \;
find ~/.gnupg -type f -or -type l -not -name '*.sh' -exec chmod 0600 {} \;
