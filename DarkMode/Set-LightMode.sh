#!/usr/bin/env bash

# Author: Joerg Hochwald <http://jhochwald.com>
# License: BSD 3-Clause License

# Load some defaults
. /etc/bashrc

PATH=/usr/local/bin:/usr/local/sbin/:/var/root/bin/:$PATH
export PATH

# Execute the Apple Script
osascript -e "tell application \"System Events\"" -e "tell appearance preferences" -e "set dark mode to false" -e "end tell" -e "end tell"

exit 0
