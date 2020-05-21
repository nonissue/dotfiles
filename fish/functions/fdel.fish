# -------------------------------------------------------------------
# Function: fdel
# Author: Andy Williams (https://github.com/nonissue)
# -------------------------------------------------------------------
# Description: 
#   Simple utility for find, listing, and deleting files
#   older than a specified date (which is passed in using opts)
#
# Opts:
#   -v, --verbose       (optional) enables debug mode
#   -d, --directory     (optional) accepts path to dir, defaults to a local dir for me
#   -t, --time          (optional) specify age in days of files to delete (1-99)
#   -f, --force         (optional) runs command without any prompts, use with caution
#
# Features:
#   - Removes files first, and then dirs
#   - Lists files and folders, prompts to confirm delete is intended
#   - Lists diskspace reclaimed 
#
# Notes:
#   - This is not currently portable, it uses paths specific to my server
#   for logs and target directories, but they could be easily changed
#   - I'm not responsible if all your stuff evaporates. I've been using it
#   without issue for over a year, but YMMV ¯\_(ツ)_/¯. Do contact me
#   if you find a bug though (or open an issue)
#
# Todo:
#   - [ ] implement forced mode properly
#   - [ ] combine printf statements / optimize
#   - [ ] add --help opt
#   - [ ] check for content on remote before deleting? 
#   - [x] show how much space is freed
#
# -------------------------------------------------------------------

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
function fdel --description "Delete files older than X days."

    #begin
    set sep1 "============================================="
    set sep2 "---------------------------------------------"
    set timestamp (date +"%y-%m-%d %T")
    set logpath "/home/ops/logs/fdel1.log"
    set start_dir (pwd)
    set initial_space (du -hs /mnt/media/local | grep -o -E '[0-9]+')
    pushd .

    printf "\n%s\n\n  %s\n" $sep1 $timestamp | tee -a $logpath

    # config for parsing command line args
    set -l options 't/time=!_validate_int --min 1 --max 99' 'f/force' 'v/verbose' 'd/directory='
    argparse -n fdel $options -- $argv

    if set -q _flag_d
        if test -d $_flag_d
            set base_dir $_flag_d
            cd $base_dir
        else
            echo "invalid directory specified"
            return 1
        end
    else
        set _flag_d false
        set base_dir '/mnt/media/local'
        cd $base_dir
    end
    # set time to default value.
    # it will be overwritten if user passes valid param
    set -l time 5

    # set _flag_f to boolean value if it is passed
    # note: must be a better way.. no ternary in fish
    if set -q _flag_f
        set _flag_f true
    else
        set _flag_f false
    end

    # if -t flag param passed, set it
    if set -q _flag_t
        set time $_flag_t
    else
        set -e _flag_t
        set _flag_t "not set"
        printf "\n%s\n\n  Look for files and folders\n  older than %s days (default)?\n\n" $sep2 $time

        # confirm user wants to continue with default time value
        if not read_confirm
            printf "\n  Exiting...\n\n%s\n\n" $sep1
            return 1
        end

        printf "\n  Continuing...\n"

    end

    # print debug mode if param passed
    if set -q _flag_v
        printf "\n%s\n\n  Verbose Mode\n  * _flag_f: %s\n  * _flag_t: %s\n  * _flag_d: %s\n  * time: %s\n  * base_dir: %s\n  * start_dir: %s\n" $sep2 $_flag_f $_flag_t $_flag_d $time $base_dir $start_dir | tee -a $logpath
    end

    # print description
    printf "\n%s\n\n  Finding dirs & files\n  older than %s days old\n\n" $sep2 $time | tee -a $logpath

    # find our files
    # this used to just return file name with no path,
    # but we use path to remove it later
    set file_list (find . -type f -mtime +$time -print)

    if [ -n "$file_list" ]
        if [ $_flag_f = true ]
            printf "\n[dryrun/auto] Deleting files...\n" | tee -a $logpath
            for file in $file_list
                # this prints the proper absolute file path and logs it
                # assumes relative path is ./[movies|tv]/[movie|tvshow]
                printf "%s/%s\n" $base_dir (echo $file | cut -d'/' -f2-) | tee -a $logpath
            end
        else

            printf "  Found the following files to delete: \n\n"

            for file in $file_list
                # show shorter file path (m for movies, t for tv)
                printf "  %s/%s\n" (echo $file | cut -d'/' -f2 | cut -b 1) (basename $file) | tee -a $logpath
            end

            # get user confirmation before continuing
            if read_confirm
                printf "\n  Deleting files...\n" | tee -a $logpath
                for file in $file_list
                    rm "$file"
                    #printf "Deleted %s" (basename $file) | tee -a $logpath
                end
            else
                printf "\n  * File deletion skipped by user...\n" | tee -a $logpath
            end
        end
    else
        echo "  * No files found to delete..." | tee -a $logpath
    end

    set dir_list (find /mnt/media/local -type d -mtime +$time -empty -printf "%p\n")

    if [ -n "$dir_list" ]
        printf "  Found the following dirs to delete: \n"

        for dir in $dir_list
            echo $dir
        end

        if [ $_flag_f = true ]

            for dir in $dir_list
                echo "[dryrun/auto]" $dir | tee -a $logpath
                #rm -f $dir
            end
        else
            if read_confirm

                printf "\nDeleting folders...\n" | tee -a $logpath

                for dir in $dir_list
                    echo $dir >>$logpath
                end

                find /mnt/media/local -type d -empty -mtime +$time -delete
            end
        end
    else
        printf "  * No folders found to delete...\n\n  Finished!\n" | tee -a $logpath
    end
    set final_space (du -hs /mnt/media/local | grep -o -E '[0-9]+')
    set freed_space (math $initial_space - $final_space)
    printf "\n  Space freed: %sGB\n" $freed_space | tee -a $logpath

    printf "\n%s\n" $sep1 | tee -a $logpath



    popd
    printf "\n  Returned to starting directory:\n  %s\n\n" (pwd)
    #echo ""
end

