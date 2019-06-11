# Todo:
# * [ ] implement forced mode properly
# * [ ] combine printf statements / optimize
# * [ ] add --help opt
# * [ ] check for content on remote before deleting? 

# * use a code block (`begin?`) to rediect all output to a file rather than doing it many times

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
# -d or --debug : enables debug mode
# -t or --time : optional : accepts int (1-99) : sets age threshold for deleting files
# -f or --force : runs command without any prompts
function fdel --description "Delete files older than X days."
    echo (pwd)
    pushd .
    cd /mnt/media/local

    begin
        set sep "---------------------------------------------"
        set timestamp (date +"%y-%m-%d %T")
        set logpath "/home/ops/logs/fdel1.log"

        printf "\n  %s\n" $timestamp | tee -a $logpath

        # config for parsing command line args
        set -l options 't/time=!_validate_int --min 1 --max 99' 'f/force' 'd/debug'
        argparse -n fdel $options -- $argv

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
            printf "\n=============================================\n\n  Look for files and folders\n  older than %s days (default)?\n\n" $time

            # confirm user wants to continue with default time value
            if not read_confirm
                printf "\n  Exiting...\n\n%s\n\n" $sep
                return 1
            end

            printf "\n  Continuing...\n"

        end

        # print debug mode if param passed
        if set -q _flag_d
            printf "\n=============================================\n\n  Debug Mode\n  * _flag_f: %s\n  * _flag_t: %s\n  * time: %s\n" $_flag_f $_flag_t $time | tee -a $logpath
        end

        # print description
        printf "\n%s\n\n  Finding dirs & files\n  older than %s days old\n\n" $sep $time | tee -a $logpath

        # find our files
        # this used to just return file name with no path,
        # but we use path to remove it later
        set file_list (find . -type f -mtime +$time -printf "%p\n")

        if [ -n "$file_list" ]

            printf "  Found the following files to delete: \n\n"

            for file in $file_list
                echo "  "$file
            end

            printf "\n"

            # get user confirmation before continuing
            if read_confirm
                printf "\n  Deleting files...\n" | tee -a $logpath
                for file in $file_list
                    rm "$file"
                    printf "Deleted %s" $file | tee -a $logpath
                end
            else
                printf "\n  * File deletion skipped by user...\n" | tee -a $logpath
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

            if read_confirm

                printf "\nDeleting folders...\n" | tee -a $logpath

                for dir in $dir_list
                    echo $dir >>$logpath
                end

                find /mnt/media/local -type d -empty -mtime +$time -delete

            end
        else
            printf "  * No folders found to delete...\n\n  Finished!\n" | tee -a $logpath
        end

        printf "\n%s\n\n" $sep | tee -a $logpath
    end | tee -a $logpath
    #
    popd
    echo (pwd)
end

