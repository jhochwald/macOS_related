#!/usr/bin/env bash

defaults write /Library/Preferences/com.apple.loginwindow LoginwindowText "Directory passwords are cached!"
defaults write /Library/Preferences/com.apple.loginwindow showInputMenu -bool TRUE
rm -rf /System/Library/Caches/com.apple.corestorage/EFILoginLocalizations/*.efires
