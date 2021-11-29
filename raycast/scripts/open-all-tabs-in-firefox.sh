#!/usr/bin/osascript

# @raycast.schemaVersion 1
# @raycast.title Open All Tabs in Firefox
# @raycast.mode silent

# @raycast.description Opens all tabs in the current Safari window in Firefox Developer Edition
# @raycast.author Andy Williams
# @raycast.authorURL https://github.com/nonissue

# @raycast.icon 🦊
# @raycast.mode silent
# @raycast.packageName Safari
# @raycast.schemaVersion 1

tell application "Safari"
	tell front window
		if its document exists then
			set AppleScript's text item delimiters to linefeed
			set urlList to URL of its tabs
			set the clipboard to (urlList as text)
		end if
	end tell
end tell

tell application "Firefox Developer Edition"
	activate
	delay 0.5
	repeat with currentSite in urlList as list
		open location currentSite
	end repeat
	activate
end tell