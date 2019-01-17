
# Load Oh My Fish configuration.
set fish_greeting

set -x FZF_LEGACY_KEYBINDINGS 0
set -x FZF_DEFAULT_COMMAND 'git ls-tree -r --name-only HEAD 2> /dev/null; or fd --type f --hidden --follow --exclude .git 2> /dev/null'
set -x FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND

set -x EDITOR nvim
set -x GREP_COLOR "1;37;45"

# fisher init
#if not functions -q fisher
#    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
#    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
#    fish -c fisher
# end

set -g fisher_path {$HOME}/.dotfiles/fish/fisher

set fish_function_path $fish_function_path[1] $fisher_path/functions $fish_function_path[2..-1]
set fish_complete_path $fish_complete_path[1] $fisher_path/completions $fish_complete_path[2..-1]

for file in $fisher_path/conf.d/*.fish
    builtin source $file 2> /dev/null
end

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

# fixes bug with iterm/fish_mode_prompt?
function fish_mode_prompt; end
# iterm
test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish
