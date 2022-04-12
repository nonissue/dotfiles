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

# Use AirDrop over every interface. srsly this should be a default.
defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1

# Show the ~/Library folder.
chflags nohidden ~/Library

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Increase sound quality for Bluetooth headphones/headsets
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

# Screenshot functionality tweaks (accomdations for my hammerspoon spoon)
defaults write com.apple.screencapture location -string "${HOME}/Documents/screenshots/2016mbpr/"
defaults write com.apple.screencapture name "$(hostname) - "
defaults write com.apple.screencapture type -string "png"

# Disable shadow in screenshots
defaults write com.apple.screencapture disable-shadow -bool true

# Revert to previous macos alert layout
# See: https://pxlnv.com/linklog/fix-macos-alerts/
defaults write -g NSAlertMetricsGatheringEnabled -bool false

###############################################################################
# Finder                                                                      #
###############################################################################

# Finder: allow quitting via ⌘ + Q; doing so will also hide desktop icons
defaults write com.apple.finder QuitMenuItem -bool false

# Always open everything in Finder's list view. This is important.
defaults write com.apple.finder FXPreferredViewStyle Nlsv

# Finder: disable window animations and Get Info animations
defaults write com.apple.finder DisableAllAnimations -bool true

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Expand the following File Info panes:
# “General”, “Open with”, and “Sharing & Permissions”
defaults write com.apple.finder FXInfoPanesExpanded -dict \
	General -bool true \
	OpenWith -bool true \
	Privileges -bool true

# Set Desktop as the default location for new Finder windows
# For other paths, use `PfLo` and `file:///full/path/here/`
defaults write com.apple.finder NewWindowTarget -string "PfLo"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

###############################################################################
# Dock Stuff
###############################################################################

# Wipe all (default) app icons from the Dock
# This is only really useful when setting up a new Mac, or if you don’t use
# the Dock to launch apps.
#defaults write com.apple.dock persistent-apps -array

# Don’t animate opening applications from the Dock
defaults write com.apple.dock launchanim -bool false

# Speed up Mission Control animations
defaults write com.apple.dock expose-animation-duration -float 0.1

# remove dock delay in big sur
defaults write com.apple.dock autohide-delay -float 0 && killall Dock

# remove dock animation:
# defaults write com.apple.dock autohide-time-modifier -int 0 && killall Dock

# Show the full URL in the address bar (note: this still hides the scheme)
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# Set Safari’s home page to `about:blank` for faster loading
defaults write com.apple.Safari HomePage -string "about:blank"

# Allow hitting the Backspace key to go to the previous page in history
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true

# Enable Safari’s debug menu
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

# Enable the Develop menu and the Web Inspector in Safari
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

# Add a context menu item for showing the Web Inspector in web views
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

# Don’t display the annoying prompt when quitting iTerm
defaults write com.googlecode.iterm2 PromptOnQuit -bool false

# Enable the WebKit Developer Tools in the Mac App Store
defaults write com.apple.appstore WebKitDeveloperExtras -bool true

# Enable Debug Menu in the Mac App Store
defaults write com.apple.appstore ShowDebugMenu -bool true

# Show the /Volumes folder
sudo chflags nohidden /Volumes

# Minimize windows into their application’s icon
# default: -bool false
defaults write com.apple.dock minimize-to-application -bool true

# Change space switching from slide to fade
# default: -int 0
# Note: this might need sudo in 10.14?
defaults write com.apple.universalaccess reduceMotion -int 1

###############################################################################
# Launchpad
###############################################################################

# change number of launchpad cols
defaults write com.apple.dock springboard-columns -int 9
# change number of launchpad rows
defaults write com.apple.dock springboard-rows -int 6

# reset launchpad after changes
# we also need to kill finder (I think) but we handle this at end of script
defaults write com.apple.dock ResetLaunchPad -bool TRUE;

###############################################################################
# Activity Monitor                                                            #
###############################################################################

# Show the main window when launching Activity Monitor
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

# Visualize CPU usage in the Activity Monitor Dock icon
defaults write com.apple.ActivityMonitor IconType -int 5

# Show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# Sort Activity Monitor results by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

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

