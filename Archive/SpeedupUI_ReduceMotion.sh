#!/usr/bin/env bash

# Disable Open/Close Window Animations
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

# Disable Quick Look Animations
defaults write -g QLPanelAnimationDuration -float 0

# Disable Window Size Adjustment Animations
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# Disable Dock Animations
defaults write com.apple.dock launchanim -bool false

# Disable the “Get Info” Animation
defaults write com.apple.finder DisableAllAnimations -bool true

# Make all animations faster that are used by Mission Control.
defaults write com.apple.dock expose-animation-duration -float 0.1

# Disable the delay when you hide the Dock
defaults write com.apple.Dock autohide-delay -float 0

# Disable the animation when you sending and replying an e-mail
defaults write com.apple.mail DisableReplyAnimations -bool true
defaults write com.apple.mail DisableSendAnimations -bool true

# Disable the standard delay in rendering a Web page.
defaults write com.apple.Safari WebKitInitialTimedLayoutDelay 0.25
