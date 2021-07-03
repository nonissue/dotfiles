# set fish_greeting

set -g XDG_CONFIG_HOME ~/.dotfiles
set -x GREP_COLOR "1;37;45"
set -x LS_COLORS 'ow=01;36;40'

set -x FZF_LEGACY_KEYBINDINGS 0
set -x FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow'
set -x FZF_DEFAULT_OPTS "--height 40 --ansi"
set -x FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
set -x FZF_FIND_FILE_COMMAND "fd --type f --hidden --follow . \$dir"
set -x FZF_OPEN_COMMAND $FZF_DEFAULT_COMMAND
set -U FZF_PREVIEW_FILE_CMD bat
set -x FZF_CD_COMMAND 'fd --type directory --follow --hidden'
set -x FZF_CD_WITH_HIDDEN_COMMAND 'fd --type directory --follow --hidden --exclude .git'
set -g FZF_COMPLETE 2

function ..
    cd ..
end
function ...
    cd ../..
end
function ....
    cd ../../..
end
function .....
    cd ../../../..
end
function ll
    tree --dirsfirst -ChFupDaLg 1 $argv
end

function df
    command df -h $argv
end
function grep
    command grep --color=auto $argv
end
function ip
    curl -s http://checkip.dyndns.com/ | sed 's/[^0-9\.]//g'
end
function lookbusy
    cat /dev/urandom | hexdump -C | grep --color "ca fe"
end
function t
    command tree -C $argv
end
function view
    nvim -R $argv
end
function cat
    command bat $argv
end

# Keybinding for explainshell function
bind \ch explain

function jjrf
    source ~/.config/fish/config.fish
end
function venv
    source ~/.dotfiles/env/python3/bin/activate.fish
end

abbr ff "$EDITOR ~/.config/fish/config.fish"
abbr tt "$EDITOR ~/.tmux.conf"
abbr vv "$EDITOR ~/.config/nvim/init.vim"

# Fuzzy find & vim
function vp
    if test (count $argv) -gt 0
        command nvim $argv
    else
        fzf -m | xargs nvim
    end
end

# fixes bug with iterm/fish_mode_prompt?
function fish_mode_prompt
end

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
        # This isn't working for sourcing macports, hmmm.
        # works if we add one segment at a time
        # Do they have to be separated by colon?
        # lol, yup that seems to have fixed it
        set -Ux EDITOR code
        # set -e fish_user_paths
        # set -U fish_user_paths "/opt/local/bin:/opt/local/sbin:/usr/local/opt/fzf/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/bin:/usr/sbin:/sbin:/usr/local/opt/curl/bin:/opt/local/bin:/usr/local/bin:$HOME/.cargo/bin"
        # set -U fish_user_paths "/opt/local/bin /opt/local/sbin /usr/local/opt/fzf/bin /usr/local/bin /usr/bin /usr/local/sbin /bin /usr/sbin /sbin /usr/local/opt/curl/bin /opt/local/bin /usr/local/bin $HOME/.cargo/bin"
        fish_add_path "/opt/local/bin /opt/local/sbin /usr/local/opt/fzf/bin /usr/local/bin /usr/bin /usr/local/sbin /bin /usr/sbin /sbin /usr/local/opt/curl/bin /usr/local/bin /Users/apw/.cargo/bin /opt/local/bin /usr/local/bin /usr/bin /bin /usr/sbin /sbin /Library/Apple/usr/bin /usr/local/aria2/bin"

        # set -g -x PATH $fish_user_paths

        set -g os macOS
        # This seems to get color highlighting working in tree command
        set -x LS_COLORS 'rs=0:di=36:ln=32:mh=00:pi=33:so=33:do=33:bd=00:cd=00:or=05;36:mi=04;93:su=31:sg=31:ca=00:tw=36:ow=36:st=36:ex=031:*.tar=00:*.tgz=00:*.arc=00:*.arj=00:*.taz=00:*.lha=00:*.lz4=00:*.lzh=00:*.lzma=00:*.tlz=00:*.txz=00:*.tzo=00:*.t7z=00:*.zip=00:*.z=00:*.dz=00:*.gz=00:*.lrz=00:*.lz=00:*.lzo=00:*.xz=00:*.zst=00:*.tzst=00:*.bz2=00:*.bz=00:*.tbz=00:*.tbz2=00:*.tz=00:*.deb=00:*.rpm=00:*.jar=00:*.war=00:*.ear=00:*.sar=00:*.rar=00:*.alz=00:*.ace=00:*.zoo=00:*.cpio=00:*.7z=00:*.rz=00:*.cab=00:*.wim=00:*.swm=00:*.dwm=00:*.esd=00:*.jpg=00:*.jpeg=00:*.mjpg=00:*.mjpeg=00:*.gif=00:*.bmp=00:*.pbm=00:*.pgm=00:*.ppm=00:*.tga=00:*.xbm=00:*.xpm=00:*.tif=00:*.tiff=00:*.png=00:*.svg=00:*.svgz=00:*.mng=00:*.pcx=00:*.mov=00:*.mpg=00:*.mpeg=00:*.m2v=00:*.mkv=00:*.webm=00:*.ogm=00:*.mp4=00:*.m4v=00:*.mp4v=00:*.vob=00:*.qt=00:*.nuv=00:*.wmv=00:*.asf=00:*.rm=00:*.rmvb=00:*.flc=00:*.avi=00:*.fli=00:*.flv=00:*.gl=00:*.dl=00:*.xcf=00:*.xwd=00:*.yuv=00:*.cgm=00:*.emf=00:*.ogv=00:*.ogx=00:*.aac=00:*.au=00:*.flac=00:*.m4a=00:*.mid=00:*.midi=00:*.mka=00:*.mp3=00:*.mpc=00:*.ogg=00:*.ra=00:*.wav=00:*.oga=00:*.opus=00:*.spx=00:*.xspf=00:;'navi widget fish | source
    case Linux
        set -g os Linux
        # set -U fish_user_paths "/home/ops/.local/bin /opt/local/bin /opt/local/sbin /usr/local/opt/fzf/bin /usr/local/bin /usr/bin /usr/local/sbin /bin /usr/sbin /sbin /usr/local/opt/curl/bin /opt/local/bin /usr/local/bin"
        fish_add_path "/home/ops/.local/bin /opt/local/bin /opt/local/sbin /usr/local/opt/fzf/bin /usr/local/bin /usr/bin /usr/local/sbin /bin /usr/sbin /sbin /usr/local/opt/curl/bin /opt/local/bin /usr/local/bin"
        # set -U fish_user_paths "~/.local/bin:/opt/local/bin:/opt/local/sbin:/usr/local/opt/fzf/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/bin:/usr/sbin:/sbin:/usr/local/opt/curl/bin:/opt/local/bin:/usr/local/bin"
        # set -g -x PATH $PATH
        # Alias FD for FZF
        # alias fd="fdfind"
        #        alias fd="fdfind"
        set -Ux EDITOR nvim

        #function fish_greeting
        #    /bin/cat /run/motd.dynamic
        #end
        # tmux_attach
end

# iterm
test -e {$HOME}/.iterm2_shell_integration.fish; and source {$HOME}/.iterm2_shell_integration.fish

# set -g fish_user_paths "/usr/local/opt/python@3.8/bin" $fish_user_paths
