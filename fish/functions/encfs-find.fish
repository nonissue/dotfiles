function encfs-find -a filename location
    pushd .
    if test -n "$filename"
        set TARGET $filename
    else
        echo "filename required!"
        return
    end

    if test -n "$location"
        cd "/mnt/media/remote/$location"
        # set -l location "/mnt/media/remote/$location"
        set TARGET $filename
	# set pwd "/mnt/media/$location"
    else
    	# set pwd "/mnt/media/remote/movies"
        cd "/mnt/media/remote"
    end
    echo $TARGET in (pwd)
    # cd $pwd
    # set maxdepth to 1?
    find */ -name "$TARGET*" -exec echo \n{} \; -exec encfsctl encode --extpass="echo $ENCFS_PW" /mnt/media/.remote {} \;
    popd


end
