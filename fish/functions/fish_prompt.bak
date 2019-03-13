# 314a70 090e13

# FIXME aka get rid of all these colors smdh
set -x sel_bg 06496F
set -x line_num 244F61
set -x gutter_bg 0F2930
set -x brown 6E5346
set -x light_brown CA763C
set -x dark_yellow EBC562
set -x dark_orange E35B00
set -x dark_green 008080
set -x dark_blue 09699D

set -x teal 4CBF99
set -x puke_green 86B300
set -x dust_blue 0E558C
set -x dust_red EB7000
set -x dust_redalt BC4B01
set -x orange EC5E01

set -x light_grey DEE0E1
set -x med_grey ABB0B6
set -x dark_grey 61676C
set -x darkest_grey 090e13
set -x blue_gray 314a70
set -x greys 424242 616161 757575

# this is actually insane,
# some of these don't even set the color they say
# they do, because i'm dumb
set -x setdarkgrey (set_color -o $dark_grey)
set -x setdarkergrey (set_color -o 333)
set -x setdarkestgrey (set_color -o $darkest_grey)
set -x setdarkerblue (set_color -o $blue_gray)
set -x setorange (set_color -o $dark_orange)
set -x setyellow (set_color -o $dark_yellow)
set -x setred (set_color -o $dust_redalt)
set -x setblue (set_color -o 314a70)
set -x setgreen (set_color -o $puke_green)
set -x midgrey (set_color -o 857f77)

set -x indcolors $dark_grey $med_grey $dark_grey

function _git_branch_name
  echo (command git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
end

function _is_git_dirty
  echo (command git status -s --ignore-submodules=dirty ^/dev/null)
end

function fish_prompt

    # Keep the command executed status
    set --local last_status $status

    show_status $last_status
end


function show_path
    set_color $brown
    set color 
    echo -en (prompt_pwd)
    echo -n " "
end


function show_status -a last_status

    set --local current_color "FFF"

    if [ $last_status -ne 0 ]
        set current_color red
    end

    
    # echo -n " "

    for color in $greys
        echo -n (set_color $color)">"
    end

    echo -n " "
    
    set_color $current_color
    
    set_color normal
end


function fish_right_prompt
    set --local LIMBO /dev/null
    set --local git_status (git status --porcelain 2> $LIMBO)
    set --local extra "$midgrey𝌆" # indicates no files are staged

    # A dark grey
    set --local dark_grey 555
    set -l status_l "$setdarkgrey<"
    set -l status_r "$setdarkgrey>"
 
    if [ (_git_branch_name) ]
      set -l setdarkgrey (set_color -o $dark_grey)
      set -l git_branch (_git_branch_name)
      set git_info " $git_branch"
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
            set git_info "$setorange𝌆 $midgrey$git_branch"
            if not [ -z (echo "$git_status" | grep -e '^[MDA]') ]
                # If there is new or deleted files, update status
                set extra "$setyellow𝌡"
            end
        else if [ ~(_is_git_dirty) ]
            set git_info "$extra $midgrey$git_branch"
        end
    end

    set_color 090e13
    show_path

    echo -n -s $git_info
    show_git_info

    set_color normal
end


function show_virtualenv_name

    if set -q VIRTUAL_ENV
        echo -en "["(basename "$VIRTUAL_ENV")"] "
    end
end


function show_git_info

    set --local LIMBO /dev/null
    set --local git_status (git status --porcelain 2> $LIMBO)
    set --local dirty ""
    [ $status -eq 128 ]; and return  # Not a repository? Nothing to do
end
