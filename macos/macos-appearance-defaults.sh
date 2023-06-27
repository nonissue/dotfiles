#!/bin/bash

# quit sysprefs before doing anything
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Revert to previous macos alert layout
# See: https://pxlnv.com/linklog/fix-macos-alerts/
defaults write -g NSAlertMetricsGatheringEnabled -bool false

echo "  › Increase the window resize speed for Cocoa applications"
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

echo "  › Disable the 'Are you sure you want to open this application?' dialog"
defaults write com.apple.LaunchServices LSQuarantine -bool false

echo "  › Speeding up Mission Control animations and grouping windows by application"
defaults write com.apple.dock expose-animation-duration -float 0.1
defaults write com.apple.dock expose-group-by-app -bool true

echo "  › Expand save panel by default"
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# remove dock animation:
# defaults write com.apple.dock autohide-time-modifier -int 0 && killall Dock

echo "  › Minimize windows into their application’s icon."
echo "  › default: false"
echo "  › defaults write com.apple.dock minimize-to-application -bool true"
defaults write com.apple.dock minimize-to-application -bool true

# Change space switching from slide to fade
# default: -int 0
# Note: this might need sudo in 10.14?
defaults write com.apple.universalaccess reduceMotion -int 1

# Wipe all (default) app icons from the Dock
# This is only really useful when setting up a new Mac, or if you don’t use
# the Dock to launch apps.
# defaults write com.apple.dock persistent-apps -array

# Don’t animate opening applications from the Dock
defaults write com.apple.dock launchanim -bool false

# Speed up Mission Control animations
defaults write com.apple.dock expose-animation-duration -float 0.1

# remove dock delay in big sur
defaults write com.apple.dock autohide-delay -float 0 && killall Dock

for app in "Activity Monitor" \
	"cfprefsd" \
	"Contacts" \
	"Dock" \
	"Finder" \
	"Mail" \
	"Messages" \
	"Safari" \
	"SystemUIServer" \
	"iCal"; do
	killall "${app}" &> /dev/null
done