# simple function to get git branch name
# taken from krisleech
function _git_branch_name

    echo (command git symbolic-ref HEAD 2>/dev/null | sed -e 's|^refs/heads/||')
end

# Async prompt setup.
# set async_prompt_functions _git_branch_name

function _git_branch_name_loading_indicator
    echo (set_color brblack)…(set_color normal)
end
