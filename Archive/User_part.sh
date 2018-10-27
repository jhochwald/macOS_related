#!/usr/bin/env bash

# Source: https://benchmarks.cisecurity.org/tools2/osx/CIS_Apple_OSX_10.10_Benchmark_v1.0.0.pdf

# User

# By showing the Bluetooth status in the menu bar, a small Bluetooth icon is placed in the menu bar.
defaults write com.apple.systemuiserver menuExtras -array-add "/System/Library/CoreServices/Menu Extras/Bluetooth.menu"
defaults read com.apple.systemuiserver menuExtras | grep Bluetooth.menu

# Set Screensaver to 10 minutes (or less if you like)
defaults -currentHost write com.apple.screensaver idleTime -int 300

# iCloud Drive is Apple's storage solution for applications on both OS X and iOS to use the same files that are resident in Apple's cloud storage.
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
defaults read NSGlobalDomain NSDocumentSaveNewDocumentsToCloud

# Certificates should only be trusted if they have both a satisfactory trust chain and they have not been revoked.
defaults write com.apple.security.revocation CRLStyle -string RequireIfPresent
defaults read com.apple.security.revocation CRLStyle
defaults write com.apple.security.revocation OCSPStyle -string RequireIfPresent
defaults read com.apple.security.revocation OCSPStyle

# Prompting for a password when waking from sleep or screensaver mode mitigates the threat of an unauthorized person gaining access to a system in the user's absence.
defaults write com.apple.screensaver askForPassword -int 1
defaults read com.apple.screensaver askForPassword

# System Preferences controls system and user settings on an OS X Computer.
security authorizationdb read system.preferences 2>/dev/null | grep -A1 shared | grep -E '(true|false)'

# A filename extension is a suffix added to a base filename that indicates the base filename's file format.
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults read NSGlobalDomain AppleShowAllExtensions

# Safari will automatically run or execute what it considers safe files.
defaults write com.apple.Safari AutoOpenSafeDownloads -boolean no
defaults read com.apple.Safari AutoOpenSafeDownloads
