#!/usr/bin/osascript

# @raycast.title Open Safari URL in Firefox
# @raycast.description Open current Safari URL in new tab in Firefox
# @raycast.author Dave Lehman
# @raycast.authorURL https://github.com/dlehman

# @raycast.icon images/safari.png
# @raycast.mode silent
# @raycast.packageName Safari
# @raycast.schemaVersion 1

tell application "Safari"
    set safariUrl to URL of front document
end tell

set appname to "Firefox Developer Edition"
tell application appname to launch

# hacky way to wait for app to be launched 
# we have to wait before asking it to open the url
repeat until application appname is running
    delay 0.5
end repeat

tell application appname
    # activate
    # delay 1.25
    open location safariUrl
    activate
end tell