# function show_status -a last_status
#     if [ $last_status -ne 0 ]
#         set current_color red
#     end

#     for color in $set_prompt # setcolor for >>> at prompt
#         echo -n (set_color $fish_pager_color_prefix)"❯"
#     end

#     echo -n " "

#     set_color normal
# end

# function fish_prompt
#     # Keep the command executed status
#     set --local last_status $status
#     # __ssh_badge

#     show_status $last_status
# end

function fish_prompt
    set -l last_status $status
    # Prompt status only if it's not 0
    set -l stat

    if test $last_status -ne 0
        set stat (set_color $fish_color_redirection)"$last_status"(set_color normal)
    end

    string join '' -- $stat (set_color $fish_pager_color_prefix)'❯ '(set_color red)
    # string join '' -- (set_color $fish_pager_color_prefix)"❯" 
    # string join '' -- (set_color $fish_pager_color_prefix)"❯" $stat ' >'
end
