# -------------------------------------------------------------------
# Function: explain
# Author: Andy Williams (https://github.com/nonissue)
# -------------------------------------------------------------------
# Pipes the current command in input buffer to explain shell
# Hopefully I'll be slightly less ignorant about the things I copy and 
# paste off stack overflow now
# Make sure you add the keybinding in your config.fish:
# Example below binds CTRL + H
#   bind \ch explain
# -------------------------------------------------------------------

function explain -d "Pipe current command to explainshell.com (hotkey: C-H)"
  set -l command_buffer (commandline)
  open "https://explainshell.com/explain?cmd="$command_buffer
end
