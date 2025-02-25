# quit sysprefs before doing anything
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &


echo "  › Enable text replacement almost everywhere"
defaults write -g WebAutomaticTextReplacementEnabled -bool true

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Use AirDrop over every interface. srsly this should be a default.
defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1

# Show the ~/Library folder.
chflags nohidden ~/Library

# Screenshot functionality tweaks (accomdations for my hammerspoon spoon)
defaults write com.apple.screencapture location -string "${HOME}/Documents/screenshots/2021mbp/"
defaults write com.apple.screencapture name "$(hostname)"
defaults write com.apple.screencapture type -string "png"
defaults write com.apple.screencapture show-thumbnail -bool false

echo "  › Expand save panel by default"
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

# 
# FINDER
# 

echo ""
echo "› Finder:"

echo "  › Always open everything in Finder's list view"
defaults write com.apple.Finder FXPreferredViewStyle Nlsv

echo "  › Display full POSIX path as Finder window title"
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Finder: allow quitting via ⌘ + Q; doing so will also hide desktop icons
# defaults write com.apple.finder QuitMenuItem -bool false

echo "  › Finder: disable window animations and Get Info animations"
defaults write com.apple.finder DisableAllAnimations -bool true

echo "  › Finder: show all filename extensions"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

echo "  › Finder: show status bar"
defaults write com.apple.finder ShowStatusBar -bool true

echo "  › Finder: show path bar"
defaults write com.apple.finder ShowPathbar -bool true

echo "  › Disable the warning when changing a file extension"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

echo "  › Expand the following File Info panes:"
# “General”, “Open with”, and “Sharing & Permissions”
defaults write com.apple.finder FXInfoPanesExpanded -dict \
	General -bool true \
	OpenWith -bool true \
	Privileges -bool true

echo "  › Set Desktop as the default location for new Finder windows"
echo "  › For other paths, use \`PfLo\` and \`file:///full/path/here/\`"
defaults write com.apple.finder NewWindowTarget -string "PfLo"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

echo "  › When performing a search, search the current folder by default"
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"



# 
# SAFARI
# 
echo ""
echo "› Safari:"

echo "  › Add a context menu item for showing the Web Inspector in web views"
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true


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


#
# Doesn't work in 2025?
#

# echo "  › Enable Safari’s debug menu"
# defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

#
# Doesn't work in 2025?
#

# echo "  › Enable the Develop menu and the Web Inspector in Safari"
# defaults write com.apple.Safari IncludeDevelopMenu -bool true
# defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
# defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

