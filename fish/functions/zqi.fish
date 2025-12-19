# ------------------------------------------------------------------------------
# zqi — zoxide *interactive* picker with command expansion
#
# Opens zoxide's interactive selector (no pre-filled query), then optionally
# executes a command using the selected directory.
#
# Behavior:
#   - If called with no args, prints the selected path to stdout (composable).
#   - If called with a command, runs that command with the selected path
#     appended as the final argument.
#
# Examples:
#   zqi
#       → pick a directory interactively, then print its path
#
#   zqi code
#       → pick a directory interactively, then open it in VS Code
#
#   zqi du -hs
#       → pick a directory interactively, then run `du -hs <dir>`
#
# Notes:
#   - Uses `zoxide query -i` (interactive mode).
#   - If you cancel the picker, nothing runs and the function exits non-zero.
#   - Does not use eval; arguments are passed safely.
# ------------------------------------------------------------------------------
function zqi --description "pass result from zoxide interactive query picker to command"
    set -l path (zoxide query -i)

    # If the user cancels interactive selection, zoxide returns empty output.
    if test -z "$path"
        return 1
    end

    # If no command is provided, just print the selected path (composable)
    if test (count $argv) -eq 0
        echo $path
        return 0
    end

    # Otherwise, run the command with the selected path appended
    command $argv $path
end
