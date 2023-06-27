#!/bin/bash

# largely stolen from:
# https://github.com/mathiasbynens/dotfiles/blob/master/.macos
# https://github.com/holman/dotfiles/blob/master/macos/set-defaults.sh

# I have no idea if all of these work, some of them may have been depreciated

# quit sysprefs before doing anything
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Disable press-and-hold for keys in favor of key repeat.
defaults write -g ApplePressAndHoldEnabled -bool false

###############################################################################
# Misc
###############################################################################

echo "  › Enable text replacement almost everywhere"
defaults write -g WebAutomaticTextReplacementEnabled -bool true

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Increase sound quality for Bluetooth headphones/headsets
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

# Use AirDrop over every interface. srsly this should be a default.
defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1

# Show the ~/Library folder.
chflags nohidden ~/Library

# Disable shadow in screenshots
defaults write com.apple.screencapture disable-shadow -bool true

# Screenshot functionality tweaks (accomdations for my hammerspoon spoon)
defaults write com.apple.screencapture location -string "${HOME}/Documents/screenshots/2016mbpr/"
defaults write com.apple.screencapture name "$(hostname) - "
defaults write com.apple.screencapture type -string "png"

# ┌─────────────────────────────────────────────────────────────────────────────┐
# │ Dock Stuff																	│
# └─────────────────────────────────────────────────────────────────────────────┘

# Show the /Volumes folder
sudo chflags nohidden /Volumes

# ┌─────────────────────────────────────────────────────────────────────────────┐
# │ Launchpad									   								│
# └─────────────────────────────────────────────────────────────────────────────┘

# change number of launchpad cols
# defaults write com.apple.dock springboard-columns -int 9
# change number of launchpad rows
# defaults write com.apple.dock springboard-rows -int 6

# reset launchpad after changes
# we also need to kill finder (I think) but we handle this at end of script
# defaults write com.apple.dock ResetLaunchPad -bool TRUE;

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

echo "Done. Note that some of these changes require a logout/restart to take effect."

