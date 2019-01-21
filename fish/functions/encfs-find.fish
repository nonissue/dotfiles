function encfs-find -a filename location
    pushd .
    if test -n "$filename"
        set TARGET $filename
    else 
        echo "filename required!"
        return
    end

    if test -n "$location"
        cd "/mnt/media/$location"
        # set -l location "/mnt/media/$location"
        set TARGET $filename
    else
        cd "/mnt/media/remote"
    end
    echo $TARGET in (pwd)
    # set maxdepth to 1?
    find */ -name "$TARGET*" -exec echo \n{} \; -exec encfsctl encode --extpass='echo $ENCFS_PW' /mnt/media/.remote/whatson3/media/ {} \;
    popd
end

