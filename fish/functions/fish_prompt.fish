# 19-04-03 - most up-to-date version!

function __ayyylmao_colors -S -a color_scheme -d 'Define colors used by nonissue'
  switch "$color_scheme"
    case 'light'
      # CURRENTLY THE SAME AS DARK EXCEPT FOR COMPLETION CHANGES
      # local vars with approximate names to just aid in theming
      set -l blue_gray              314a70
      set -l grey_med               857f77
      set -l grey_dark              61676C
      set -l dark_yellow            EBC562
      set -l dark_orange            E35B00
      set -l dust_black             07171B
      set -l dust_black_bright      6E767B
      set -l dust_grey              839496
      set -l dust_blue              0E558C
      set -l dust_bright_blue       1587DF
      set -l dust_bright_red        EC5E01
      set -l dust_bright_yellow     FFD56D
      set -l dust_red               EB7000
      set -l dust_redalt            BC4B01
      set -l dust_bright_magneta    FF9446
      set -l dust_green             3D8479
      set -l dust_bright_green      52B2A3

      set -l greys                  424242 616161 757575
      set -l blues                  $dust_bright_blue $dust_blue $blue_gray
      
      # theme current colour scheme vars
      set -x set_path             (set_color -o $dust_blue)
      set -x set_prompt           $blues
      set -x set_extra            (set_color -o $grey_med)
      set -x set_status_l         (set_color -b $grey_dark)
      set -x set_status_r         (set_color -o $grey_dark)
      set -x set_branch           (set_color -o $dust_bright_blue)
      set -x set_ind_clean        (set_color -o $grey_med)
      set -x set_ind_dirty        (set_color -o $dark_orange)
      set -x set_ind_mod          (set_color -o $dark_yellow)
      
      # otherwise the completion looks bad on light themes?
      set -x fish_pager_color_prefix        4CBF99 # teal
      set -x fish_pager_color_completion    6E5346 # brown

    case 'dark'
      # Only a few changes between this and light
      # local vars with approximate names to just aid in theming
      set -l blue_gray              314a70
      set -l grey_med               857f77
      set -l grey_dark              61676C
      set -l dark_yellow            EBC562
      set -l dark_orange            E35B00
      set -l dust_black             07171B
      set -l dust_black_bright      6E767B
      set -l dust_grey              839496
      set -l dust_blue              0E558C
      set -l dust_bright_blue       1587DF
      set -l dust_med_blue          09699D
      set -l dust_bright_red        EC5E01
      set -l dust_bright_yellow     FFD56D
      set -l dust_red               EB7000
      set -l dust_redalt            BC4B01
      set -l dust_bright_magneta    FF9446
      set -l dust_green             3D8479
      set -l dust_bright_green      52B2A3
      set -l new_blue               3a3a3a #005f87 #5f8787 
      
      set -l teal                   4CBF99

      set -l greys                  424242 616161 757575
      set -l blues                  $dust_bright_blue $dust_med_blue $dust_blue 
      
      # theme current colour scheme vars
      set -x set_path               (set_color -o $dust_blue)
      set -x set_prompt             $blues
      set -x set_extra              (set_color -o $grey_med)
      set -x set_status_l           (set_color -o $new_blue)
      set -x set_status_r           (set_color -o $new_blue)
      set -x set_branch             (set_color -o $dust_red)
      set -x set_ind_clean          (set_color -o $grey_med)
      set -x set_ind_dirty          (set_color -o EEEEEE)
      set -x set_ind_mod            (set_color -o $dark_yellow)
      set -x set_white              (set_color -o EEEEEE)
      set -x set_bright_green       (set_color -o $dust_bright_green)
      
      # otherwise the completion looks bad on light themes?
      # the prefix looks good on dark too tbh
      set -x fish_pager_color_prefix        $teal # teal
      set -x fish_pager_color_completion    $dust_bright_blue # bright blue
      set -x fish_color_autosuggestion      $dust_green # teal
  end
end

__ayyylmao_colors dark

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
    echo -n "$set_status_l  "
    echo -en $set_path(prompt_pwd)
    echo -n "$set_status_l"
end

function show_status -a last_status

    if [ $last_status -ne 0 ]
        set current_color red
    end

    
    # echo -n " "

    for color in $set_prompt # setcolor for >>> at prompt
        echo -n (set_color $color)">"
    end

    echo -n " "
    
    set_color normal
end

function fish_right_prompt

    set --local LIMBO /dev/null
    set --local git_status (git status --porcelain 2> $LIMBO)
    set --local extra "$set_bright_green" #-- others ⧒ ⧑ ⧔ ⧕ ⧖⧗ (times with÷) ≍⫏⧇⦿⦸⦷⦵⧆⧈⊜≡≣∗∅=⊡⋐⨀*⤲

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
            set git_info "$set_status_l" "[$set_branch$git_branch$set_status_l]" #setcolor for git indicator (dirty), git branch𝌆
            if not [ -z (echo "$git_status" | grep -e '^[MDA]') ]
                # If there is new or deleted files, update status𝌡
                set extra "$set_ind_mod*" #setcolor for git indicator (dirty)✱✲
            end
        else if [ ~(_is_git_dirty) ]
            set git_info "$extra$set_status_l" "⟬$set_bright_green$git_branch$set_status_l⟭" # setcolor for git branch?
        end
    end

    

    echo -n -s $git_info
    # set_color -b 596f73
    show_git_info
    set_color -o 596f73
    show_path
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
