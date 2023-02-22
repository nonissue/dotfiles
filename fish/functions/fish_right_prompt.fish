

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

# Currently not using this, as __ssh_host obviates its utility
function __ssh_badge
    # See if any standard SSH environment variables contain anything
    if test -n "$SSH_CLIENT$SSH2_CLIENT$SSH_TTY"
        # dark purple on light purple
        set_color -b d6aeec -o 2a0a8b
        # first character of remote hostname, uppercase
        echo -n "\("(string upper (string sub -s 1 -l 1 (hostname -s)))"\) "
        set_color normal
    end
end

# only display a host name if we're in an ssh session
function __ssh_host
    if test -n "$SSH_CLIENT$SSH2_CLIENT$SSH_TTY"
        set_color -d white
        echo -n "("$USER@
        set_color normal
        set_color -d -o brmagenta
        echo -n (hostname -s)
        echo -n ")"
        set_color normal
    end
end

function show_path
    echo -n "$set_status_l"
    echo -en $set_path(prompt_pwd) ""
    echo -n "$set_status_l"
end


function show_virtualenv_name
    if set -q VIRTUAL_ENV
        echo -en "["(basename "$VIRTUAL_ENV")"] "
    end
end


function fish_right_prompt
    set --local LIMBO /dev/null
    set --local git_status (git status --porcelain 2> $LIMBO)
    set --local extra "" #-- others ⧒ ⧑ ⧔ ⧕ ⧖⧗ (times with÷) ≍⫏⧇⦿⦸⦷⦵⧆⧈⊜≡≣∗∅=⊡⋐⨀*⤲

    set -l status_l "$set_status_l<"
    set -l status_r "$set_status_r>"

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
        if [ (_is_git_dirty) ]
            set git_info "$set_status_l $set_branch$git_branch$set_status_l$set_fish_color_cwd+ " #setcolor for git indicator (dirty), git branch𝌆
            if not [ -z (echo "$git_status" | grep -e '^[MDA]') ]
                # If there is new or deleted files, update status𝌡
                set extra "$set_ind_mod*" #setcolor for git indicator (dirty)✱✲
            end
        else if [ ~(_is_git_dirty) ]
            set git_info "$extra$set_status_l $set_fish_color_cwd$git_branch$set_status_l$set_fish_color_cwd• " # setcolor for git branch?
        end


    end

    __ssh_host
    echo -n -s $git_info
    show_git_info
    set_color -o 596f73
    show_path
    set_color normal
end
