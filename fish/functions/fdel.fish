# Todo:
# * [ ] implement forced mode properly
# * [ ] combine printf statements / optimize
# * [ ] add --help opt


function read_confirm  --description 'Ask the user for confirmation' --argument prompt
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
    set sep "---------------------------------------------"
    set timestamp (date)
    
    set logpath "/home/ops/logs/fdel.log"

    set -l options 't/time=!_validate_int --min 1 --max 99' 'f/force' 'd/debug'
    argparse -n fdel $options -- $argv

    set -l time 5 

    if set -q _flag_f
	    set _flag_f true
    else 
	    set _flag_f false
    end

    if set -q _flag_t
        set time $_flag_t
    else
		set -e _flag_t
		set _flag_t "not set"
		printf "\n=============================================\n\n  Look for files and folders\n  older than %s days (default)?\n\n" $time

		if not read_confirm
   			echo "  Exiting..."
			return 1 
		end

		printf "\n  Continuing...\n"

    end

    if set -q _flag_d
		printf "\n=============================================\n\n  Debug Mode\n"
		printf "  * _flag_f: %s\n" $_flag_f
		printf "  * _flag_t: %s\n" $_flag_t
		echo "  * time: $time"
    end

    printf "\n%s\n\n  %s\n  Deleting files and empty folders \n  older than %s days old\n\n" $sep $timestamp $time | tee $logpath 

    set file_list (find /mnt/media/local -type f -mtime +$time -printf "%f\n")

    if [ -n "$file_list" ]

    	printf "  Found the following files to delete: \n\n"
    		
    	for file in $file_list
	    	echo "  "$file
    	end

		printf "\n"

		if read_confirm
        	printf "\n  Deleting files...\n" | tee $logpath
    		for file in $file_list
				echo " $file" >> $logpath
			end
			find /mnt/media/local -type f -mtime +$time -delete
		else
			printf "\n\n  File deletion skipped by user\n" | tee $logpath
		end
    else
		echo "  * No files found to delete..." | tee $logpath
    end

    set dir_list (find /mnt/media/local -type d -mtime +$time -empty -printf "%f\n")
    
    if [ -n "$dir_list" ]
  
    	printf "  Found the following dirs to delete: \n"

    	for dir in $dir_list
	    	echo $dir
    	end

		if read_confirm

			printf "\nDeleting folders...\n" | tee $logpath

			for dir in $dir_list
				echo $dir >> $logpath
			end

			find /mnt/media/local -type d -empty -mtime +$time -delete
			
		end
    else
	    printf "\n  * No folders found to delete...\n  Finished!\n\n" | tee $logpath
    end

    printf "\n%s\n\n" $sep | tee $logpath

end
