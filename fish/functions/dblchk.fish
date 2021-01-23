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

# CMD: 
# find /mnt/media/local/tv/ -type f -size +16000c -exec du -s {} \; | xargs -L 1 | string split -m1 " "

# Output: 
# 1156328
# /mnt/media/local/tv/This Old House/Season 42/This Old House - 42x11 - Design Elements WEBDL-1080p.mkv

# find /mnt/media/local/tv/ -type f -size +16000c -exec du -hs {} +

# find /mnt/media/local/tv/ -type f -size +16000c -printf '%p\n' | xargs -L 1 -d '\n' du -s


# find /mnt/media/local/tv/ -type f -size +16000c -printf "%k\0%p\n" | xargs -0 | xargs -L 1 | while read -lt first second
#     echo (string sub -l 6 $first)
# end

# Output
# 322190
# 731108
# 161122
# 186248
# 169668
# 184653
# 176642
# 186408
# 188000
# 189540
# 197701
# 183908
# 208960
# 651060
# 120462
# 265600
# 798960
# 183029

set test1 (find /mnt/media/remote/tv/Central\ Park/ -type f -size +16000c -printf "%k %p\n" | sort | xargs -L 1 | while read -lt first second
  math "floor(($first + 50) / 100 ) * 100"
end)
set test2 (find /mnt/media/remote/tv/Central\ Park/ -type f -size +16000c -printf "%k %p\n" | sort | xargs -L 1 | while read -lt first second
   math "floor(($first + 50) / 100 ) * 100"
end)
diff (echo $test1 | psub) (echo $test2 | psub)


# DAMN this is all i fucking needed jfc
find /mnt/media/local -type f -printf "%p\n" | string replace "local" "remote" | xargs -L 1 -d '\n' | while read -lt remotepath
    if not test -e $remotepath
        echo (set_color red)"FAIL: "$remotepath(set_color normal)
    else
        # echo "PASS: "$remotepath
    end

end

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

set res (find /mnt/media/local -type f -printf "%p\n" | string replace "local" "remote" | xargs -L 1 -d '\n' | while read -lt remotepath    if not test -e $remotepath        echo (set_color red)"FAIL: "(set_color yellow)$remotepath(set_color normal)    else        # echo "PASS: "$remotepath    endend | nl -b a -w3 -nrz -s.' ' | string collect)
echo $res
echo $res | count

# could also do 
# 1) get local file path
# 2) replace `local` with `remote` in path
# 3) check if new file exists? lol way easier


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
# for files
# -t or --time : optional : accepts int (1-99) : sets age threshold for deleting files
# -f or --force : runs command without any prompts
function dblchk --description "Check a dir and all its files exist in a dir in a different file branch"

    # Files are in folder: (source)
    # And should be in holder: (destination)

    #begin
    set sep1 "============================================="
    set sep2 "---------------------------------------------"
    set timestamp (date +"%y-%m-%d %T")
    set logpath "/home/ops/logs/dblchk.log"

    printf "\n%s\n\n  %s\n" $sep1 $timestamp | tee -a $logpath

    # config for parsing command line args
    set -l options 'v/verbose' 's/source=' 'd/destination= t/time=!_validate_int'
    argparse -n fdel $options -- $argv

    if set -q _flag_s
        if test -d $_flag_s
            set source_dir $_flag_s
            cd $source_dir
        else
            echo "invalid source directory specified"
            return 1
        end
    else
        echo "You must specify a source directory"
        return 1
    end

    if set -q _flag_d
        if test -d $_flag_d
            set dest_dir $_flag_d
            cd $dest_dir
        else
            echo "invalid destination directory specified"
            return 1
        end
    else
        echo "You must specify a destination directory"
        return 1
        # set _flag_d false
        # set base_dir '/mnt/media/local'
        # cd $base_dir
    end

    set -l time 5

    if set -q _flag_t
        set time $_flag_t
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
        printf "\n%s\n\n  Verbose Mode\n  * _flag_s: %s\n  * _flag_d: %s\n" $sep2 $_flag_s $_flag_d | tee -a $logpath
    end

    # print description

end

