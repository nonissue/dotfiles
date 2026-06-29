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

function __prompt_user
    if test -n "$SSH_CLIENT$SSH2_CLIENT$SSH_TTY"
        set_color $fish_color_autosuggestion
        echo -n $USER
        set_color -d $fish_color_autosuggestion
        echo -n "@"
        set_color normal
        set_color -d $fish_color_cwd
        echo -n (hostname -s)
        set_color normal
    else 
        set_color $fish_pager_color_completion
        echo -n (whoami)
        set_color normal
    end
end

function fish_prompt
    set -l last_status $status
    # Prompt status only if it's not 0
    set -l stat

    if test $last_status -ne 0
        set stat (set_color $fish_color_redirection)"$last_status"(set_color normal)
    end

    set prompt_prefix_color $fish_pager_color_prefix

    if test $last_status -ne 0
        set prompt_prefix_color brred
    end

    # Virtualenv (python venv etc.) prefixed on the left, only when active.
    set -l venv ""
    if set -q VIRTUAL_ENV
        set venv (set_color cyan)"("(path basename $VIRTUAL_ENV)") "(set_color normal)
    end

    # string join '' -- (set_color $prompt_prefix_color)'❯ '(set_color red)

    string join '' -- "$venv"(__prompt_user)(set_color -o $prompt_prefix_color)' ❯ '(set_color normal)

end
