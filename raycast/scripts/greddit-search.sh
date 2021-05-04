#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Search Reddit using Google
# @raycast.mode silent
# @raycast.packageName Web Searches

# Optional parameters:
# @raycast.icon images/google.png
# @raycast.argument1 { "type": "text", "placeholder": "query", "percentEncoded": true}

open "https://www.google.com/search?q=site:reddit.com%20$1"