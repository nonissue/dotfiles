# ------------------------------------------------------------------------------
# zq — zoxide query helper with command expansion
#
# Resolves a zoxide query to its best-matched directory and optionally executes
# a command with that directory as an argument.
#
# Behavior:
#   - If called with only a query, prints the resolved path to stdout.
#     This makes `zq` composable with other shell tools.
#
#   - If additional arguments are provided, treats them as a command and
#     executes that command with the resolved path appended as the final
#     argument.
#
# Examples:
#   zq ai
#       → prints the path that best matches "ai" according to zoxide
#
#   zq ai code
#       → opens the matched directory in VS Code
#
#   zq temp du -hs
#       → runs `du -hs <matched-directory>`
#
#   zq proj ls
#       → lists the contents of the matched directory
#
# Notes:
#   - Uses zoxide’s ranking to select the most relevant directory.
#   - Does not use eval; arguments are passed safely.
#   - Designed to replace common `zoxide query | xargs <cmd>` patterns.
# ------------------------------------------------------------------------------

function zq
    if test (count $argv) -lt 1
        echo "usage: zq <query> [command ...]" 1>&2
        return 2
    end

    set -l query $argv[1]
    set -l path (zoxide query -- $query)

    # If no command is provided, just print the path (composable)
    if test (count $argv) -eq 1
        echo $path
        return 0
    end

    # Otherwise, run the command with the path appended
    set -l cmd $argv[2..-1]
    command $cmd $path
end
