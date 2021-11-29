function encfs-find -a filename location
    # example:
    # encfs-find '*Shield*' tv
    #
    # Result:
    # ...
    # The Shield (2002)/Season 1/The Shield - 1x10 - Dragonchasers WEBDL-1080p.mkv
    # N1OZiQT3-1dbedk5UdMi2QoKA04cf,o3YN1T2Bhydwts9-/llSVrXgzZvyB1CMTclauYXHd/iEws6cR0oU2JW2fln7ehNURiTnCOfe-wQbIttGFZQb9AKQSSl5xOg8Dx5H9kek-w9iRY6Z7hAUYLciRrdKSHVHJ,
    # ...

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
        cd /mnt/media/remote
    end
    echo $TARGET in (pwd)
    # cd $pwd
    # set maxdepth to 1?
    find */ -name "$TARGET*" -exec echo \n{} \; -exec encfsctl encode --extpass="echo $ENCFS_PW" /mnt/media/.remote {} \;
    popd
end
