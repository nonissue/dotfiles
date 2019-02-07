# 314a70 090e13



# FIXME aka get rid of all these colors smdh
# also have different colours for light and dark?

##########################
# Light theme

function __ayyylmao_colors -S -a color_scheme -d 'Define colors used by nonissue'

  switch "$color_scheme"
    case 'light'
      set -l blue_gray              314a70
      # set -l greys                cccccc 999999 333333
      set -l greys                  424242 616161 757575
      
      set -l grey_med               857f77
      set -l grey_dark              61676C
      set -l dark_yellow            EBC562
      set -l dark_orange            E35B00
      set -l dust_black             07171B
      set -l dust_black_bright      6E767B
      set -l dust_grey              839496
      set -x dust_blue 0E558C
      set -l dust_bright_blue       1587DF
      set -l dust_bright_red EC5E01
      set -x dust_bright_yellow FFD56D
      set -x dust_red EB7000
      set -x dust_redalt BC4B01
      set -l dust_bright_magneta FF9446
      set -l dust_green 3D8479
      set -l dust_bright_green 52B2A3

      set -l blues                  $dust_bright_blue $dust_blue $blue_gray
      
      set -x set_path             (set_color -o $dust_blue)
      set -x set_prompt           $blues
      set -x set_extra            (set_color -o $grey_med)
      set -x set_status_l         (set_color -o $grey_dark)
      set -x set_status_r         (set_color -o $grey_dark)
      set -x set_branch           (set_color -o $dust_bright_blue)
      set -x set_ind_clean        (set_color -o $grey_med)
      set -x set_ind_dirty        (set_color -o $dark_orange)
      set -x set_ind_mod          (set_color -o $dark_yellow)

    case 'spacedust'
      # Based on spacedust terminal theme
      # Minor adjustments, not exact
      # Not all colors listed are used! I'm keeping them here 
      # as a sketch so I know what else I have to implement
      
      # generics
      set -x grey       cccccc 999999 333333
      set -x white      ffffff
      set -x black      111111 # i dont want actual black tbh
      set -l ruby_red af0000

      # spacedust colors
      set -x dust_blue 0E558C
      set -x dust_bright_blue 1587DF
      set -x dust_green 3D8479
      set -x dust_bright_green 52B2A3
      set -x dust_grey 839496
      set -x dust_black 07171B
      set -x dust_bright_black 6E767B
      set -x dust_bright_white E5E5E5
      set -x dust_bright_magneta FF9446
      set -x dust_bright_yellow FFD56D
      set -x dust_red EB7000
      set -x dust_redalt BC4B01
      set -x dust_bright_red EC5E01
      
      # only combos i use
      set -x repo_bg_dirty                  normal $dust_bright_yellow
      set -x repo_bg_clean                  normal $dust_bright_green
      set -x curdir_bg                      $dust_redalt $white
      set -x segment_exit                   $grey[3] $grey[1]

      # the rest
      # set -x color_initial_segment_exit     $grey[3] $grey[1]
    case 'ayu-light'
    # colors taken from ayu-light theme
      set -x grey       cccccc 999999 333333
      set -x white      ffffff
      set -x black      111111 # i dont want actual black tbh
      set -l ruby_red af0000

      
      set -l accent FF8F40
      set -l foreground 6F7A86
      set -l cursor FF8000
      set -l selection F3F1E9
      set -l gutter_fg D9DBDD
      set -l gutter_bg FAFAFA
      set -l invisibles D9DBDD
      set -l line_hl F3F3F3
      set -l comments ABB0B6
      set -l var 61676C
      set -l constant FF8F40
      
      set -l white FAFAFA

      set -l pale_orange FF8F40
      set -x rich_orange FA6E32
      set -x bright_orange F29718 
      set -x another_orange ED9366
      set -l peach E6B673

      set -x med_blue 399EE6
      set -x pale_blue 55B4D4
      set -x darker_blue 5CA4D4
      set -x darkest_blue 2571A4
      
      set -l pink F07171
      set -x red F51818
      set -l red_pink ec5f67

      set -l lav c594c5

      set -x teal 4CBF99
      set -x puke_green 86B300
      set -x dust_green 3D8479
      set -x dust_bright_green 52B2A3


      set -x light_grey DEE0E1
      set -x light_grey2 D9DBDD
      set -x lightest_grey E9F2F8
      set -x med_grey ABB0B6
      set -x med_grey2 B9BCBF
      set -x dark_grey 61676C

      set -x curdir_bg                      $lightest_grey $darkest_blue --bold
      set -x repo_bg_dirty                  normal normal --bold
      set -x repo_bg_clean                  normal normal --bold
      
      set -x segment_exit                   $grey[3] $grey[1]

  end
end

##########################

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


set -x theme_color_scheme light
__ayyylmao_colors light


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
  # $set_prompt
  # set_color $set_prompt
  echo -en $set_path(prompt_pwd)
  echo -n " "
end


function show_status -a last_status

    set --local current_color "FFF"

    if [ $last_status -ne 0 ]
        set current_color red
    end

    
    # echo -n " "

    for color in $set_prompt # setcolor for >>> at prompt
        echo -n (set_color $color)">"
    end

    echo -n " "
    
    set_color $current_color
    
    set_color normal
end


function fish_right_prompt

    set --local LIMBO /dev/null
    set --local git_status (git status --porcelain 2> $LIMBO)
    set --local extra "$set_extra𝌆" # indicates no files are staged

    set --local dark_grey 555
    set -l status_l "$set_status_l<" #setcolor for status left
    set -l status_r "$set_status_r>" #setcolor for status right
 
    if [ (_git_branch_name) ]
      # set -l setdarkgrey (set_color -o $dark_grey) #setcolor for branch name
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
            set git_info "$set_ind_dirty𝌆 $set_branch$git_branch" #setcolor for git indicator (dirty), git branch
            if not [ -z (echo "$git_status" | grep -e '^[MDA]') ]
                # If there is new or deleted files, update status
                set extra "$set_ind_mod𝌡" #setcolor for git indicator (dirty)
            end
        else if [ ~(_is_git_dirty) ]
            set git_info "$extra $set_branch$git_branch" # setcolor for git branch?
        end
    end

    set_color 090e13 # setcolor for path
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
