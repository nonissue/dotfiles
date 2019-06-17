function fish_user_key_bindings
  bind \cr 'peco_select_history (commandline -b)'
  #bind \cf peco_cd # Bind for peco change directory to Ctrl+F
end

#fzf_key_bindings

bind ! __history_previous_command
bind '$' __history_previous_command_arguments
