#!/usr/bin/env bash

# Enable the firewall
sudo defaults write /Library/Preferences/com.apple.alf globalstate -bool true

# Enable logging
sudo defaults write /Library/Preferences/com.apple.alf loggingenabled -bool true

# You may also wish to enable stealth mode
sudo defaults write /Library/Preferences/com.apple.alf stealthenabled -bool true

# Finally, you may wish to disable feature, Automatically allow signed software to receive incoming connections
#sudo defaults write /Library/Preferences/com.apple.alf allowsignedenabled -bool false

# Disable the Apple Network probes for Captive portal
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.captive.control Active -bool false

# Set your screen to lock as soon as the screensaver starts
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Expose hidden files and Library folder in Finder
#defaults write com.apple.finder AppleShowAllFiles -bool true
chflags nohidden ~/Library

# Don't default to saving documents to iCloud
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Disable crash reporter
defaults write com.apple.CrashReporter DialogType none

# Disable Dashboard
defaults write com.apple.dashboard mcx-disabled -boolean YES

# Disable Bonjour multicast advertisements
sudo defaults write /Library/Preferences/com.apple.mDNSResponder.plist NoMulticastAdvertisements -bool YES
