#!/usr/bin/osascript

# @raycast.title Open Website in Orion
# @raycast.description Open current Safari URL in a new tab in Orion
# @raycast.author Andy Williams
# @raycast.authorURL https://github.com/nonissue

# @raycast.icon images/safari.png
# @raycast.mode silent
# @raycast.packageName Safari
# @raycast.schemaVersion 1

tell application "Safari"
    set safariUrl to URL of front document
end tell

tell application "Orion"
    activate
    delay 1.25
    open location safariUrl
    activate
end tell