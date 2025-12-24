function _is_git_dirty
    echo (command git status -s --ignore-submodules=dirty 2>/dev/null)
end

function _git_branch_name
    echo (command git symbolic-ref HEAD 2>/dev/null | sed -e 's|^refs/heads/||')
end

function show_git_info
    set --local LIMBO /dev/null
    set --local git_status (git status --porcelain 2> $LIMBO)
    set --local dirty ""
    [ $status -eq 128 ]; and return # Not a repository? Nothing to do
end

# only display a host name if we're in an ssh session
function __ssh_host
    if test -n "$SSH_CLIENT$SSH2_CLIENT$SSH_TTY"
        set_color -d white
        echo -n $USER@
        set_color normal
        set_color -d -o fish_color_host_remote
        echo -n (hostname -s)

        set_color normal
    end
end

function show_path
    set_color normal
    set_color -b $fish_color_gray_bg
    string join '' -- " "(prompt_pwd)" "
    set_color normal
end

function show_virtualenv_name
    if set -q VIRTUAL_ENV
        echo -en "["(basename "$VIRTUAL_ENV")"] "
    end
end

function fish_right_prompt

    # set --local LIMBO /dev/null
    # set --local git_status (git status --porcelain 2> $LIMBO)

    set -l git_status (git status --porcelain 2>/dev/null)

    # set --local extra
    #-- others ⧒ ⧑ ⧔ ⧕ ⧖⧗ (times with÷) ≍⫏⧇⦿⦸⦷⦵⧆⧈⊜≡≣∗∅=⊡⋐⨀*⤲

    set -l status_l "<"
    set -l status_r ">"

    if [ (_git_branch_name) ]
        set -l git_branch (_git_branch_name)
        set git_info "$git_branch"
    end

    # TODO !
    # IDEAS BELOW!

    # maybe just change the color of the tetragram to indicate
    # repo is dirty rather than the branch name? 
    # grey_blue -> clean
    # red -> dirty, nothing staged
    # yellow -> dirty, staged file additions/deletions

    # ⏘ --> nothing changed? EDIT: eh doens't look good in term 
    # maybe: ⊜
    # 𝌆 --> new file additions/deletions, not staged
    # 𝌡 --> new staged file additions/deletions, not committed
    # 𝍖 --> for stashed?
    # other symbols: ⤽⤼⥅⫀⪿⨄⨦⨧⨮⨴⊛⊕⊙⊘⊚⊝ ●○
    # WE gots to do smething

    if [ (_git_branch_name) ]
        set -l git_branch (_git_branch_name)
        set -l structural ""
        if [ (_is_git_dirty) ]

            # set extra (set_color $fish_color_command)"dirty:"(set_color normal)
            # i actually cant remember what "extra" is for, but i think i had a valid use case
            # maybe update vs modified files?

            # okay, actually, it's currently showing up if there is ONLY a NEW file that IS staged but NOT committed
            # if there is a new staged file AND modified files, it does not show up
            # if not [ -z (echo "$git_status" | grep -e '^[MDA\?]') ]
            # set extra "a+aextra" #setcolor for git indicator (dirty)✱✲
            # end

            # okay i think this is working??
            # indicates when there is a new file that is not staged and/or staged

            if string match -rq '^(?:[AD].|.[AD]|\?\?)' -- $git_status
                set structural (set_color green)"± "
            end

            set git_info_tmp "$git_branch" #setcolor for git indicator (dirty), git branch𝌆

            # set git_info (set_color --bold $fish_color_operator)"$git_branch+ "(set_color normal) #setcolor for git indicator (dirty), git branch𝌆
            set git_info (string join '' -- (set_color -b $fish_color_gray_bg_dark)" "(set_color -o red) $structural (set_color -o $fish_color_host_remote) $git_info_tmp)(set_color $fish_color_operator)" ✱ "(set_color normal) #setcolor for git indicator (dirty), git branch𝌆

            set_color normal
        else if [ ~(_is_git_dirty) ]
            set git_info (set_color -o $fish_color_command)"$extra$git_branch • "(set_color normal) # setcolor for git branch?
        end

    end

    # echo -n -s $git_info
    string join '' -- $git_info (show_path) (set_color normal)

end
