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
#
# -------------------------------------------------------------------

# FUCK YAH DUDE, this is it
function diff_paths
    set -l res (find /mnt/media/local -type f -printf "%p\n" | string replace "local" "remote" | xargs -L 1 -d '\n' | while read -lt remotepath
        if not test -e $remotepath
            echo (set_color red)"FAIL: "(set_color yellow)$remotepath(set_color normal)
        end
    end | nl -b a -w3 -nrz -s.' ' | string collect)
    echo $res
    echo (echo $res | count) "files not synced"
    # do sometihng here like if count == 0, we

    if [ (echo $res | count) -ge 1 ]
        echo "BE CAREFUL before proceeding"
    else
        echo "Go nuts."
    end
end

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
# -d or --directory : optional : accepts path ro dir : sets base dir to search
# -d or --directory : optional : accepts path ro dir : sets base dir to search
# for files
# -t or --time : optional : accepts int (1-99) : sets age threshold for deleting files
function dblchk --description "Check a dir and all its files exist in a dir in a different file branch"

    # Files are in folder: (source)
    # And should be in holder: (destination)

    set sep1 "============================================="
    set sep2 "---------------------------------------------"
    set timestamp (date +"%y-%m-%d %T")
    set logpath "/home/ops/logs/dblchk.log"

    printf "\n%s\n\n  %s\n" $sep1 $timestamp | tee -a $logpath

    # config for parsing command line args
    set -l options 'v/verbose' 's/source=' 'd/destination=' 't/time=!_validate_int --min -99 --max 99'
    argparse -n dblchk $options -- $argv

    if set -q _flag_s
        if test -d $_flag_s
            set source_dir $_flag_s
            cd $source_dir
        else
            echo "  Invalid source directory specified"
            echo $_flag_s
            return 1
        end
    else
        echo "  No source dir specified, using default: " 
        set source_dir '/mnt/media/local'
        echo "  "$source_dir 
        set _flag_s 'undefined'
        # return 1
    end

    if set -q _flag_d
        if test -d $_flag_d
            set dest_dir $_flag_d
            cd $dest_dir
        else
            echo "  Invalid destination directory specified"
            return 1
        end
    else

        echo "  No destination dir specified, using default: "
        set _flag_d 'undefined'
        set dest_dir '/mnt/media/remote'
        echo "  "$dest_dir
    end

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

        # confirm user wants to continue with default time value
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

    # print description
    set -x res (find /mnt/media/local -type f -mtime $time -printf "%p\n" | string replace "local" "remote" | xargs -L 1 -d '\n' | while read -lt remotepath
        if not test -e $remotepath
            printf (set_color red)"NOT SYNCED: "(set_color yellow)" %s"(set_color normal) $remotepath | string replace "remote" "local"
        else 
            # printf (set_color green)"SYNCED: "(set_color blue)" %s"(set_color normal) $remotepath | string replace "remote" "local"
            # echo (set_color green)"SYNCED: "(set_color blue)(echo $remotepath | string replace "remote" "local")(set_color normal)
        end
    end | nl -bt -s.' ' | string collect)

    set -x synced (find /mnt/media/local -type f -mtime $time -printf "%p\n" | string replace "local" "remote" | xargs -L 1 -d '\n' | while read -lt remotepath
        if not test -e $remotepath
            # printf (set_color red)"NOT SYNCED: "(set_color yellow)" %s"(set_color normal) $remotepath | string replace "remote" "local"
        else 
            printf (set_color green)"SYNCED: "(set_color blue)" %s"(set_color normal) $remotepath | string replace "remote" "local"
            # echo (set_color green)"SYNCED: "(set_color blue)(echo $remotepath | string replace "remote" "local")(set_color normal)
        end
    end | nl -bt -s.' ' | string collect)
    
    if [ (printf "%s" $res | nl | count) -ge 1 ]
        echo " "
        echo "  "(printf "%s" $res | nl -bt | count ) "file(s) not synced!"
        echo $res

        if set -q _flag_v
            echo " "
            echo "  "(printf "%s" $synced | nl -bt | count ) "file(s) synced!"
            echo $synced
        end
    else
        echo "  No unsynced files found"
    end


    printf "\n%s\n\n" $sep1
end

