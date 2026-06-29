# Right prompt:  [duration]  [git]  [cwd]
#
# Named-ANSI colours so it tracks the active terminal theme. The two Nerd Font
# glyphs (branch, folder) are injected as real bytes; standard Unicode symbols
# (↑ ↓) are inline. Every segment is conditional.

function __prompt_git
    # One porcelain v2 call yields branch, ahead/behind, and per-file states.
    set -l raw (command git status --porcelain=v2 --branch 2>/dev/null)
    test (count $raw) -gt 0; or return

    set -l branch ""
    set -l oid ""
    set -l ahead 0
    set -l behind 0
    set -l dirty 0  # any change -> branch shows amber

    for line in $raw
        set -l t (string sub -l 1 -- $line)
        if test $t = '#'
            if string match -q '# branch.head *' -- $line
                set branch (string replace '# branch.head ' '' -- $line)
            else if string match -q '# branch.oid *' -- $line
                set oid (string replace '# branch.oid ' '' -- $line)
            else if string match -q '# branch.ab *' -- $line
                set -l p (string split ' ' -- $line)
                set ahead (string sub -s 2 -- $p[3])
                set behind (string sub -s 2 -- $p[4])
            end
        else if test $t = 1 -o $t = 2
            set dirty 1
        else if test $t = u
            set dirty 1
        else if test $t = '?'
            set dirty 1
        end
    end

    # Detached HEAD -> short sha instead of a branch name.
    test "$branch" = '(detached)'; and set branch ":"(string sub -l 7 -- $oid)


    # Branch colour signals state: green = clean, yellow (amber) = dirty.
    set -l branch_color yellow
    test $dirty -eq 0; and set branch_color green

    set -l out (set_color $branch_color)" "(set_color normal)
    set out $out (set_color -o $branch_color)"$branch"(set_color normal)
    test $ahead -gt 0; and set out $out (set_color cyan)"↑$ahead"(set_color normal)
    test $behind -gt 0; and set out $out (set_color cyan)"↓$behind"(set_color normal)

    string join '' $out
end

function __prompt_duration
    test "$CMD_DURATION" -gt 4000; or return
    set -l d
    if test $CMD_DURATION -ge 60000
        set d (math -s0 "floor($CMD_DURATION/60000)")"m "(math -s0 "floor(($CMD_DURATION%60000)/1000)")"s"
    else
        set d (math -s1 $CMD_DURATION/1000)"s"
    end
    string join '' -- (set_color brblack)"$d"(set_color normal)
end

function show_path
    # Folder glyph + soft-gray path, no background.
    set -l g_folder ''
    string join '' -- (set_color brblack)"$g_folder "(prompt_pwd)(set_color normal)
end

function fish_right_prompt
    set -l segs
    set -l dur (__prompt_duration)
    test -n "$dur"; and set segs $segs "$dur"
    set -l git (__prompt_git)
    test -n "$git"; and set segs $segs "$git"
    set segs $segs (show_path)
    string join '  ' $segs
end
