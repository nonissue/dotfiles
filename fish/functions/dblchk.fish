# -------------------------------------------------------------------
# Function: dblchk
# Author: Andy Williams (https://github.com/nonissue)
# -------------------------------------------------------------------
#
# Description: 
# 
# Opts:
#
# Features:
#
# Notes:
#
# Todo:
#   - [ ] figure out how to handle log path
#   - [ ] actually log results
#   - [ ] figure out how to let user set local/remote default dirs
#   - [ ] cleanup
#
# -------------------------------------------------------------------

# confirmation prompt for user
function read_confirm --description 'Ask the user for confirmation' --argument prompt
    if test -z "$prompt"
        set prompt "Continue? [y/n]"
    end

    while true
        read -p 'printf "  %s\n  >  \n" $prompt' confirm

        switch $confirm
            case Y y
                return 0
            case '' N n
                return 1
        end
    end
end

# opts:
# -v or --verbose : enables debug mode
# -s or --source : optional : list of files to check for
# -d or --destinaiton : optional : where to check for them
# -t or --time : optional : accepts int (-99 - 99) : sets age threshold for checking for files
#   - eg: -1 checks for source dir files modified in the last day 
function dblchk --description "Check a dir and all its files exist in a dir in a different file branch"
    set sep1 "============================================="
    set sep2 "---------------------------------------------"
    set timestamp (date +"%y-%m-%d %T")
    set logpath "/home/ops/logs/dblchk.log"

    printf "\n%s\n\n  %s\n" $sep1 $timestamp | tee -a $logpath

    # command line arg parsing (see above)
    set -l options 'v/verbose' 's/source=' 'd/destination=' 't/time=!_validate_int --min -99 --max 99'
    argparse -n dblchk $options -- $argv

    if set -q _flag_s
        if test -d $_flag_s
            set source_dir $_flag_s
        else
            echo "  Invalid source directory specified"
            echo $_flag_s
            return 1
        end
    else
        echo "  No source dir specified, using default: "
        set _flag_s 'undefined'
        set source_dir '/mnt/media/remote'

        if not test -d $source_dir
            echo (set_color red)"  ERROR: Can't find default source dir!"
            echo (set_color yellow)"  Are you sure you're on the right machine?"(set_color normal)
            printf "\n%s\n\n" $sep1
            return 1
        end

        echo "  "$source_dir
    end

    if set -q _flag_d
        if test -d $_flag_d
            set dest_dir $_flag_d
        else
            echo "  Invalid destination directory specified"
            return 1
        end
    else
        echo "  No destination dir specified, using default: "
        set _flag_d 'undefined'
        set dest_dir '/mnt/media/remote'

        if not test -d $dest_dir
            echo (set_color red)"  ERROR: Can't find default destination dir!"
            echo (set_color yellow)"  Are you sure you're on the right machine?"(set_color normal)
            printf "\n%s\n\n" $sep1
            return 1
        end

        echo "  "$dest_dir
    end

    # set default time to 5 days
    set -l time +5

    if set -q _flag_t
        if [ $_flag_t -gt 0 ]
            set time +$_flag_t
        else
            set time $_flag_t
        end
        echo "  Looking for files with age "$time" day(s)"
    else
        set -e _flag_t
        set _flag_t "not set"
        printf "\n%s\n\n Check for local files not yet synced over %s days old?\n\n" $sep2 $time

        if not read_confirm
            printf "\n  Exiting...\n\n%s\n\n" $sep1
            return 1
        end

        printf "\n  Continuing...\n"

    end

    # print debug mode if param passed
    if set -q _flag_v
        printf "\n%s\n\n  Verbose Mode\n  * _flag_s: %s\n  * _flag_d: %s\n  * _flag_t: %s\n" $sep2 $_flag_s $_flag_d $_flag_t | tee -a $logpath
    end

    # res = files that don't exist on remote
    set -x res (find /mnt/media/local -type f -mtime $time -printf "%p\n" | string replace "local" "remote" | xargs -L 1 -d '\n' | while read -lt remotepath
        if not test -e $remotepath
            printf (set_color red)"\nNOT SYNCED: "(set_color yellow)" %s"(set_color normal) $remotepath | string replace "remote" "local"
        end
    end | nl -bt -s.' ' | string collect)

    # synced = files that do exist on the remote
    set -x synced (find /mnt/media/local -type f -mtime $time -printf "%p\n" | string replace "local" "remote" | xargs -L 1 -d '\n' | while read -lt remotepath
        if test -e $remotepath 
            printf (set_color green)"\nSYNCED: "(set_color blue)" %s"(set_color normal) $remotepath | string replace "remote" "local"
        end
    end | nl -bt -s.' ' | string collect)
    
    
    if [ (printf "%s" $res | nl | count) -ge 1 ]
        # output which files aren't synced yet
        echo " "
        echo "  "(printf "%s" $res | nl -bt | count ) "file(s) not synced!"
        echo $res

        
        if set -q _flag_v
            # in verbose mode, print files that ARE synced as well
            echo " "
            echo "  "(printf "%s" $synced | nl -bt | count ) "file(s) synced!"
            echo $synced
        end
    else
        echo " "
        echo (set_color green)"  No unsynced files found"(set_color normal)
    end


    printf "\n%s\n\n" $sep1
end

