# set fish_greeting


set -g XDG_CONFIG_HOME ~/.dotfiles

# if not functions -q fisher
#     set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.dotfiles
#     curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
#     fish -c fisher
# end

# set -g fisher_path {$HOME}/.dotfiles/fisher

# set fish_function_path $fish_function_path[1] $fisher_path/functions $fish_function_path[2..-1]
# set fish_complete_path $fish_complete_path[1] $fisher_path/completions $fish_complete_path[2..-1]

# for file in $fisher_path/conf.d/*.fish
#     builtin source $file 2> /dev/null
# end

set -x FZF_LEGACY_KEYBINDINGS 0
set -x FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow'
set -x FZF_DEFAULT_OPTS "--height 40 --ansi"
set -x FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
set -x FZF_FIND_FILE_COMMAND "fd --type f --hidden --follow . \$dir"
set -x FZF_OPEN_COMMAND $FZF_DEFAULT_COMMAND
set -U FZF_PREVIEW_FILE_CMD "bat"
set -x FZF_CD_COMMAND 'fd --type directory --follow --hidden'
set -x FZF_CD_WITH_HIDDEN_COMMAND 'fd --type directory --follow --hidden --exclude .git'
set -g FZF_COMPLETE 2

set -x EDITOR nvim
set -x GREP_COLOR "1;37;45"
set -x LS_COLORS 'ow=01;36;40'

function ..    ; cd .. ; end
function ...   ; cd ../.. ; end
function ....  ; cd ../../.. ; end
function ..... ; cd ../../../.. ; end
function ll    ; tree --dirsfirst -ChFupDaLg 1 $argv ; end

function df       ; command df -h $argv ; end
function grep     ; command grep --color=auto $argv ; end
function ip       ; curl -s http://checkip.dyndns.com/ | sed 's/[^0-9\.]//g' ; end
function lookbusy ; cat /dev/urandom | hexdump -C | grep --color "ca fe" ; end
function t        ; command tree -C $argv ; end
function view     ; nvim -R $argv ; end
function cat      ; command bat $argv ; end

function jjrf     ; source ~/.config/fish/config.fish ; end
function venv	  ; source ~/.dotfiles/env/python3/bin/activate.fish ; end

abbr ff  "$EDITOR ~/.config/fish/config.fish"
abbr tt  "$EDITOR ~/.tmux.conf"
abbr vv  "$EDITOR ~/.config/nvim/init.vim"

# Fuzzy find & vim
function vp
  if test (count $argv) -gt 0
    command nvim $argv
  else
    fzf -m | xargs nvim
  end
end

# fixes bug with iterm/fish_mode_prompt?
function fish_mode_prompt; end

# `brew doctor` was giving a warning about /usr/local/sbin not being found 
# in fish path, so i'm setting it here (19-05-09)
# Seems to be working and not duplicating in basic testing

# attach to tmux automatically when logging in using ssh
function tmux_attach
    if status --is-login
        set PPID (echo (ps --pid %self -o ppid --no-headers) | xargs)
        if ps --pid $PPID | grep ssh
            tmux has-session -t remote; and tmux attach-session -t remote; or tmux new-session -s remote; and kill %self
            echo "tmux failed to start; using plain fish shell"
        end
    end
end

# set -g prevents path items being duplicated when fish is reloaded
# as we are shadowing the global variable with a session variable
# info: https://github.com/fish-shell/fish-shell/issues/5117
switch (uname)
    case Darwin 
        # set -x PATH /usr/bin /bin /usr/local/sbin /usr/sbin /sbin /usr/local/bin
            
        set -g fish_user_paths "/usr/local/opt/fzf/bin /usr/local/bin /usr/bin /usr/local/sbin /bin /usr/sbin /sbin /usr/local/opt/curl/bin" $fish_user_paths
        set -g os "macOS"
    case Linux
        set -g os "Linux"
        # set -U fish_user_paths "/usr/local/opt/fzf/bin /usr/bin /usr/local/bin /usr/local/sbin /bin /usr/sbin /sbin /home/ops/.local/bin" $fish_user_paths
        set -Ua fish_user_paths ~/.local/bin
        set -g -x PATH $PATH

        function fish_greeting
            /bin/cat /run/motd.dynamic
        end
        # tmux_attach
end

# iterm
test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish
